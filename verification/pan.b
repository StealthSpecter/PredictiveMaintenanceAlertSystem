	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM false_alerts */
;
		
	case 3: // STATE 1
		goto R999;

	case 4: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM missed_critical_alerts */
;
		;
		;
		;
		
	case 7: // STATE 13
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 8: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 9: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 10: // STATE 4
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC prediction_simulator */
;
		;
		
	case 12: // STATE 2
		;
		now.equipment_ids[ Index(((P1 *)_this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 3
		;
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 4
		;
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 15: // STATE 5
		;
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 16: // STATE 6
		;
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 17: // STATE 9
		;
		now.pred_count = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 10
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 19: // STATE 11
		;
	/* 0 */	((P1 *)_this)->i = trpt->bup.oval;
		;
		;
		goto R999;

	case 20: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC alert_generator */
;
		;
		
	case 22: // STATE 19
		;
		((P0 *)_this)->i = trpt->bup.ovals[3];
		alert_count = trpt->bup.ovals[2];
		now.alerts[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = trpt->bup.ovals[1];
		alert_severity[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 23: // STATE 19
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 24: // STATE 19
		;
		((P0 *)_this)->i = trpt->bup.ovals[3];
		alert_count = trpt->bup.ovals[2];
		now.alerts[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = trpt->bup.ovals[1];
		alert_severity[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 25: // STATE 19
		;
		((P0 *)_this)->i = trpt->bup.ovals[3];
		alert_count = trpt->bup.ovals[2];
		now.alerts[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = trpt->bup.ovals[1];
		alert_severity[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 26: // STATE 19
		;
		((P0 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 27: // STATE 20
		;
	/* 0 */	((P0 *)_this)->i = trpt->bup.oval;
		;
		;
		goto R999;

	case 28: // STATE 25
		;
		p_restor(II);
		;
		;
		goto R999;
	}

