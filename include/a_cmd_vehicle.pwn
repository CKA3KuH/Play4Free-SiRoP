CMD:lock(playerid, params[])
{
    if(P[playerid][_p_in_game] == false) return 1;
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;

    new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x,y,z);
	foreach(new i : Vehicle) {
		if(!IsVehicleStreamedIn(i, playerid)) continue;
		new Float: dist = GetVehicleDistanceFromPoint(i, x,y,z);
		if(dist > 2.5) continue;
		if(Vehicle_IsNotForPlayer(i, playerid)) continue;
		if(Vehicle_WithoutDoor(GetVehicleModel(i)) == 1) return 1;
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(i, engine,lights,alarm,doors,bonnet,boot,objective);
		switch(doors) {
			case -1,0: {
				SetVehicleParamsEx(i, engine,lights,alarm,1,bonnet,boot,objective);
				GameTextForPlayer(playerid, "vehicle~n~~r~closed", 2000, 1);
			}
			case 1: {
				SetVehicleParamsEx(i, engine,lights,alarm,0,bonnet,boot,objective);
				GameTextForPlayer(playerid, "vehicle~n~~g~open", 2000, 1);
			}
		}
		break;
	}
    return 1;
}

CMD:fill(playerid, params[])
{
    if(P[playerid][_p_in_game] == false) return 1;
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;

    for(new i; i < sizeof(PS); i++) {
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, PS[i][ps_pos_x],PS[i][ps_pos_y],PS[i][ps_pos_z])) continue;

		new Float: volume, Float: amount;
		new vehicleid = GetPlayerVehicleID(playerid);
		if(sscanf(params, "f", volume)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /fill <объём>");
		if(volume <= 0 || volume > Vehicle_GetMaxFuel(GetVehicleModel(vehicleid))) return va_SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Объем заправляемого не может превышать %d литров", Vehicle_GetMaxFuel(GetVehicleModel(vehicleid)));
		if((volume + V[vehicleid][v_fuel]) > Vehicle_GetMaxFuel(GetVehicleModel(vehicleid))) return va_SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Объем заправляемого не может превышать %d литров", Vehicle_GetMaxFuel(GetVehicleModel(vehicleid)));
		amount = volume * Prices_Fuel;
		//if(amount == 0) amount = 1;
		Cash_Give(playerid, -amount);
		V[vehicleid][v_fuel] += volume;
		PS[i][ps_volume] -= volume;
		PS[i][ps_profit] += amount;
		va_SendClientMessage(playerid, -1, "Автомобиль заправлен на %.1f литров за $%.2f", volume,amount);
    }
	return 1;
}
