public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(P[playerid][_p_in_game] == false) return 0;

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

	    // Управление автомобилем
	    if(newkeys & KEY_YES)
	    {
	    	new source[202],str_engine[36],str_lights[32],str_doors[30],str_bonnet[30],str_boot[33];
	    	new engine,lights,alarm,doors,bonnet,boot,objective;
	    	GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
	    	switch(engine) {
	    	    case -1,0: str_engine = "{00FF00}Включить {FFFFFF}двигатель";
	    	    case 1: str_engine = "{FF0000}Отключить {FFFFFF}двигатель";
	    	}
	    	switch(lights) {
	    	    case -1,0: str_lights = "{00FF00}Включить {FFFFFF}фары";
	    	    case 1: str_lights = "{FF0000}Отключить {FFFFFF}фары";
	    	}
	    	switch(doors) {
	    	    case -1,0: str_doors = "{FF0000}Закрыть {FFFFFF}двери";
	    	    case 1: str_doors = "{00FF00}Открыть {FFFFFF}двери";
	    	}
	    	switch(bonnet) {
	    	    case -1,0: str_bonnet = "{00FF00}Открыть {FFFFFF}капот";
	    	    case 1: str_bonnet = "{FF0000}Закрыть {FFFFFF}капот";
	    	}
	    	switch(boot) {
	    	    case -1,0: str_boot = "{00FF00}Открыть {FFFFFF}багажник";
	    	    case 1: str_boot = "{FF0000}Закрыть {FFFFFF}багажник";
	    	}
	    	switch(IsTrailerAttachedToVehicle(vehicleid)) {
	    		case 0: format(source, sizeof(source),
					"%s\n%s\n%s\n%s\n%s\nАвтомобильное радио",
					str_engine,str_lights,str_doors,str_bonnet,str_boot);
				case 1: format(source, sizeof(source),
					"%s\n%s\n%s\n%s\n%s\nАвтомобильное радио\nОтцепить трейлер",
					str_engine,str_lights,str_doors,str_bonnet,str_boot);
			}
	    	ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, "Управление автомобилем",source,"Выбор","Отмена");
	    }
	    // Anti Speed Hack
	    if(newkeys & KEY_FIRE || oldkeys & KEY_FIRE)
	    {
	        if(Vehicle_Speed(vehicleid) > 270) P[playerid][_p_cheater]++;
	    }
	}
	// Главное меню
	/*if(newkeys & KEY_NO)
	{
	}*/
	// Открытие ворот и/или шлагбаумов
	if(newkeys & KEY_CROUCH)
	{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 1286.1700,-1652.1000,16.5500)) {
		    if(P[playerid][p_job_team] == ORG_FBI && obj_state_FBI == false) {
		        obj_state_FBI = true;
				MoveDynamicObject(obj_FBI, 1286.1700,-1652.1000,22.0000, MOVE_GATE_SPEED, 0.0000,0.0000,90.0000);
				defer OnGateClosed(obj_FBI);
		    }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 15.0, 1544.68994, -1629.98999, 13.22000)) {
			if(P[playerid][p_job_team] == ORG_FBI || P[playerid][p_job_team] == ORG_LSPD && obj_state_LSPD == false) {
	            obj_state_LSPD = true;
	            MoveDynamicObject(obj_LSPD, 1544.68994, -1630.81995, 12.90000, MOVE_BARRIER_SPEED, 0.00000, 0.00000, 90.00000);
	            defer OnGateClosed(obj_LSPD);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 15.0, -1572.19995, 658.63000, 6.98000)) {
	        if(P[playerid][p_job_team] == ORG_FBI || P[playerid][p_job_team] == ORG_SFPD && obj_state_SFPD[0] == false) {
	            obj_state_SFPD[0] = true;
	            MoveDynamicObject(obj_SFPD[0], -1572.19995, 658.79999, 6.65000, MOVE_BARRIER_SPEED, 0.00000, 0.00000, 90.00000);
	            defer OnGateClosed(obj_SFPD[0]);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 15.0, -1701.43005, 687.79498, 24.78000)) {
	        if(P[playerid][p_job_team] == ORG_FBI || P[playerid][p_job_team] == ORG_SFPD && obj_state_SFPD[1] == false) {
	            obj_state_SFPD[1] = true;
	            MoveDynamicObject(obj_SFPD[1], -1701.43005, 687.63000, 24.45000, MOVE_BARRIER_SPEED, 0.00000, 0.00000, 270.00000);
	            defer OnGateClosed(obj_SFPD[1]);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 15.0, 2238.18994, 2450.21997, 10.71000)) {
	        if(P[playerid][p_job_team] == ORG_FBI || P[playerid][p_job_team] == ORG_LVPD && obj_state_LVPD == false) {
	            obj_state_LVPD = true;
	            MoveDynamicObject(obj_LVPD, 2238.18994, 2450.37988, 10.37000, MOVE_BARRIER_SPEED, 0.00000, 0.00000, 90.00000);
	            defer OnGateClosed(obj_LVPD);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 15.0, 286.00000, 1822.00000, 20.03000)) {
	        if(P[playerid][p_job_team] == ORG_FBI || P[playerid][p_job_team] == ORG_MILITARY && obj_state_MILITARY[0] == false) {
	            obj_state_MILITARY[0] = true;
	            MoveDynamicObject(obj_MILITARY[0], 286.00000, 1833.00000, 20.03000, MOVE_GATE_SPEED, 0.00000, 0.00000, 90.00000);
	            defer OnGateClosed(obj_MILITARY[0]);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 15.0, 134.85001, 1941.53406, 21.71000)) {
	        if(P[playerid][p_job_team] == ORG_FBI || P[playerid][p_job_team] == ORG_MILITARY && obj_state_MILITARY[1] == false) {
	            obj_state_MILITARY[1] = true;
	            MoveDynamicObject(obj_MILITARY[1], 122.00000, 1941.53406, 21.71000, MOVE_GATE_SPEED, 0.00000, 0.00000, 180.00000);
	            defer OnGateClosed(obj_MILITARY[1]);
	        }
	    }
	}
	return 0;
}
