public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
switch(dialogid) {
	// ���� � ������� ������
	case d_account_signin: {
	    if(!response) return Kick(playerid);
	    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, d_account_signin, DIALOG_STYLE_PASSWORD, "���� � ������� ������",SERVER_NAME"\n\n{FFFFFF}������� ������ �� ����� ������� ������ ��� ����� � ����","����","�����");
	    WP_Hash(inputtext, 129, inputtext);
	    if(strcmp(P[playerid][p_password], inputtext, false) != 0) return ShowPlayerDialog(playerid, d_signin_failed, DIALOG_STYLE_MSGBOX, "������ �����","{B22222}������ ����� � ������� ������.\n�� ����� �������� ������!\n\n{FFFFFF}��������� ��� �������� ����?","������","�����");

	    new year1,month1,day1,
			year2,month2,day2;
	    getdate(year1,month1,day1);
	    sscanf(P[playerid][p_unban_date], "p<->iii", year2,month2,day2);
	    if(year2 >= year1) {
	        if(month2 >= month1) {
	            if(day2 > day1) {
	                new source[256+1];
					format(source, sizeof(source), SERVER_NAME"\n\n{B22222}������� ������ {FFFFFF}%s {B22222}�������������\n\n���� �������������: {FFFFFF}%s", Name(playerid),P[playerid][p_unban_date]);
					return ShowPlayerDialog(playerid, d_account_banned, DIALOG_STYLE_MSGBOX, "������� ������ �������������",source,"�����","");
	            }
	        }
	    }
	    P[playerid][_p_in_game] = true;
	    GivePlayerMoney(playerid, floatround(P[playerid][p_cash]));
	    SetPlayerHealth(playerid, P[playerid][p_health]);
	    TogglePlayerSpectating(playerid, 0);
	    SetSpawnInfo(playerid, 0, P[playerid][p_skin], 1642.4329,-2239.0205,13.4967,180.0, 0,0,0,0,0,0);
		Command_SetAccessToCommands(playerid);
	    SendClientMessage(playerid, 0xB9C9BFFF, "���� � ������� ������ ������� ��������.");
	    SendClientMessage(playerid, 0xB9C9BFFF, "����� ����������, � ���� �� "SERVER_NAME);
	    SendClientMessage(playerid, 0xB9C9BFFF, "������� ����, ������� - '{00FF00}~k~~CONVERSATION_NO~{FFFFFF}'");
	    SendClientMessage(playerid, 0xB9C9BFFF, "���������� �����������, ������� - '{00FF00}~k~~CONVERSATION_YES~{FFFFFF}'");
	    if(P[playerid][p_access] > 0) {
	        foreach(new i : Player) {
	            if(P[i][_p_in_game] == false) continue;
	            if(P[i][p_access] == 0) continue;
				va_SendClientMessage(i, 0xADFF2FFF, "����������� %s - %s [%d]", Get_AccessName(playerid),Name(playerid),playerid);
	        }
	    }
	}
	// �������� ������� ������
	case d_account_creating: {
	    if(!response) return Kick(playerid);
	    if(strlen(inputtext) < 5 || strlen(inputtext) > 18) return ShowPlayerDialog(playerid, d_account_creating, DIALOG_STYLE_INPUT, "�������� ������� ������",SERVER_NAME"\n\n{FFFFFF}���������� � ������� ������ ��� �������� ������� ������.\n�������:\n- {B22222}�� 5 �� 18 ��������\n{FFFFFF}- ���������� ����� � �����","�����","�����");
	    for(new i; i < strlen(inputtext); i++) switch(inputtext[i]) {
	        case '0'..'9': continue;
	        case 'a'..'z': continue;
	        case 'A'..'Z': continue;
	        default: return ShowPlayerDialog(playerid, d_account_creating, DIALOG_STYLE_INPUT, "�������� ������� ������",SERVER_NAME"\n\n{FFFFFF}���������� � ������� ������ ��� �������� ������� ������.\n�������:\n- �� 5 �� 18 ��������\n- {B22222}���������� ����� � �����","�����","�����");
	    }
	    WP_Hash(P[playerid][p_password], 129, inputtext);
	    ShowPlayerDialog(playerid, d_character_sex, DIALOG_STYLE_MSGBOX, "����� ���� ���������",SERVER_NAME"\n\n{FFFFFF}��������, ����� ����� ��� � ������ ���������?","�������","�������");
	}
	// ������ �����
	case d_signin_failed: switch(response) {
	    case 0: return Kick(playerid);
	    case 1: return ShowPlayerDialog(playerid, d_account_signin, DIALOG_STYLE_PASSWORD, "���� � ������� ������",SERVER_NAME"\n\n{FFFFFF}������� ������ �� ����� ������� ������ ��� ����� � ����","����","�����");
	}
	// ����� ���� ���������
	case d_character_sex: {
	    P[playerid][p_sex] = response;
	    SkinShop_Show(playerid, ORG_UNKNOWN);
	}
	// ��� ��������� | ������� ������ �������������
	case d_character_name,d_account_banned: Kick(playerid);
	// ���������� �����������
	case d_vehicle_control: {
	    new engine,lights,alarm,doors,bonnet,boot,objective;
	    new vehicleid = GetPlayerVehicleID(playerid);
		GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
		if(response) switch(listitem) {
		    // ���������
		    case 0: switch(engine) {
		        case -1,0: {
		            if(Vehicle_IsNotForPlayer(vehicleid, playerid)) return 1;
		            if(Vehicle_IsPlayerWithLicense(GetVehicleModel(vehicleid), playerid) == 0) {
		                return SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ��� ��� ����� � �������� ���������� ������ ������������ ���������!");
		            }
		            if(Vehicle_WithoutFuel(GetVehicleModel(vehicleid)) == 0) {
		                if(V[vehicleid][v_fuel] <= 0) return SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}� ���������� ����������� �������!");
		            }
					SetVehicleParamsEx(vehicleid, 1,lights,alarm,doors,bonnet,boot,objective);
		        }
		        case 1: SetVehicleParamsEx(vehicleid, 0,lights,alarm,doors,bonnet,boot,objective);
		    }
		    // ����
		    case 1: switch(lights) {
		        case -1,0: SetVehicleParamsEx(vehicleid, engine,1,alarm,doors,bonnet,boot,objective);
		        case 1: SetVehicleParamsEx(vehicleid, engine,0,alarm,doors,bonnet,boot,objective);
		    }
		    // �����
		    case 2: {
		        if(Vehicle_IsNotForPlayer(vehicleid, playerid)) return 1;
		        if(Vehicle_WithoutDoor(GetVehicleModel(vehicleid)) == 1) return 1;
				switch(doors) {
		        	case -1,0: SetVehicleParamsEx(vehicleid, engine,lights,alarm,1,bonnet,boot,objective);
		        	case 1: SetVehicleParamsEx(vehicleid, engine,lights,alarm,0,bonnet,boot,objective);
		        }
		    }
		    // �����
		    case 3: switch(bonnet) {
		        case -1,0: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,1,boot,objective);
		        case 1: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,0,boot,objective);
		    }
		    // ��������
		    case 4: switch(boot) {
		        case -1,0: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,1,objective);
		        case 1: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,0,objective);
		    }
		    // ������������� �����
		    case 5: {
		        new string[512];
		        for(new i; i < sizeof(Streams); i++) strcat(string, Streams[i][0]);
		        ShowPlayerDialog(playerid, d_vehicle_radio, DIALOG_STYLE_LIST, "������������� �����", string, "�����","������");
		    }
		    // �������� �������
		    case 6: DetachTrailerFromVehicle(vehicleid);
		}
	}
	// ������������� �����
	case d_vehicle_radio: if(response) switch(listitem) {
	    case 0: {
	        new vehicleid = GetPlayerVehicleID(playerid);
			foreach(new i : Player) {
			    if(P[i][_p_in_game] == false) continue;
	        	if(GetPlayerVehicleID(i) != vehicleid) continue;
				StopAudioStreamForPlayer(i);
			}
			V[vehicleid][_v_stream_id] = 0;
	    }
	    case 1: ShowPlayerDialog(playerid, d_radio_url, DIALOG_STYLE_INPUT, "�������� ���� URL","{FFFFFF}������� URL-����� �� ��������-����� � �������","��������","�����");
	    default: {
	        new vehicleid = GetPlayerVehicleID(playerid);
			foreach(new i : Player) {
			    if(P[i][_p_in_game] == false) continue;
	        	if(GetPlayerVehicleID(i) != vehicleid) continue;
				PlayAudioStreamForPlayer(i, Streams[listitem][1]);
			}
			V[vehicleid][_v_stream_id] = listitem;
			format(V[vehicleid][_v_stream_url], 128, Streams[listitem][1]);
	    }
	}
	// �������� ���� URL
	case d_radio_url: switch(response) {
	    case 0: CallLocalFunction("OnDialogResponse", "dddd", playerid,6,1,5);
	    case 1: {
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 9, DIALOG_STYLE_INPUT, "�������� ���� URL","{FFFFFF}������� URL-����� �� ��������-����� � �������","��������","�����");
	        new vehicleid = GetPlayerVehicleID(playerid);
			foreach(new i : Player) {
			    if(P[i][_p_in_game] == false) continue;
	        	if(GetPlayerVehicleID(i) != vehicleid) continue;
				PlayAudioStreamForPlayer(i, inputtext);
			}
			V[vehicleid][_v_stream_id] = 1;
			format(V[vehicleid][_v_stream_url], 128, inputtext);
	    }
	}
	// ������ ����������
	case d_vehicle_rent: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	    	if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}���������� ����� ������ ���� �� 1 �� 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}������������ �������� ������� ��� ������ ����������");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "������������ �������� ���������� �� %d ����� �� $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_RENT); i++) {
	            if(V_RENT[i] != GetPlayerVehicleID(playerid)) continue;
	            V_RENT_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_RENT[i], ORG_UNKNOWN);
	        }
	    }
	}
	// ������ �����
	case d_rent_taxi: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	        if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}���������� ����� ������ ���� �� 1 �� 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}������������ �������� ������� ��� ������ ����������");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "���������� ����� ��������� �� %d ����� �� $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_TAXI); i++) {
	            if(V_TAXI[i] != GetPlayerVehicleID(playerid)) continue;
	            V_TAXI_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_TAXI[i], JOB_TAXI);
	        }
	    }
	}
	// ������ ���������� ����������
	case d_rent_engineer: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	        if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}���������� ����� ������ ���� �� 1 �� 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}������������ �������� ������� ��� ������ ����������");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "���������� ����� ��������� �� %d ����� �� $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_ENGINEER); i++) {
	            if(V_ENGINEER[i] != GetPlayerVehicleID(playerid)) continue;
	            V_ENGINEER_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_ENGINEER[i], JOB_ENGINEER);
	        }
	    }
	}
	// ������ ���������
	case d_rent_freighter: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	        if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}���������� ����� ������ ���� �� 1 �� 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}������������ �������� ������� ��� ������ ����������");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "���������� ����� ��������� �� %d ����� �� $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_FREIGHTER); i++) {
	            if(V_FREIGHTER[i] != GetPlayerVehicleID(playerid)) continue;
	            V_FREIGHTER_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_FREIGHTER[i], JOB_FREIGHTER);
	        }
	    }
	}
}
return 1;
}