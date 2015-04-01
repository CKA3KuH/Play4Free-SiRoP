public OnPlayerDisconnect(playerid, reason)
{
	if(P[playerid][_p_ormid]) {
	    if(P[playerid][_p_in_game] == true) orm_update(P[playerid][_p_ormid]);
	    orm_destroy(P[playerid][_p_ormid]);
	}
	for(new i; i < sizeof(P[]); i++) P[playerid][E_PLAYER_DATA: i] = 0;

	StopAudioStreamForPlayer(playerid);
	return 1;
}