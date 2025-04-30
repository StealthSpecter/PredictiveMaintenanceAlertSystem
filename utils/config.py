"""
Configuration parameters for the Alert Generator.
"""

# Thresholds for alert generation
THRESHOLD_HIGH = 0.8    # 80% probability
THRESHOLD_MEDIUM = 0.5  # 50% probability
THRESHOLD_LOW = 0.3     # 30% probability

# Alert message templates
MSG_HIGH = "CRITICAL: Failure predicted within {hours} hours. Immediate attention required."
MSG_MEDIUM = "WARNING: Potential failure detected. Schedule maintenance within {hours} hours."
MSG_LOW = "NOTICE: Early signs of deterioration detected. Monitor condition."
