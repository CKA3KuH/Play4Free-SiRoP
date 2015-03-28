CMD:o(playerid, params[])
{
	if(!P[playerid][_p_in_game]) return 1;
	if(!strlen(params)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /o <текст>");

	switch(P[playerid][p_access]) {
		case 0: {
			if(g_Chat_OOC == 0) return 1;
			if((gettime() - P[playerid][_p_chat_time]) < 3) return 1;
			if(containsAnyIP(params)) return 1;
			strtolower(params);
			if(strlen(P[playerid][_p_chat_msg]) == strlen(params)) {
				if(strcmp(P[playerid][_p_chat_msg], params, true) == 0) return 1;
			}
			switch(strlen(params)) {
				case 0..64: Message_ToAll(0xE0FFFFFF, "<< %s[%d]: %s", Name(playerid),playerid,params);
				default: {
				    new line1[65], line2[65];
				    strmid(line1, params, 0, 64);
				    strmid(line2, params, 64, 129);
				    Message_ToAll(0xE0FFFFFF, "<< %s[%d]: %s", Name(playerid),playerid,line1);
				    Message_ToAll(0xE0FFFFFF, line2);
				}
			}
			format(P[playerid][_p_chat_msg], 128, params);
			P[playerid][_p_chat_time] = gettime();
		}
		default: switch(strlen(params)) {
			case 0..64: Message_ToAll(0xE0FFFFFF, "<< %s %s[%d]: %s", Get_AccessName(playerid),Name(playerid),playerid,params);
			default: {
			    new line1[33], line2[97];
			    strmid(line1, params, 0, 32);
			    strmid(line2, params, 32, 129);
			    Message_ToAll(0xE0FFFFFF, "<< %s %s[%d]: %s", Get_AccessName(playerid),Name(playerid),playerid,line1);
			    Message_ToAll(0xE0FFFFFF, line2);
			}
		}
	}
	return 1;
}

CMD:b(playerid, params[])
{
    if(!P[playerid][_p_in_game]) return 1;
    if(!strlen(params)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /b <текст>");
    if((gettime() - P[playerid][_p_chat_time]) < 3) return 1;
	if(containsAnyIP(params)) return 1;
	strtolower(params);
	if(strlen(P[playerid][_p_chat_msg]) == strlen(params)) {
		if(strcmp(P[playerid][_p_chat_msg], params, true) == 0) return 1;
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	foreach(new i : Player) {
	    if(P[i][_p_in_game] == false) continue;
	    if(!IsPlayerInRangeOfPoint(i, 70.0, x,y,z)) continue;
	    if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid)) continue;
	    if(GetPlayerInterior(i) != GetPlayerInterior(playerid)) continue;
	    switch(strlen(params)) {
	        case 0..64: va_SendClientMessage(i, 0xFFDEADFF, "(( %s[%d]: %s", Name(playerid),playerid,params);
	        default: {
	            new line1[49], line2[81];
	            strmid(line1, params, 0, 48);
	            strmid(line2, params, 48, 129);
	            va_SendClientMessage(i, 0xFFDEADFF, "(( %s[%d]: %s", Name(playerid),playerid,line1);
	            SendClientMessage(i, 0xFFDEADFF, line2);
	        }
	    }
	}
	format(P[playerid][_p_chat_msg], 128, params);
	P[playerid][_p_chat_time] = gettime();
	return 1;
}

CMD:s(playerid, params[])
{
    if(!P[playerid][_p_in_game]) return 1;
    if(!strlen(params)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /s <текст>");
    if((gettime() - P[playerid][_p_chat_time]) < 3) return 1;
    if(containsAnyIP(params)) return 1;
    strtolower(params);
	if(strlen(P[playerid][_p_chat_msg]) == strlen(params)) {
		if(strcmp(P[playerid][_p_chat_msg], params, true) == 0) return 1;
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	SetPlayerChatBubble(playerid, params, 0xFFFF00FF, 70.0, 5000);
	ApplyAnimation(playerid, "RIOT", "RIOT_shout", 4.1, 0, 1,1, 0, 0, 1);
	foreach(new i : Player) {
	    if(P[i][_p_in_game] == false) continue;
	    if(!IsPlayerInRangeOfPoint(i, 70.0, x,y,z)) continue;
	    if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid)) continue;
	    if(GetPlayerInterior(i) != GetPlayerInterior(playerid)) continue;
	    switch(strlen(params)) {
	        case 0..64: va_SendClientMessage(i, -1, "%s кричит: %s!", IC_Name(playerid),params);
	        default: {
	            new line1[65], line2[65];
	            strmid(line1, params, 0, 64);
	            strmid(line2, params, 64, 129);
	            va_SendClientMessage(i, -1, "%s кричит: %s", IC_Name(playerid),line1);
	            va_SendClientMessage(i, -1, "%s%c", line2,'!');
	        }
	    }
	}
	format(P[playerid][_p_chat_msg], 128, params);
	P[playerid][_p_chat_time] = gettime();
	return 1;
}

CMD:me(playerid, params[])
{
    if(!P[playerid][_p_in_game]) return 1;
    if(!strlen(params)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /me <действие>");
    if(containsAnyIP(params)) return 1;

    strtolower(params);
	IC_Me(playerid, params);
	return 1;
}

CMD:try(playerid, params[])
{
	if(!P[playerid][_p_in_game]) return 1;
	if(!strlen(params)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /try <действие>");
    if(containsAnyIP(params)) return 1;

	new string[128];
	switch(random(2)) {
	    case 0: format(string, sizeof(string), "неудачно %s", params);
	    case 1: format(string, sizeof(string), "удачно %s", params);
	}
	IC_Me(playerid, string);
	return 1;
}
