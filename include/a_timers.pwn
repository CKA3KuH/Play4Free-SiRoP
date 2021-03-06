timer OnWeatherChanger[60*60*1000]()
{
	SetWorldTime(g_hour);
	SetWeather(random(20));
	defer OnWeatherChanger[random(60)*60*1000]();
}

timer OnRentVehicleEnd[30*60*1000](vehicleid, category)
{
	switch(category) {
	    case ORG_UNKNOWN: {
			for(new i; i < sizeof(V_RENT); i++) {
			    if(vehicleid != V_RENT[i]) continue;
			    V_RENT_OWNER[i] = 0;
			}
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid, 0,lights,alarm,0,bonnet,boot,objective);
		}
		case JOB_TAXI: {
		    for(new i; i < sizeof(V_TAXI); i++) {
			    if(vehicleid != V_TAXI[i]) continue;
			    V_TAXI_OWNER[i] = 0;
			}
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid, 0,lights,alarm,doors,bonnet,boot,objective);
		}
		case JOB_ENGINEER: {
		    for(new i; i < sizeof(V_ENGINEER); i++) {
			    if(vehicleid != V_ENGINEER[i]) continue;
			    V_ENGINEER_OWNER[i] = 0;
			}
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid, 0,lights,alarm,doors,bonnet,boot,objective);
		}
		case JOB_FREIGHTER: {
		    for(new i; i < sizeof(V_FREIGHTER); i++) {
			    if(vehicleid != V_FREIGHTER[i]) continue;
			    V_FREIGHTER_OWNER[i] = 0;
			}
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
			SetVehicleParamsEx(vehicleid, 0,lights,alarm,doors,bonnet,boot,objective);
		}
	}
}

timer OnGateClosed[7500](objectid)
{
	if(objectid == obj_FBI) {
		obj_state_FBI = false;
		MoveDynamicObject(obj_FBI, 1286.1700,-1652.1000,16.5500, MOVE_GATE_SPEED, 0.0000,0.0000,90.0000);
	}
	if(objectid == obj_LSPD) {
		obj_state_LSPD = false;
		MoveDynamicObject(obj_LSPD, 1544.68994, -1630.98999, 13.22000, MOVE_BARRIER_SPEED, 0.00000, 90.00000, 90.00000);
	}
	if(objectid == obj_SFPD[0]) {
		obj_state_SFPD[0] = false;
		MoveDynamicObject(obj_SFPD[0], -1572.19995, 658.63000, 6.98000, MOVE_BARRIER_SPEED, 0.00000, 90.00000, 90.00000);
	}
	if(objectid == obj_SFPD[1]) {
		obj_state_SFPD[1] = false;
		MoveDynamicObject(obj_SFPD[1], -1701.43005, 687.79498, 24.78000, MOVE_BARRIER_SPEED, 0.00000, 90.00000, 270.00000);
	}
	if(objectid == obj_LVPD) {
		obj_state_LVPD = false;
		MoveDynamicObject(obj_LVPD, 2238.18994, 2450.21997, 10.71000, MOVE_BARRIER_SPEED, 0.00000, 90.00000, 90.00000);
	}
	if(objectid == obj_MILITARY[0]) {
		obj_state_MILITARY[0] = false;
		MoveDynamicObject(obj_MILITARY[0], 286.00000, 1822.00000, 20.03000, MOVE_GATE_SPEED, 0.00000, 0.00000, 90.00000);
	}
	if(objectid == obj_MILITARY[1]) {
		obj_state_MILITARY[1] = false;
		MoveDynamicObject(obj_MILITARY[1], 134.85001, 1941.53406, 21.71000, MOVE_GATE_SPEED, 0.00000, 0.00000, 180.00000);
	}
}

task OnUpdateTime[10*1000]()
{
	switch(g_minute) {
	    case 0..58: g_minute++;
	    case 59: switch(g_hour) {
	        case 0..22: {
	            g_hour++;
		        g_minute = 0;
	        }
	        case 23: {
	            g_hour = 0;
	            g_minute = 0;
	        }
	    }
	}
}

ptask OnPlayerCashSync[1000](playerid)
{
    if(P[playerid][_p_spawned] == false) return 1;
	switch(GetPlayerState(playerid)) {
	    case 0,7..9: return 1;
	}
	if(GetPlayerMoney(playerid) < 0) {
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid, floatround(P[playerid][p_cash]));
	}
	else if(GetPlayerMoney(playerid) < floatround(P[playerid][p_cash])) {
		new a = floatround(P[playerid][p_cash]) - GetPlayerMoney(playerid);
		P[playerid][p_cash] = floatsub(P[playerid][p_cash], a);
		Budget_GOVERNMENT = floatadd(Budget_GOVERNMENT, a);
	}
	else if(GetPlayerMoney(playerid) > floatround(P[playerid][p_cash])) {
		printf("[������]: �������� �������� ������� - %s[%d] | C: %d / S: %d",
			Name(playerid),playerid,GetPlayerMoney(playerid),floatround(P[playerid][p_cash]));
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid, floatround(P[playerid][p_cash]));
	    P[playerid][_p_cheater]++;
	}
	new string[16];
	format(string, sizeof(string), "%.0f Cent", floatmul(floatfract(P[playerid][p_cash]), 100.0));
	PlayerTextDrawSetString(playerid, P[playerid][_p_cent], string);
	return 1;
}

ptask OnPlayerVehicleFuelSync[1000](playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
		new vehicleid = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		new KMH = Vehicle_Speed(vehicleid);
		GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine == 1) switch(KMH) {
			case 0: V[vehicleid][v_fuel] = floatsub(V[vehicleid][v_fuel], 0.0001);
			default: V[vehicleid][v_fuel] = floatsub(V[vehicleid][v_fuel], (KMH * 0.00003));
		}
		if(Vehicle_WithoutFuel(GetVehicleModel(vehicleid)) == 0) {
			if(V[vehicleid][v_fuel] <= 0) {
				SetVehicleParamsEx(vehicleid, 0,lights,alarm,doors,bonnet,boot,objective);
				SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ����� ���������� ����������� �������!");
			}
		}
	}
}