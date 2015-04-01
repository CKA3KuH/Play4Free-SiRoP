CMD:car(playerid, params[])
{
    if(!P[playerid][_p_in_game]) return 1;
    if(!P[playerid][p_access]) return 1;

	new model, color1 = (-1), color2 = (-1);
	sscanf(params, "iii", model,color1,color2);
	if(isnull(params)) return SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте /car <модель> [цвет1] [цвет2]");

	new Float: x, Float: y, Float: z, Float: a;
	GetPlayerPos(playerid, x,y,z);
	GetPlayerFacingAngle(playerid, a);
	Vehicle_Add(model, x+1,y+1,z,a, color1,color2);
	return 1;
}

CMD:repair(playerid, params[])
{
    if(!P[playerid][_p_in_game]) return 1;
    if(!P[playerid][p_access]) return 1;
    if(!IsPlayerInAnyVehicle(playerid)) return 0;

    RepairVehicle(GetPlayerVehicleID(playerid));
    GameTextForPlayer(playerid, "vehicle~n~~g~repaired", 2000, 1);
	return 1;
}