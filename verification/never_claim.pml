never {    /* !([](pred_count > 0 && predictions[0] > THRESHOLD_HIGH -> <>(alerts[equipment_ids[0]] == 1))) */
state accept_all:
        if
        :: (1) -> goto accept_all
        fi;
}
