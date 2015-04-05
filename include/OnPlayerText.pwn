public OnPlayerText(playerid, text[])
{
	if(!P[playerid][_p_in_game]) return 0;
	if((gettime() - P[playerid][_p_chat_time]) < 3) return 0;
	if(containsAnyIP(text)) return 0;
	if(strlen(P[playerid][_p_chat_msg]) == strlen(text)) {
		if(strcmp(P[playerid][_p_chat_msg], text, true) == 0) return 0;
	}
	strtolower(text);
	format(P[playerid][_p_chat_msg], 128, text);
	SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 35.0, 5000);
	ApplyAnimation(playerid, "ped", "IDLE_chat", 4.1, 0, 1,1, 0, 0, 1);
	new Float: x, Float: y, Float: z;
	new line1[128], line2[128];
	if(strlen(text) > 64) {
		new pos = strfind(text, " ", false, 64);
		if(pos == (-1)) pos = 64;
		strmid(line1, text, 0, pos);
		strmid(line2, text, pos, strlen(text));
	}
	GetPlayerPos(playerid, x,y,z);
	foreach(new i : Player) {
	    if(!P[i][_p_in_game]) continue;
	    if(!IsPlayerInRangeOfPoint(i, 35.0, x,y,z)) continue;
	    if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid)) continue;
	    if(GetPlayerInterior(i) != GetPlayerInterior(playerid)) continue;
	    switch(P[playerid][p_sex]) {
		    case SEX_FEMALE: switch(strlen(text)) {
				case 0..64: va_SendClientMessage(i, -1, "%s сказала: %s", IC_Name(playerid),text);
				default: {
				    va_SendClientMessage(i, -1, "%s сказала: %s", IC_Name(playerid),line1);
				    SendClientMessage(i, -1, line2);
				}
			}
		    case SEX_MALE: switch(strlen(text)) {
				case 0..64: va_SendClientMessage(i, -1, "%s сказал: %s", IC_Name(playerid),text);
				default: {
				    va_SendClientMessage(i, -1, "%s сказал: %s", IC_Name(playerid),line1);
				    SendClientMessage(i, -1, line2);
				}
			}
		}
	}
	P[playerid][_p_chat_time] = gettime();
	return 0;
}