public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
switch(dialogid) {
	// Вход в учётную запись
	case d_account_signin: {
	    if(!response) return Kick(playerid);
	    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, d_account_signin, DIALOG_STYLE_PASSWORD, "Вход в учётную запись",SERVER_NAME"\n\n{FFFFFF}Введите пароль от своей учётной записи для входа в игру","Вход","Выход");
	    WP_Hash(inputtext, 129, inputtext);
	    if(strcmp(P[playerid][p_password], inputtext, false) != 0) return ShowPlayerDialog(playerid, d_signin_failed, DIALOG_STYLE_MSGBOX, "Ошибка входа","{B22222}Ошибка входа в учётную запись.\nВы ввели неверный пароль!\n\n{FFFFFF}Повторить или покинуть игру?","Повтор","Выход");

	    new year1,month1,day1,
			year2,month2,day2;
	    getdate(year1,month1,day1);
	    sscanf(P[playerid][p_unban_date], "p<->iii", year2,month2,day2);
	    if(year2 >= year1) {
	        if(month2 >= month1) {
	            if(day2 > day1) {
	                new source[256+1];
					format(source, sizeof(source), SERVER_NAME"\n\n{B22222}Учётная запись {FFFFFF}%s {B22222}заблокирована\n\nДата разблокировки: {FFFFFF}%s", Name(playerid),P[playerid][p_unban_date]);
					return ShowPlayerDialog(playerid, d_account_banned, DIALOG_STYLE_MSGBOX, "Учётная запись заблокирована",source,"Выход","");
	            }
	        }
	    }
	    P[playerid][_p_in_game] = true;
	    GivePlayerMoney(playerid, floatround(P[playerid][p_cash]));
	    SetPlayerHealth(playerid, P[playerid][p_health]);
	    TogglePlayerSpectating(playerid, 0);
	    SetSpawnInfo(playerid, 0, P[playerid][p_skin], 1642.4329,-2239.0205,13.4967,180.0, 0,0,0,0,0,0);
	    SendClientMessage(playerid, 0xB9C9BFFF, "Вход в учётную запись успешно выполнен.");
	    SendClientMessage(playerid, 0xB9C9BFFF, "Добро пожаловать, в игру на "SERVER_NAME);
	    SendClientMessage(playerid, 0xB9C9BFFF, "Главное меню, клавиша - '{00FF00}~k~~CONVERSATION_NO~{FFFFFF}'");
	    SendClientMessage(playerid, 0xB9C9BFFF, "Управление автомобилем, клавиша - '{00FF00}~k~~CONVERSATION_YES~{FFFFFF}'");
	    if(P[playerid][p_access] > 0) {
	        foreach(new i : Player) {
	            if(P[i][_p_in_game] == false) continue;
	            if(P[i][p_access] == 0) continue;
				va_SendClientMessage(i, 0xADFF2FFF, "Подключился %s - %s [%d]", Get_AccessName(playerid),Name(playerid),playerid);
	        }
	    }
	}
	// Создание учётной записи
	case d_account_creating: {
	    if(!response) return Kick(playerid);
	    if(strlen(inputtext) < 5 || strlen(inputtext) > 18) return ShowPlayerDialog(playerid, d_account_creating, DIALOG_STYLE_INPUT, "Создание учётной записи",SERVER_NAME"\n\n{FFFFFF}Придумайте и введите пароль для создания учётной записи.\nУсловия:\n- {B22222}От 5 до 18 символов\n{FFFFFF}- Английские буквы и цифры","Далее","Выход");
	    for(new i; i < strlen(inputtext); i++) switch(inputtext[i]) {
	        case '0'..'9': continue;
	        case 'a'..'z': continue;
	        case 'A'..'Z': continue;
	        default: return ShowPlayerDialog(playerid, d_account_creating, DIALOG_STYLE_INPUT, "Создание учётной записи",SERVER_NAME"\n\n{FFFFFF}Придумайте и введите пароль для создания учётной записи.\nУсловия:\n- От 5 до 18 символов\n- {B22222}Английские буквы и цифры","Далее","Выход");
	    }
	    WP_Hash(P[playerid][p_password], 129, inputtext);
	    ShowPlayerDialog(playerid, d_character_sex, DIALOG_STYLE_MSGBOX, "Выбор пола персонажа",SERVER_NAME"\n\n{FFFFFF}Выберите, какой будет пол у вашего персонажа?","Мужской","Женский");
	}
	// Ошибка входа
	case d_signin_failed: switch(response) {
	    case 0: return Kick(playerid);
	    case 1: return ShowPlayerDialog(playerid, d_account_signin, DIALOG_STYLE_PASSWORD, "Вход в учётную запись",SERVER_NAME"\n\n{FFFFFF}Введите пароль от своей учётной записи для входа в игру","Вход","Выход");
	}
	// Выбор пола персонажа
	case d_character_sex: {
	    P[playerid][p_sex] = response;
	    SkinShop_Show(playerid, ORG_UNKNOWN);
	}
	// Имя персонажа | Учётная запись заблокирована
	case d_character_name,d_account_banned: Kick(playerid);
	// Управление автомобилем
	case d_vehicle_control: {
	    new engine,lights,alarm,doors,bonnet,boot,objective;
	    new vehicleid = GetPlayerVehicleID(playerid);
		GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
		if(response) switch(listitem) {
		    // двигатель
		    case 0: switch(engine) {
		        case -1,0: {
		            if(Vehicle_IsNotForPlayer(vehicleid, playerid)) return 1;
		            if(Vehicle_IsPlayerWithLicense(GetVehicleModel(vehicleid), playerid) == 0) {
		                return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}У вас нет опыта и лицензии управления данным транспортным средством!");
		            }
		            if(Vehicle_WithoutFuel(GetVehicleModel(vehicleid)) == 0) {
		                if(V[vehicleid][v_fuel] <= 0) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}В автомобиле закончилось топливо!");
		            }
					SetVehicleParamsEx(vehicleid, 1,lights,alarm,doors,bonnet,boot,objective);
		        }
		        case 1: SetVehicleParamsEx(vehicleid, 0,lights,alarm,doors,bonnet,boot,objective);
		    }
		    // фары
		    case 1: switch(lights) {
		        case -1,0: SetVehicleParamsEx(vehicleid, engine,1,alarm,doors,bonnet,boot,objective);
		        case 1: SetVehicleParamsEx(vehicleid, engine,0,alarm,doors,bonnet,boot,objective);
		    }
		    // двери
		    case 2: {
		        if(Vehicle_IsNotForPlayer(vehicleid, playerid)) return 1;
		        if(Vehicle_WithoutDoor(GetVehicleModel(vehicleid)) == 1) return 1;
				switch(doors) {
		        	case -1,0: SetVehicleParamsEx(vehicleid, engine,lights,alarm,1,bonnet,boot,objective);
		        	case 1: SetVehicleParamsEx(vehicleid, engine,lights,alarm,0,bonnet,boot,objective);
		        }
		    }
		    // капот
		    case 3: switch(bonnet) {
		        case -1,0: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,1,boot,objective);
		        case 1: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,0,boot,objective);
		    }
		    // багажник
		    case 4: switch(boot) {
		        case -1,0: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,1,objective);
		        case 1: SetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,0,objective);
		    }
		    // автомобильное радио
		    case 5: {
		        new string[512];
		        for(new i; i < sizeof(Streams); i++) strcat(string, Streams[i][0]);
		        ShowPlayerDialog(playerid, d_vehicle_radio, DIALOG_STYLE_LIST, "Автомобильное радио", string, "Выбор","Отмена");
		    }
		    // отцепить трейлер
		    case 6: DetachTrailerFromVehicle(vehicleid);
		}
	}
	// Автомобильное радио
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
	    case 1: ShowPlayerDialog(playerid, d_radio_url, DIALOG_STYLE_INPUT, "Включить свой URL","{FFFFFF}Введите URL-адрес на интернет-поток с музыкой","Включить","Назад");
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
	// Включить свой URL
	case d_radio_url: switch(response) {
	    case 0: CallLocalFunction("OnDialogResponse", "dddd", playerid,6,1,5);
	    case 1: {
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, d_radio_url, DIALOG_STYLE_INPUT, "Включить свой URL","{FFFFFF}Введите URL-адрес на интернет-поток с музыкой","Включить","Назад");
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
	// Аренда транспорта
	case d_vehicle_rent: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	    	if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Количество минут должно быть от 1 до 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Недостаточно денежных средств для аренды транспорта");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "Транспортное средство арендовано на %d минут за $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_RENT); i++) {
	            if(V_RENT[i] != GetPlayerVehicleID(playerid)) continue;
	            V_RENT_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_RENT[i], ORG_UNKNOWN);
	        }
	    }
	}
	// Аренда такси
	case d_rent_taxi: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	        if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Количество минут должно быть от 1 до 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Недостаточно денежных средств для аренды транспорта");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "Автомобиль такси арендован на %d минут за $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_TAXI); i++) {
	            if(V_TAXI[i] != GetPlayerVehicleID(playerid)) continue;
	            V_TAXI_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_TAXI[i], JOB_TAXI);
	        }
	    }
	}
	// Аренда служебного транспорта
	case d_rent_engineer: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	        if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Количество минут должно быть от 1 до 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Недостаточно денежных средств для аренды транспорта");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "Автомобиль такси арендован на %d минут за $%.2f", minute,amount);
	        Cash_Give(playerid, -amount);
	        Budget_GOVERNMENT += amount;
	        for(new i; i < sizeof(V_ENGINEER); i++) {
	            if(V_ENGINEER[i] != GetPlayerVehicleID(playerid)) continue;
	            V_ENGINEER_OWNER[i] = P[playerid][p_uid];
	        	defer OnRentVehicleEnd[minute*60*1000](V_ENGINEER[i], JOB_ENGINEER);
	        }
	    }
	}
	// Аренда грузовика
	case d_rent_freighter: switch(response) {
	    case 0: RemovePlayerFromVehicle(playerid);
	    case 1: {
	        new minute = strval(inputtext);
	        if(minute < 1 || minute > 240) {
	    	    SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Количество минут должно быть от 1 до 240");
	            return RemovePlayerFromVehicle(playerid);
	    	}
	        new Float: amount = floatmul(minute, Prices_RentCar);
	        if(P[playerid][p_cash] < amount) {
	            SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Недостаточно денежных средств для аренды транспорта");
	            return RemovePlayerFromVehicle(playerid);
	        }
	        va_SendClientMessage(playerid, -1, "Автомобиль такси арендован на %d минут за $%.2f", minute,amount);
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