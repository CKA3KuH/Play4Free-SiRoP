public OnPlayerRequestClass(playerid, classid)
{
	if(P[playerid][_p_in_game] == true) {
        SetSpawnInfo(playerid, 0, P[playerid][p_skin], 0.0,0.0,0.0,0.0, 0,0,0,0,0,0);
        SpawnPlayer(playerid);
	}
	return 1;
}