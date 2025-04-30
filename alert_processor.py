from typing import List, Dict, Any, Optional
import threading
import time

from models.alert import Alert, AlertStatus
from utils.logger import get_logger

logger = get_logger(__name__)


class AlertProcessor:
    """
    Processes alerts for delivery to appropriate channels and handles alert lifecycle.
    
    This class is responsible for:
    1. Delivering alerts to appropriate channels (email, SMS, dashboard, etc.)
    2. Managing alert lifecycle (acknowledgment, resolution, escalation)
    3. Aggregating related alerts to prevent alert fatigue
    """
    
    def __init__(self, notification_channels: Optional[List[Dict[str, Any]]] = None):
        self._lock = threading.Lock()
        self._pending_alerts: List[Alert] = []
        self._notification_channels = notification_channels or []
        self._running = False
        self._processor_thread = None
    
    def add_alert(self, alert: Alert) -> None:
        """Add an alert to the processing queue."""
        if not alert:
            return
            
        with self._lock:
            self._pending_alerts.append(alert)
        logger.info(f"Added alert {alert.alert_id} to processing queue")
    
    def start(self) -> None:
        """Start the alert processor thread."""
        if self._running:
            return
            
        self._running = True
        self._processor_thread = threading.Thread(target=self._process_alerts_loop)
        self._processor_thread.daemon = True
        self._processor_thread.start()
        logger.info("Alert processor started")
    
    def stop(self) -> None:
        """Stop the alert processor thread."""
        self._running = False
        if self._processor_thread:
            self._processor_thread.join(timeout=2.0)
        logger.info("Alert processor stopped")
    
    def _process_alerts_loop(self) -> None:
        """Main processing loop for alerts."""
        while self._running:
            alerts_to_process = []
            
            # Get alerts to process
            with self._lock:
                alerts_to_process = self._pending_alerts.copy()
                self._pending_alerts.clear()
            
            # Process each alert
            for alert in alerts_to_process:
                self._deliver_alert(alert)
            
            # Sleep briefly if no alerts to process
            if not alerts_to_process:
                time.sleep(0.1)
    
    def _deliver_alert(self, alert: Alert) -> None:
        """Deliver an alert to all configured notification channels."""
        if not alert or alert.status != AlertStatus.PENDING:
            return
            
        logger.info(f"Processing alert {alert.alert_id} with severity {alert.severity.name}")
        
        # In a real implementation, this would send notifications to configured channels
        # For now, we'll just log the notification
        for channel in self._notification_channels:
            channel_type = channel.get("type", "unknown")
            logger.info(f"Would send alert {alert.alert_id} via {channel_type} channel")
        
        # If no channels are configured, just log it
        if not self._notification_channels:
            logger.info(f"Alert {alert.alert_id} would be delivered (no channels configured)")
