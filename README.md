# Predictive Maintenance Alert Generation System

An advanced alert generation module for industrial predictive maintenance systems, designed to process machine learning predictions and generate appropriate maintenance alerts.

## Overview

This module serves as a critical component in a Predictive Maintenance and Failure Prediction System, acting as the bridge between automated prediction and human intervention. It ensures that potential equipment failures are properly detected, prioritized, and communicated to maintenance personnel.

![System Architecture](docs/diagrams/system_architecture.png)

## Key Features

- **Threshold-Based Alert Generation**: Creates alerts based on configurable probability thresholds
- **Priority Categorization**: Categorizes alerts as HIGH, MEDIUM, or LOW severity
- **Alert Lifecycle Management**: Tracks alerts through PENDING, ACKNOWLEDGED, RESOLVED, and CLOSED states
- **Thread-Safe Implementation**: Ensures reliable operation under concurrent conditions
- **Duplicate Prevention**: Intelligent handling of repeated predictions
- **Comprehensive Logging**: Detailed activity tracking for troubleshooting and auditing

## Implementation Details

The system is implemented in Python 3.9+ with a focus on:
- Clean architecture with separation of concerns
- Thread safety for concurrent operation
- Comprehensive test coverage
- Formal verification of critical properties

## Formal Verification

Critical alert generation properties have been formally verified using the SPIN model checker:
- No missed critical alerts (high probability predictions always generate alerts)
- No false alerts (low probability events don't trigger unnecessary alerts)
- Thread-safe concurrent operation



### Prerequisites
- Python 3.9 or higher
- SPIN model checker (for verification)

### Installation

1. Clone the repository:
   git clone https://github.com/StealthSpecter/PredictiveMaintenanceAlertSystem.git
   cd PredictiveMaintenanceAlertSystem

2. Set up a virtual environment (optional but recommended):
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
3. Install dependencies:
   pip install -r requirements.txt
   
## Usage

### Demo Execution
To see the module in action with sample predictions:
python3 main.py

### Running Tests
To execute the test suite:
python3 -m unittest discover tests

## Documentation

For comprehensive documentation, including design diagrams, formal verification analysis, and quality evaluation, please refer to the [project report](docs/report.pdf).

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- National Institute of Technology Meghalaya
- CS352 Software Engineering Lab
