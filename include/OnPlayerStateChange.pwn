public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER) {
        PlayerTextDrawShow(playerid, P[playerid][_p_speedo]);
	    new vehicleid = GetPlayerVehicleID(playerid);
	    new engine,lights,alarm,doors,bonnet,boot,objective;
	    GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
	    if(doors == 1) RemovePlayerFromVehicle(playerid);
	    if(V[vehicleid][_v_stream_id] != 0) PlayAudioStreamForPlayer(playerid, V[vehicleid][_v_stream_url]);
	    for(new i; i < sizeof(V_TAXI); i++) {
	        if(P[playerid][p_job_team] != JOB_TAXI) break;
	        if(vehicleid != V_TAXI[i]) continue;
	        if(V_TAXI_OWNER[i] != 0) break;
	        if(Vehicle_IsPlayerWithLicense(GetVehicleModel(vehicleid), playerid) == 0) {
                SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ��� ��� ����� � �������� ���������� ������ ������������ ���������!");
                break;
            }
            new source[128];
            format(source, sizeof(source),
				"{FFFFFF}������ ���������� ����� ������ � ������.\n\n\
				������� ����� ������. �� 1 ������ ($%.2f) �� 240 �����",
				Prices_RentCar);
            ShowPlayerDialog(playerid, 11, DIALOG_STYLE_INPUT, "������ �����",source,"������","�����");
            break;
	    }
	    for(new i; i < sizeof(V_ENGINEER); i++) {
	        if(P[playerid][p_job_team] != JOB_ENGINEER) break;
	        if(vehicleid != V_ENGINEER[i]) continue;
	        if(V_ENGINEER_OWNER[i] != 0) break;
	        if(Vehicle_IsPlayerWithLicense(GetVehicleModel(vehicleid), playerid) == 0) {
                SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ��� ��� ����� � �������� ���������� ������ ������������ ���������!");
                break;
            }
            new source[128];
            format(source, sizeof(source),
				"{FFFFFF}������ ���������� ��������� ������ � ������.\n\n\
				������� ����� ������. �� 1 ������ ($%.2f) �� 240 �����",
				Prices_RentCar);
            ShowPlayerDialog(playerid, 12, DIALOG_STYLE_INPUT, "������ ���������� ����������",source,"������","�����");
            break;
	    }
	    for(new i; i < sizeof(V_FREIGHTER); i++) {
	        if(P[playerid][p_job_team] != JOB_FREIGHTER) break;
	        if(vehicleid != V_FREIGHTER[i]) continue;
	        if(V_FREIGHTER_OWNER[i] != 0) break;
	        if(Vehicle_IsPlayerWithLicense(GetVehicleModel(vehicleid), playerid) == 0) {
                SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ��� ��� ����� � �������� ���������� ������ ������������ ���������!");
                break;
            }
            new source[128];
            format(source, sizeof(source),
				"{FFFFFF}������ �������� ���������� ������ � ������.\n\n\
				������� ����� ������. �� 1 ������ ($%.2f) �� 240 �����",
				Prices_RentCar);
            ShowPlayerDialog(playerid, 13, DIALOG_STYLE_INPUT, "������ ���������",source,"������","�����");
            break;
	    }
	    for(new i; i < sizeof(V_RENT); i++) {
	        if(vehicleid != V_RENT[i]) continue;
	        if(V_RENT_OWNER[i] != 0) break;
	        if(Vehicle_IsPlayerWithLicense(GetVehicleModel(vehicleid), playerid) == 0) {
                SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ��� ��� ����� � �������� ���������� ������ ������������ ���������!");
                break;
            }
            new source[128];
            format(source, sizeof(source),
				"{FFFFFF}������ ������������ �������� ������ � ������.\n\n\
				������� ����� ������. �� 1 ������ ($%.2f) �� 240 �����",
				Prices_RentCar);
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_INPUT, "������ ����������",source,"������","�����");
            break;
	    }
	}
	if(oldstate == PLAYER_STATE_DRIVER) {
	    PlayerTextDrawHide(playerid, P[playerid][_p_speedo]);
		StopAudioStreamForPlayer(playerid);
	}
	if(newstate == PLAYER_STATE_PASSENGER) {
		new vehicleid = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
	    if(doors == 1) RemovePlayerFromVehicle(playerid);
		if(V[vehicleid][_v_stream_id] != 0) PlayAudioStreamForPlayer(playerid, V[vehicleid][_v_stream_url]);
	}
	if(oldstate == PLAYER_STATE_PASSENGER) {
		StopAudioStreamForPlayer(playerid);
	}
	return 1;
}
