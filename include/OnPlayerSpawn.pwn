public OnPlayerSpawn(playerid)
{
	SetPlayerColor(playerid, 0xFFFFFFFF);
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, floatround(P[playerid][p_cash]));
	new string[16];
	format(string, sizeof(string), "%.0f Cent", floatmul(floatfract(P[playerid][p_cash]), 100.0));
	PlayerTextDrawSetString(playerid, P[playerid][_p_cent], string);
	PlayerTextDrawShow(playerid, P[playerid][_p_cent]);
	switch(P[playerid][p_job_team]) {
	    case ORG_FBI: {
	        SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 1214.8512,-1675.8368,11.7969);
			SetPlayerFacingAngle(playerid, 308.0);
	    }
	    default: switch(random(3)) {
	        case 0: {
	        	SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 1642.4329,-2239.0205,13.4967);
				SetPlayerFacingAngle(playerid, 180.0);
			}
			case 1: {
			    SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, -1968.7249,161.8742,27.6875);
				SetPlayerFacingAngle(playerid, 180.0);
			}
			case 2: {
			    SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 2851.9583,1290.4894,11.3906);
				SetPlayerFacingAngle(playerid, 90.0);
			}
	    }
	}
	TogglePlayerClock(playerid, 1);
	SetCameraBehindPlayer(playerid);
	SetPlayerSkin(playerid, P[playerid][p_skin]);
	if(P[playerid][p_health] <= 0 || P[playerid][p_health] > 100) P[playerid][p_health] = 100;
	SetPlayerHealth(playerid, P[playerid][p_health]);
	SetPlayerArmour(playerid, P[playerid][p_armour]);
	ResetPlayerWeapons(playerid);
	if(P[playerid][p_weapon_1] != 0) GivePlayerWeapon(playerid, P[playerid][p_weapon_1], 1);
	if(P[playerid][p_weapon_2] != 0) GivePlayerWeapon(playerid, P[playerid][p_weapon_2], P[playerid][p_ammo_2]);
	if(P[playerid][p_weapon_3] != 0) GivePlayerWeapon(playerid, P[playerid][p_weapon_3], P[playerid][p_ammo_3]);
	P[playerid][_p_spawned] = true;
	return 1;
}