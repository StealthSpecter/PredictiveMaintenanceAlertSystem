#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM false_alerts */
	case 3: // STATE 1 - _spin_nvr.tmp:14 - [(!(!((((pred_count>0)&&(alerts[0]==1))&&(predictions[0]<30)))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][1] = 1;
		if (!( !( !((((((int)now.pred_count)>0)&&(((int)now.alerts[0])==1))&&(((int)now.predictions[0])<30))))))
			continue;
		/* merge: assert(!(!(!((((pred_count>0)&&(alerts[0]==1))&&(predictions[0]<30))))))(0, 2, 6) */
		reached[4][2] = 1;
		spin_assert( !( !( !((((((int)now.pred_count)>0)&&(((int)now.alerts[0])==1))&&(((int)now.predictions[0])<30))))), " !( !( !((((pred_count>0)&&(alerts[0]==1))&&(predictions[0]<30)))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[4][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - _spin_nvr.tmp:19 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM missed_critical_alerts */
	case 5: // STATE 1 - _spin_nvr.tmp:3 - [((!(!(((pred_count>0)&&(predictions[0]>80))))&&!((alerts[equipment_ids[0]]==1))))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][1] = 1;
		if (!(( !( !(((((int)now.pred_count)>0)&&(((int)now.predictions[0])>80))))&& !((((int)now.alerts[ Index(((int)now.equipment_ids[0]), 3) ])==1)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 8 - _spin_nvr.tmp:8 - [(!((alerts[equipment_ids[0]]==1)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported8 = 0;
			if (verbose && !reported8)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported8 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][8] = 1;
		if (!( !((((int)now.alerts[ Index(((int)now.equipment_ids[0]), 3) ])==1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 13 - _spin_nvr.tmp:10 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported13 = 0;
			if (verbose && !reported13)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported13 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][13] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 8: // STATE 1 - alert_model.pml:68 - [(run prediction_simulator())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		if (!(addproc(II, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 2 - alert_model.pml:69 - [(run alert_generator())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!(addproc(II, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 4 - alert_model.pml:71 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC prediction_simulator */
	case 11: // STATE 1 - alert_model.pml:49 - [(((i<5)&&(pred_count<5)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!(((((int)((P1 *)_this)->i)<5)&&(((int)now.pred_count)<5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 2 - alert_model.pml:50 - [equipment_ids[i] = (i%3)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.equipment_ids[ Index(((int)((P1 *)_this)->i), 5) ]);
		now.equipment_ids[ Index(((P1 *)_this)->i, 5) ] = (((int)((P1 *)_this)->i)%3);
#ifdef VAR_RANGES
		logval("equipment_ids[prediction_simulator:i]", ((int)now.equipment_ids[ Index(((int)((P1 *)_this)->i), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 3 - alert_model.pml:53 - [predictions[i] = 90] (0:0:1 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]);
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = 90;
#ifdef VAR_RANGES
		logval("predictions[prediction_simulator:i]", ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 4 - alert_model.pml:54 - [predictions[i] = 60] (0:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		(trpt+1)->bup.oval = ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]);
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = 60;
#ifdef VAR_RANGES
		logval("predictions[prediction_simulator:i]", ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 5 - alert_model.pml:55 - [predictions[i] = 20] (0:0:1 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]);
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = 20;
#ifdef VAR_RANGES
		logval("predictions[prediction_simulator:i]", ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 6 - alert_model.pml:56 - [predictions[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]);
		now.predictions[ Index(((P1 *)_this)->i, 5) ] = 0;
#ifdef VAR_RANGES
		logval("predictions[prediction_simulator:i]", ((int)now.predictions[ Index(((int)((P1 *)_this)->i), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 9 - alert_model.pml:59 - [pred_count = (pred_count+1)] (0:0:1 - 5)
		IfNotBlocked
		reached[1][9] = 1;
		(trpt+1)->bup.oval = ((int)now.pred_count);
		now.pred_count = (((int)now.pred_count)+1);
#ifdef VAR_RANGES
		logval("pred_count", ((int)now.pred_count));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 10 - alert_model.pml:60 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		(trpt+1)->bup.oval = ((int)((P1 *)_this)->i);
		((P1 *)_this)->i = (((int)((P1 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval("prediction_simulator:i", ((int)((P1 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 11 - alert_model.pml:61 - [(((i>=5)||(pred_count>=5)))] (0:0:1 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		if (!(((((int)((P1 *)_this)->i)>=5)||(((int)now.pred_count)>=5))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: i */  (trpt+1)->bup.oval = ((P1 *)_this)->i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->i = 0;
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 16 - alert_model.pml:63 - [-end-] (0:0:0 - 3)
		IfNotBlocked
		reached[1][16] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC alert_generator */
	case 21: // STATE 1 - alert_model.pml:21 - [((i<pred_count))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)((P0 *)_this)->i)<((int)now.pred_count))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 2 - alert_model.pml:24 - [((predictions[i]>=80))] (22:0:4 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!((((int)now.predictions[ Index(((int)((P0 *)_this)->i), 5) ])>=80)))
			continue;
		/* merge: alert_severity[equipment_ids[i]] = 3(22, 3, 22) */
		reached[0][3] = 1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)alert_severity[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]);
		alert_severity[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = 3;
#ifdef VAR_RANGES
		logval("alert_severity[equipment_ids[alert_generator:i]]", ((int)alert_severity[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]));
#endif
		;
		/* merge: alerts[equipment_ids[i]] = 1(22, 4, 22) */
		reached[0][4] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.alerts[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]);
		now.alerts[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = 1;
#ifdef VAR_RANGES
		logval("alerts[equipment_ids[alert_generator:i]]", ((int)now.alerts[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]));
#endif
		;
		/* merge: alert_count = (alert_count+1)(22, 5, 22) */
		reached[0][5] = 1;
		(trpt+1)->bup.ovals[2] = ((int)alert_count);
		alert_count = (((int)alert_count)+1);
#ifdef VAR_RANGES
		logval("alert_count", ((int)alert_count));
#endif
		;
		/* merge: .(goto)(22, 17, 22) */
		reached[0][17] = 1;
		;
		/* merge: i = (i+1)(22, 19, 22) */
		reached[0][19] = 1;
		(trpt+1)->bup.ovals[3] = ((int)((P0 *)_this)->i);
		((P0 *)_this)->i = (((int)((P0 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval("alert_generator:i", ((int)((P0 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 23, 22) */
		reached[0][23] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 23: // STATE 17 - alert_model.pml:38 - [.(goto)] (0:22:1 - 4)
		IfNotBlocked
		reached[0][17] = 1;
		;
		/* merge: i = (i+1)(22, 19, 22) */
		reached[0][19] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->i);
		((P0 *)_this)->i = (((int)((P0 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval("alert_generator:i", ((int)((P0 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 23, 22) */
		reached[0][23] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 24: // STATE 6 - alert_model.pml:28 - [(((predictions[i]>=50)&&(predictions[i]<80)))] (22:0:4 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		if (!(((((int)now.predictions[ Index(((int)((P0 *)_this)->i), 5) ])>=50)&&(((int)now.predictions[ Index(((int)((P0 *)_this)->i), 5) ])<80))))
			continue;
		/* merge: alert_severity[equipment_ids[i]] = 2(22, 7, 22) */
		reached[0][7] = 1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)alert_severity[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]);
		alert_severity[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = 2;
#ifdef VAR_RANGES
		logval("alert_severity[equipment_ids[alert_generator:i]]", ((int)alert_severity[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]));
#endif
		;
		/* merge: alerts[equipment_ids[i]] = 1(22, 8, 22) */
		reached[0][8] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.alerts[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]);
		now.alerts[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = 1;
#ifdef VAR_RANGES
		logval("alerts[equipment_ids[alert_generator:i]]", ((int)now.alerts[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]));
#endif
		;
		/* merge: alert_count = (alert_count+1)(22, 9, 22) */
		reached[0][9] = 1;
		(trpt+1)->bup.ovals[2] = ((int)alert_count);
		alert_count = (((int)alert_count)+1);
#ifdef VAR_RANGES
		logval("alert_count", ((int)alert_count));
#endif
		;
		/* merge: .(goto)(22, 17, 22) */
		reached[0][17] = 1;
		;
		/* merge: i = (i+1)(22, 19, 22) */
		reached[0][19] = 1;
		(trpt+1)->bup.ovals[3] = ((int)((P0 *)_this)->i);
		((P0 *)_this)->i = (((int)((P0 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval("alert_generator:i", ((int)((P0 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 23, 22) */
		reached[0][23] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 25: // STATE 10 - alert_model.pml:32 - [(((predictions[i]>=30)&&(predictions[i]<50)))] (22:0:4 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		if (!(((((int)now.predictions[ Index(((int)((P0 *)_this)->i), 5) ])>=30)&&(((int)now.predictions[ Index(((int)((P0 *)_this)->i), 5) ])<50))))
			continue;
		/* merge: alert_severity[equipment_ids[i]] = 1(22, 11, 22) */
		reached[0][11] = 1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)alert_severity[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]);
		alert_severity[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = 1;
#ifdef VAR_RANGES
		logval("alert_severity[equipment_ids[alert_generator:i]]", ((int)alert_severity[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]));
#endif
		;
		/* merge: alerts[equipment_ids[i]] = 1(22, 12, 22) */
		reached[0][12] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.alerts[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]);
		now.alerts[ Index(now.equipment_ids[ Index(((P0 *)_this)->i, 5) ], 3) ] = 1;
#ifdef VAR_RANGES
		logval("alerts[equipment_ids[alert_generator:i]]", ((int)now.alerts[ Index(((int)now.equipment_ids[ Index(((int)((P0 *)_this)->i), 5) ]), 3) ]));
#endif
		;
		/* merge: alert_count = (alert_count+1)(22, 13, 22) */
		reached[0][13] = 1;
		(trpt+1)->bup.ovals[2] = ((int)alert_count);
		alert_count = (((int)alert_count)+1);
#ifdef VAR_RANGES
		logval("alert_count", ((int)alert_count));
#endif
		;
		/* merge: .(goto)(22, 17, 22) */
		reached[0][17] = 1;
		;
		/* merge: i = (i+1)(22, 19, 22) */
		reached[0][19] = 1;
		(trpt+1)->bup.ovals[3] = ((int)((P0 *)_this)->i);
		((P0 *)_this)->i = (((int)((P0 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval("alert_generator:i", ((int)((P0 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 23, 22) */
		reached[0][23] = 1;
		;
		_m = 3; goto P999; /* 6 */
	case 26: // STATE 15 - alert_model.pml:36 - [(1)] (22:0:1 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		if (!(1))
			continue;
		/* merge: .(goto)(22, 17, 22) */
		reached[0][17] = 1;
		;
		/* merge: i = (i+1)(22, 19, 22) */
		reached[0][19] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->i);
		((P0 *)_this)->i = (((int)((P0 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval("alert_generator:i", ((int)((P0 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 23, 22) */
		reached[0][23] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 27: // STATE 20 - alert_model.pml:40 - [((i>=pred_count))] (0:0:1 - 1)
		IfNotBlocked
		reached[0][20] = 1;
		if (!((((int)((P0 *)_this)->i)>=((int)now.pred_count))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: i */  (trpt+1)->bup.oval = ((P0 *)_this)->i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)_this)->i = 0;
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 25 - alert_model.pml:42 - [-end-] (0:0:0 - 3)
		IfNotBlocked
		reached[0][25] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

