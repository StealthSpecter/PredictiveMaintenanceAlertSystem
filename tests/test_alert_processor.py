import unittest
from datetime import datetime
import time
import uuid
import threading

from models.prediction import Prediction
from models.alert import Alert, AlertSeverity, AlertStatus
from alert_generator import AlertGenerator
from alert_processor import AlertProcessor
from utils.logger import get_logger

# Silence loggers during tests
logger = get_logger(__name__)
logger.setLevel(40)  # ERROR level


class TestAlertProcessor(unittest.TestCase):
    """
    Test cases for the AlertProcessor class.
    """
    
    def setUp(self):
        """Set up AlertGenerator and AlertProcessor instances before each test."""
        self.alert_generator = AlertGenerator()
        self.alert_processor = AlertProcessor()
    
    def tearDown(self):
        """Clean up after each test."""
        if self.alert_processor._running:
            self.alert_processor.stop()
    
    def test_processor_start_stop(self):
        """Test that the processor can be started and stopped correctly."""
        # Initially should not be running
        self.assertFalse(self.alert_processor._running)
        self.assertIsNone(self.alert_processor._processor_thread)
        
        # Start the processor
        self.alert_processor.start()
        self.assertTrue(self.alert_processor._running)
        self.assertIsNotNone(self.alert_processor._processor_thread)
        self.assertTrue(self.alert_processor._processor_thread.is_alive())
        
        # Stop the processor
        self.alert_processor.stop()
        self.assertFalse(self.alert_processor._running)
        time.sleep(0.1)  # Give thread time to stop
        self.assertFalse(self.alert_processor._processor_thread.is_alive())
    
    def test_add_and_process_alert(self):
        """Test that alerts can be added to the processor and processed."""
        # Create a test alert
        alert = Alert(
            alert_id=str(uuid.uuid4()),
            equipment_id="equip-007",
            prediction_id=str(uuid.uuid4()),
            timestamp=datetime.now(),
            severity=AlertSeverity.HIGH,
            message="Test alert for processing",
            status=AlertStatus.PENDING
        )
        
        # Add a notification channel for testing
        test_results = {"alerts_processed": 0}
        
        def mock_channel_handler(alert):
            test_results["alerts_processed"] += 1
            test_results["last_alert"] = alert
        
        self.alert_processor._notification_handlers = [mock_channel_handler]
        
        # Start the processor
        self.alert_processor.start()
        
        # Add the alert
        self.alert_processor.add_alert(alert)
        
        # Wait for processing
        time.sleep(0.5)
        
        # Check that the alert was processed
        self.assertEqual(test_results["alerts_processed"], 1, "Alert should be processed")
        self.assertEqual(test_results["last_alert"], alert, "Correct alert should be processed")
        
        # Stop the processor
        self.alert_processor.stop()
    
    def test_multiple_alerts_processing(self):
        """Test that multiple alerts can be processed correctly."""
        # Create multiple test alerts
        alerts = []
        for i in range(5):
            alerts.append(Alert(
                alert_id=f"alert-{i}",
                equipment_id=f"equip-{i}",
                prediction_id=f"pred-{i}",
                timestamp=datetime.now(),
                severity=AlertSeverity.HIGH if i % 2 == 0 else AlertSeverity.MEDIUM,
                message=f"Test alert {i}",
                status=AlertStatus.PENDING
            ))
        
        # Add a notification channel for testing
        processed_alerts = []
        
        def mock_channel_handler(alert):
            processed_alerts.append(alert)
        
        self.alert_processor._notification_handlers = [mock_channel_handler]
        
        # Start the processor
        self.alert_processor.start()
        
        # Add the alerts
        for alert in alerts:
            self.alert_processor.add_alert(alert)
        
        # Wait for processing
        time.sleep(0.5)
        
        # Check that all alerts were processed
        self.assertEqual(len(processed_alerts), len(alerts), 
                         "All alerts should be processed")
        
        # Verify the IDs of processed alerts match our input alerts
        processed_ids = [a.alert_id for a in processed_alerts]
        input_ids = [a.alert_id for a in alerts]
        self.assertSetEqual(set(processed_ids), set(input_ids), 
                           "All input alerts should be processed")
        
        # Stop the processor
        self.alert_processor.stop()
