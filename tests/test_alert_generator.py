import unittest
from datetime import datetime
import uuid
import threading
import time

from models.prediction import Prediction
from models.alert import Alert, AlertSeverity, AlertStatus
from alert_generator import AlertGenerator


class TestAlertGenerator(unittest.TestCase):
    """
    Test cases for the AlertGenerator class.
    """
    
    def setUp(self):
        """Set up a fresh AlertGenerator instance before each test."""
        self.alert_generator = AlertGenerator()
    
    def test_high_probability_alert(self):
        """Test that high probability predictions generate HIGH severity alerts."""
        # Create a test prediction with high failure probability
        prediction = Prediction(
            prediction_id=str(uuid.uuid4()),
            equipment_id="equip-001",
            timestamp=datetime.now(),
            failure_probability=0.95,  # Well above HIGH threshold
            predicted_failure_type="Overheating",
            time_to_failure=48  # Hours
        )
        
        # Process the prediction
        alert = self.alert_generator.process_prediction(prediction)
        
        # Verify an alert was generated
        self.assertIsNotNone(alert, "High probability prediction should generate an alert")
        self.assertEqual(alert.severity, AlertSeverity.HIGH, "Should generate HIGH severity alert")
        self.assertEqual(alert.equipment_id, prediction.equipment_id, "Alert should reference correct equipment")
        self.assertEqual(alert.prediction_id, prediction.prediction_id, "Alert should reference source prediction")
    
    def test_medium_probability_alert(self):
        """Test that medium probability predictions generate MEDIUM severity alerts."""
        # Create a test prediction with medium failure probability
        prediction = Prediction(
            prediction_id=str(uuid.uuid4()),
            equipment_id="equip-002",
            timestamp=datetime.now(),
            failure_probability=0.65,  # Between MEDIUM and HIGH thresholds
            predicted_failure_type="Bearing failure",
            time_to_failure=72  # Hours
        )
        
        # Process the prediction
        alert = self.alert_generator.process_prediction(prediction)
        
        # Verify a MEDIUM alert was generated
        self.assertIsNotNone(alert, "Medium probability prediction should generate an alert")
        self.assertEqual(alert.severity, AlertSeverity.MEDIUM, "Should generate MEDIUM severity alert")
    
    def test_low_probability_alert(self):
        """Test that low probability predictions generate LOW severity alerts."""
        # Create a test prediction with low failure probability
        prediction = Prediction(
            prediction_id=str(uuid.uuid4()),
            equipment_id="equip-003",
            timestamp=datetime.now(),
            failure_probability=0.35,  # Between LOW and MEDIUM thresholds
            predicted_failure_type="Vibration anomaly",
            time_to_failure=120  # Hours
        )
        
        # Process the prediction
        alert = self.alert_generator.process_prediction(prediction)
        
        # Verify a LOW alert was generated
        self.assertIsNotNone(alert, "Low probability prediction should generate an alert")
        self.assertEqual(alert.severity, AlertSeverity.LOW, "Should generate LOW severity alert")
    
    def test_no_alert_for_very_low_probability(self):
        """Test that very low probability predictions don't generate alerts."""
        # Create a test prediction with very low failure probability
        prediction = Prediction(
            prediction_id=str(uuid.uuid4()),
            equipment_id="equip-004",
            timestamp=datetime.now(),
            failure_probability=0.25,  # Below LOW threshold
            predicted_failure_type="Minor wear",
            time_to_failure=240  # Hours
        )
        
        # Process the prediction
        alert = self.alert_generator.process_prediction(prediction)
        
        # Verify no alert was generated
        self.assertIsNone(alert, "Very low probability prediction should not generate an alert")
    
    def test_duplicate_prediction_handling(self):
        """Test that processing the same prediction twice only generates one alert."""
        # Create a test prediction
        prediction = Prediction(
            prediction_id=str(uuid.uuid4()),
            equipment_id="equip-005",
            timestamp=datetime.now(),
            failure_probability=0.85,
            predicted_failure_type="Bearing failure",
            time_to_failure=36
        )
        
        # Process the same prediction twice
        alert1 = self.alert_generator.process_prediction(prediction)
        alert2 = self.alert_generator.process_prediction(prediction)
        
        # Verify first alert was generated but second was not
        self.assertIsNotNone(alert1, "First processing should generate an alert")
        self.assertIsNone(alert2, "Second processing should not generate another alert")
        
        # Verify only one alert was generated for the equipment
        alerts = self.alert_generator.get_alerts(prediction.equipment_id)
        self.assertEqual(len(alerts), 1, "Should only be one alert for the equipment")
    
    def test_alert_status_transitions(self):
        """Test that alert status transitions work correctly."""
        # Create and process a prediction to generate an alert
        prediction = Prediction(
            prediction_id=str(uuid.uuid4()),
            equipment_id="equip-006",
            timestamp=datetime.now(),
            failure_probability=0.90,
            predicted_failure_type="Electrical fault",
            time_to_failure=24
        )
        
        alert = self.alert_generator.process_prediction(prediction)
        self.assertIsNotNone(alert, "Should generate an alert")
        self.assertEqual(alert.status, AlertStatus.PENDING, "Initial status should be PENDING")
        
        # Test status transitions
        result = self.alert_generator.update_alert_status(alert.alert_id, AlertStatus.ACKNOWLEDGED)
        self.assertTrue(result, "Status update should succeed")
        
        updated_alert = self.alert_generator.get_alert(alert.alert_id)
        self.assertEqual(updated_alert.status, AlertStatus.ACKNOWLEDGED, 
                         "Status should be updated to ACKNOWLEDGED")
        
        result = self.alert_generator.update_alert_status(alert.alert_id, AlertStatus.RESOLVED)
        self.assertTrue(result, "Status update should succeed")
        
        updated_alert = self.alert_generator.get_alert(alert.alert_id)
        self.assertEqual(updated_alert.status, AlertStatus.RESOLVED, 
                         "Status should be updated to RESOLVED")
        
        result = self.alert_generator.update_alert_status(alert.alert_id, AlertStatus.CLOSED)
        self.assertTrue(result, "Status update should succeed")
        
        updated_alert = self.alert_generator.get_alert(alert.alert_id)
        self.assertEqual(updated_alert.status, AlertStatus.CLOSED, 
                         "Status should be updated to CLOSED")
    
    def test_concurrent_processing(self):
        """Test that concurrent prediction processing works correctly."""
        # Number of concurrent predictions to process
        num_predictions = 100
        
        # Create predictions with varying probabilities
        predictions = []
        for i in range(num_predictions):
            # Alternate between different probability ranges
            if i % 4 == 0:
                prob = 0.85  # HIGH
            elif i % 4 == 1:
                prob = 0.65  # MEDIUM
            elif i % 4 == 2:
                prob = 0.35  # LOW
            else:
                prob = 0.25  # Below threshold
                
            predictions.append(Prediction(
                prediction_id=f"pred-{i}",
                equipment_id=f"equip-{i % 10}",  # 10 different equipment
                timestamp=datetime.now(),
                failure_probability=prob,
                predicted_failure_type=f"Test failure type {i % 5}",
                time_to_failure=24 + (i % 5) * 24
            ))
        
        # Function to process a prediction in a thread
        def process_prediction(prediction):
            self.alert_generator.process_prediction(prediction)
        
        # Start threads to process predictions concurrently
        threads = []
        for pred in predictions:
            thread = threading.Thread(target=process_prediction, args=(pred,))
            threads.append(thread)
            thread.start()
        
        # Wait for all threads to complete
        for thread in threads:
            thread.join()
        
        # Count predictions that should generate alerts
        expected_alerts = sum(1 for p in predictions if p.failure_probability >= 0.3)
        
        # Get all generated alerts
        all_alerts = self.alert_generator.get_alerts()
        
        # Verify correct number of alerts were generated
        self.assertEqual(len(all_alerts), expected_alerts, 
                         f"Expected {expected_alerts} alerts, got {len(all_alerts)}")
        
        # Verify no duplicate alerts for the same prediction
        prediction_ids = [alert.prediction_id for alert in all_alerts]
        self.assertEqual(len(prediction_ids), len(set(prediction_ids)), 
                         "No duplicate alerts should be generated")
