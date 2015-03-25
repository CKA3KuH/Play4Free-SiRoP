public OnPlayerClickMap(playerid, Float: fX, Float: fY, Float: fZ)
{
	if(P[playerid][p_access] < 3) return 1;

	switch(GetPlayerState(playerid)) {
	    case 0,7..9: return 1;
	    case 1,3..6: {
	        if(GetPlayerInterior(playerid) != 0) SetPlayerInterior(playerid, 0);
	        if(GetPlayerVirtualWorld(playerid) != 0) SetPlayerVirtualWorld(playerid, 0);
	        SetPlayerPosFindZ(playerid, fX,fY,fZ+0.1);
	    }
	    case 2: SetVehiclePos(GetPlayerVehicleID(playerid), fX,fY,fZ+0.1);
	}
	return 1;
}
