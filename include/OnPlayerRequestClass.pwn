public OnPlayerRequestClass(playerid, classid)
{
	if(P[playerid][_p_in_game] == true) {
        SetSpawnInfo(playerid, 0, P[playerid][p_skin], 1642.4329,-2239.0205,13.4967,180.0, 0,0,0,0,0,0);
        SpawnPlayer(playerid);
	}
	return 1;
}
