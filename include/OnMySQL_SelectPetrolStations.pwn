forward OnMySQL_SelectPetrolStations();
public OnMySQL_SelectPetrolStations()
{
	new ownername[24];
	new string[152];
	for(new x; x < sizeof(PS); x++) {
	    PS[x][_ps_ormid] = orm_create("petrol_stations");

	    orm_addvar_int(PS[x][_ps_ormid], PS[x][ps_uid], "UID");
	    orm_setkey(PS[x][_ps_ormid], "UID");
	    orm_addvar_string(PS[x][_ps_ormid], PS[x][ps_name], 30, "Name");
	    orm_addvar_int(PS[x][_ps_ormid], PS[x][ps_volume], "Volume");
	    orm_addvar_int(PS[x][_ps_ormid], PS[x][ps_owner], "Owner");
	    orm_addvar_float(PS[x][_ps_ormid], PS[x][ps_profit], "Profit");
	    orm_addvar_float(PS[x][_ps_ormid], PS[x][ps_pos_x], "Pos_X");
	    orm_addvar_float(PS[x][_ps_ormid], PS[x][ps_pos_y], "Pos_Y");
	    orm_addvar_float(PS[x][_ps_ormid], PS[x][ps_pos_z], "Pos_Z");

	    orm_apply_cache(PS[x][_ps_ormid], x);

	    switch(PS[x][ps_owner]) {
		    case 0: ownername = "Правительство штата";
		    default: format(ownername, sizeof(ownername), "UID: %d", PS[x][ps_owner]);
		}
		format(string, sizeof(string),
			"%s\n\
			Владелец: %s\n\
			Цистерна: %d из %d литров\n\
			Цена: $%.2f за 1 литр бензина",
			PS[x][ps_name],ownername,PS[x][ps_volume],FUEL_TANK_LIMIT,Prices_Fuel);
		PS[x][_ps_text3d] = CreateDynamic3DTextLabel(string, 0x4682B4FF, PS[x][ps_pos_x],PS[x][ps_pos_y],PS[x][ps_pos_z]+1,35.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1,0,0);
	}
}
