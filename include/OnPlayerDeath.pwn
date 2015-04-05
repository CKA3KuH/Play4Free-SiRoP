public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerTextDrawHide(playerid, P[playerid][_p_cent]);
	P[playerid][p_health] = 0;
	P[playerid][_p_spawned] = false;
	return 1;
}
