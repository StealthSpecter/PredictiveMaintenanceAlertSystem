import threading
import uuid
from datetime import datetime
from typing import Dict, List, Optional

from models.alert import Alert, AlertSeverity, AlertStatus
from models.prediction import Prediction
from utils.config import THRESHOLD_HIGH, THRESHOLD_MEDIUM, THRESHOLD_LOW, MSG_HIGH, MSG_MEDIUM, MSG_LOW
from utils.logger import get_logger

logger = get_logger(__name__)


class AlertGenerator:
    """
    Generates alerts based on equipment failure predictions.
    
    This class is responsible for analyzing predictions and generating
    appropriate alerts when thresholds are exceeded.
    """
    
    def __init__(self):
        self._lock = threading.Lock()
        self._alerts: Dict[str, Alert] = {}
        
    def process_prediction(self, prediction: Prediction) -> Optional[Alert]:
        """
        Process a prediction and generate an alert if thresholds are exceeded.
        
        Args:
            prediction: The prediction to process
            
        Returns:
            The generated alert if thresholds are exceeded, None otherwise
        """
        if prediction is None:
            logger.warning("Received None prediction, skipping")
            return None
        
        logger.info(f"Processing prediction {prediction.prediction_id} for equipment {prediction.equipment_id}")
        
        # Use a lock to prevent race conditions during alert generation
        with self._lock:
            # Skip if we already generated an alert for this prediction
            if self._has_alert_for_prediction(prediction.prediction_id):
                logger.info(f"Alert already exists for prediction {prediction.prediction_id}")
                return None
                
            # Determine if alert should be generated
            if prediction.failure_probability >= THRESHOLD_HIGH:
                severity = AlertSeverity.HIGH
                message = MSG_HIGH.format(hours=prediction.time_to_failure)
            elif prediction.failure_probability >= THRESHOLD_MEDIUM:
                severity = AlertSeverity.MEDIUM
                message = MSG_MEDIUM.format(hours=prediction.time_to_failure)
            elif prediction.failure_probability >= THRESHOLD_LOW:
                severity = AlertSeverity.LOW
                message = MSG_LOW.format(hours=prediction.time_to_failure)
            else:
                # No alert needed
                logger.info(f"No alert needed for prediction {prediction.prediction_id} (probability: {prediction.failure_probability:.2f})")
                return None
                
            # Generate the alert
            alert = Alert(
                alert_id=str(uuid.uuid4()),
                equipment_id=prediction.equipment_id,
                prediction_id=prediction.prediction_id,
                timestamp=datetime.now(),
                severity=severity,
                message=message,
                status=AlertStatus.PENDING
            )
            
            # Store the alert
            self._alerts[alert.alert_id] = alert
            logger.info(f"Generated {severity.name} alert {alert.alert_id} for equipment {alert.equipment_id}")
            
            return alert
    
    def _has_alert_for_prediction(self, prediction_id: str) -> bool:
        """Check if an alert already exists for a given prediction."""
        return any(alert.prediction_id == prediction_id for alert in self._alerts.values())
    
    def get_alerts(self, equipment_id: Optional[str] = None) -> List[Alert]:
        """Get all alerts, optionally filtered by equipment ID."""
        with self._lock:
            if equipment_id:
                return [a for a in self._alerts.values() if a.equipment_id == equipment_id]
            return list(self._alerts.values())
    
    def get_alert(self, alert_id: str) -> Optional[Alert]:
        """Get a specific alert by ID."""
        with self._lock:
            return self._alerts.get(alert_id)
    
    def update_alert_status(self, alert_id: str, status: AlertStatus) -> bool:
        """Update the status of an alert."""
        with self._lock:
            alert = self._alerts.get(alert_id)
            if not alert:
                return False
            
            # Update the status based on the current state
            if status == AlertStatus.ACKNOWLEDGED and alert.status == AlertStatus.PENDING:
                alert.acknowledge()
                logger.info(f"Alert {alert_id} acknowledged")
                return True
            elif status == AlertStatus.RESOLVED and alert.status in [AlertStatus.PENDING, AlertStatus.ACKNOWLEDGED]:
                alert.resolve()
                logger.info(f"Alert {alert_id} resolved")
                return True
            elif status == AlertStatus.CLOSED:
                alert.close()
                logger.info(f"Alert {alert_id} closed")
                return True
            
            logger.warning(f"Invalid status transition for alert {alert_id}: {alert.status} -> {status}")
            return False
