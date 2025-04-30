from dataclasses import dataclass
from datetime import datetime
from enum import Enum, auto
from typing import Optional, Dict, Any


class AlertSeverity(Enum):
    LOW = auto()
    MEDIUM = auto()
    HIGH = auto()


class AlertStatus(Enum):
    PENDING = auto()
    ACKNOWLEDGED = auto()
    RESOLVED = auto()
    CLOSED = auto()


@dataclass
class Alert:
    """Alert data model representing a notification about potential equipment failure."""
    alert_id: str
    equipment_id: str
    prediction_id: str
    timestamp: datetime
    severity: AlertSeverity
    message: str
    status: AlertStatus = AlertStatus.PENDING
    metadata: Optional[Dict[str, Any]] = None
    
    def acknowledge(self) -> None:
        """Mark the alert as acknowledged."""
        if self.status == AlertStatus.PENDING:
            self.status = AlertStatus.ACKNOWLEDGED
        
    def resolve(self) -> None:
        """Mark the alert as resolved."""
        if self.status in [AlertStatus.PENDING, AlertStatus.ACKNOWLEDGED]:
            self.status = AlertStatus.RESOLVED
    
    def close(self) -> None:
        """Mark the alert as closed."""
        self.status = AlertStatus.CLOSED
