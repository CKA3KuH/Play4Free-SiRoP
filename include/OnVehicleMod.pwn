public OnVehicleMod(playerid, vehicleid, componentid)
{
    if(GetPlayerInterior(playerid) == 0) {
        printf("[������]: ����������� ������ - %s[%d]", Name(playerid),playerid);
	    Kick(playerid);
        RemoveVehicleComponent(vehicleid, componentid);
        return 0;
    }
	return 1;
}
