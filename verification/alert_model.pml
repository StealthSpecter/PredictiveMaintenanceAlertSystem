/* Alert Generation Verification Model */
#define MAX_EQUIPMENT 3
#define MAX_PREDICTIONS 5
#define THRESHOLD_HIGH 80    /* Using integers instead of floats (0.8 -> 80) */
#define THRESHOLD_MEDIUM 50  /* 0.5 -> 50 */
#define THRESHOLD_LOW 30     /* 0.3 -> 30 */

/* Global variables */
byte predictions[MAX_PREDICTIONS];  /* Stores failure probability (0-100) */
byte equipment_ids[MAX_PREDICTIONS]; /* Stores which equipment a prediction is for */
bit alerts[MAX_EQUIPMENT];  /* 1 if alert generated, 0 otherwise */
byte alert_severity[MAX_EQUIPMENT]; /* 0=none, 1=low, 2=medium, 3=high */
byte pred_count = 0;
byte alert_count = 0;

/* Alert generation process with atomic blocks to prevent race conditions */
proctype alert_generator() {
  byte i = 0;
  
  do
  :: i < pred_count -> 
     atomic {  /* Atomic block ensures no interleaving during alert generation */
       if
       :: predictions[i] >= THRESHOLD_HIGH ->
          alert_severity[equipment_ids[i]] = 3;
          alerts[equipment_ids[i]] = 1;
          alert_count++;
       :: predictions[i] >= THRESHOLD_MEDIUM && predictions[i] < THRESHOLD_HIGH ->
          alert_severity[equipment_ids[i]] = 2;
          alerts[equipment_ids[i]] = 1;
          alert_count++;
       :: predictions[i] >= THRESHOLD_LOW && predictions[i] < THRESHOLD_MEDIUM ->
          alert_severity[equipment_ids[i]] = 1;
          alerts[equipment_ids[i]] = 1;
          alert_count++;
       :: else -> skip;
       fi;
     }
     i++;
  :: i >= pred_count -> break;
  od;
}

/* Prediction simulation process */
proctype prediction_simulator() {
  byte i = 0;
  
  do
  :: i < MAX_PREDICTIONS && pred_count < MAX_PREDICTIONS ->
     equipment_ids[i] = i % MAX_EQUIPMENT;
     
     if
     :: predictions[i] = 90;  /* Critical (0.9 -> 90) */
     :: predictions[i] = 60;  /* Medium (0.6 -> 60) */
     :: predictions[i] = 20;  /* Low (0.2 -> 20) */
     :: predictions[i] = 0;   /* None */
     fi;
     
     pred_count++;
     i++;
  :: i >= MAX_PREDICTIONS || pred_count >= MAX_PREDICTIONS -> break;
  od;
}

/* Main init process */
init {
  atomic {
    run prediction_simulator();
    run alert_generator();
  }
}

/* Define properties */
ltl missed_critical_alerts { 
  [](pred_count > 0 && predictions[0] > THRESHOLD_HIGH -> <>(alerts[equipment_ids[0]] == 1))
}

ltl false_alerts {
  []!(pred_count > 0 && alerts[0] == 1 && predictions[0] < THRESHOLD_LOW)
}
