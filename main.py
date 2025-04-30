import uuid
import time
from datetime import datetime
import random

from models.prediction import Prediction
from alert_generator import AlertGenerator
from alert_processor import AlertProcessor
from utils.logger import get_logger

logger = get_logger("main")

def main():
    """
    Demonstrate the AlertGenerator functionality.
    
    This function creates sample predictions with various probabilities
    and processes them through the AlertGenerator.
    """
    logger.info("Starting Alert Generator demonstration")
    
    # Create instances of our classes
    alert_generator = AlertGenerator()
    alert_processor = AlertProcessor([
        {"type": "email", "recipients": ["maintenance@example.com"]},
        {"type": "sms", "recipients": ["+1234567890"]}
    ])
    
    # Start the alert processor
    alert_processor.start()
    
    # Generate some sample predictions
    equipment_ids = ["pump-101", "valve-203", "compressor-305", "motor-407"]
    failure_types = ["overheat", "vibration", "pressure-loss", "electrical-fault"]
    
    # Process predictions with various probabilities
    logger.info("Generating sample predictions...")
    
    # High probability prediction (should generate alert)
    high_prob_prediction = Prediction(
        prediction_id=str(uuid.uuid4()),
        equipment_id=random.choice(equipment_ids),
        timestamp=datetime.now(),
        failure_probability=0.95,  # 95% - should trigger HIGH alert
        predicted_failure_type=random.choice(failure_types),
        time_to_failure=24  # Hours
    )
    
    # Medium probability prediction (should generate alert)
    medium_prob_prediction = Prediction(
        prediction_id=str(uuid.uuid4()),
        equipment_id=random.choice(equipment_ids),
        timestamp=datetime.now(),
        failure_probability=0.65,  # 65% - should trigger MEDIUM alert
        predicted_failure_type=random.choice(failure_types),
        time_to_failure=72  # Hours
    )
    
    # Low probability prediction (should generate alert)
    low_prob_prediction = Prediction(
        prediction_id=str(uuid.uuid4()),
        equipment_id=random.choice(equipment_ids),
        timestamp=datetime.now(),
        failure_probability=0.35,  # 35% - should trigger LOW alert
        predicted_failure_type=random.choice(failure_types),
        time_to_failure=120  # Hours
    )
    
    # Very low probability prediction (should NOT generate alert)
    very_low_prob_prediction = Prediction(
        prediction_id=str(uuid.uuid4()),
        equipment_id=random.choice(equipment_ids),
        timestamp=datetime.now(),
        failure_probability=0.15,  # 15% - below threshold, no alert
        predicted_failure_type=random.choice(failure_types),
        time_to_failure=240  # Hours
    )
    
    # Duplicate prediction (should only generate one alert)
    duplicate_prediction = high_prob_prediction
    
    # Process the predictions
    logger.info("Processing predictions...")
    
    # Process each prediction and add resulting alerts to the processor
    for prediction in [high_prob_prediction, medium_prob_prediction, 
                      low_prob_prediction, very_low_prob_prediction, 
                      duplicate_prediction]:
        logger.info(f"Processing prediction for {prediction.equipment_id} "
                   f"with probability {prediction.failure_probability:.2f}")
        
        alert = alert_generator.process_prediction(prediction)
        if alert:
            alert_processor.add_alert(alert)
    
    # Show all generated alerts
    logger.info("Generated Alerts:")
    for alert in alert_generator.get_alerts():
        logger.info(f"Alert {alert.alert_id}: {alert.severity.name} - {alert.message}")
    
    # Wait for alert processing to complete
    time.sleep(1)
    
    # Update status of one of the alerts
    if alert_generator.get_alerts():
        alert_to_update = alert_generator.get_alerts()[0]
        logger.info(f"Acknowledging alert {alert_to_update.alert_id}")
        alert_generator.update_alert_status(alert_to_update.alert_id, 
                                          alert_to_update.status.__class__.ACKNOWLEDGED)
    
    # Stop the alert processor
    alert_processor.stop()
    logger.info("Demonstration complete")

if __name__ == "__main__":
    main()
