public OnPlayerConnect(playerid)
{
	TogglePlayerSpectating(playerid, 1);
	GetPlayerName(playerid, P[playerid][p_name], MAX_PLAYER_NAME);
	if(!Name_IsValid(P[playerid][p_name])) return ShowPlayerDialog(playerid, d_character_name, DIALOG_STYLE_MSGBOX, "Имя персонажа",SERVER_NAME"\n\n{B22222}Имя вашего персонажа несоответствует нашим условиям.\nПравильный формат:\n\n\t{FFFFFF}Имя_Фамилия (на английском)","Выход","");

	new ORM: ormid = P[playerid][_p_ormid] = orm_create("accounts");

	orm_addvar_int(ormid, P[playerid][p_uid], "UID");
	orm_addvar_string(ormid, P[playerid][p_name], MAX_PLAYER_NAME+1, "Name");
	orm_addvar_string(ormid, P[playerid][p_password], 129, "Password");
	orm_addvar_int(ormid, P[playerid][p_access], "Access");
	orm_addvar_string(ormid, P[playerid][p_unban_date], 16, "Unban_Date");
	orm_addvar_string(ormid, P[playerid][p_last_ip], 46, "Last_IP");
	orm_addvar_float(ormid, P[playerid][p_cash], "Cash");
	orm_addvar_int(ormid, P[playerid][p_sex], "Sex");
	orm_addvar_int(ormid, P[playerid][p_skin], "Skin");
	orm_addvar_int(ormid, P[playerid][p_job_team], "Job_Team");
	orm_addvar_int(ormid, P[playerid][p_health], "Health");
	orm_addvar_int(ormid, P[playerid][p_armour], "Armour");
	orm_addvar_int(ormid, P[playerid][p_weapon_1], "Weapon_1");
	orm_addvar_int(ormid, P[playerid][p_weapon_2], "Weapon_2");
	orm_addvar_int(ormid, P[playerid][p_weapon_3], "Weapon_3");
	orm_addvar_int(ormid, P[playerid][p_ammo_2], "Ammo_2");
	orm_addvar_int(ormid, P[playerid][p_ammo_3], "Ammo_3");
	orm_addvar_int(ormid, P[playerid][p_lic_moto], "Lic_Moto");
	orm_addvar_int(ormid, P[playerid][p_lic_car], "Lic_Car");
	orm_addvar_int(ormid, P[playerid][p_lic_freight], "Lic_Freight");
	orm_addvar_int(ormid, P[playerid][p_lic_boat], "Lic_Boat");
	orm_addvar_int(ormid, P[playerid][p_lic_helicopter], "Lic_Helicopter");
	orm_addvar_int(ormid, P[playerid][p_lic_aircraft], "Lic_Aircraft");
	orm_addvar_int(ormid, P[playerid][p_lic_business], "Lic_Business");
	orm_addvar_int(ormid, P[playerid][p_lic_weapon], "Lic_Weapon");

	orm_setkey(ormid, "Name");
	orm_select(ormid, "OnMySQL_SelectAccount", "d", playerid);

	P[playerid][_p_speedo] = CreatePlayerTextDraw(playerid, 520.0, 340.0, "~w~123.0 ~b~KM/H~n~FUEL: ~w~123~n~~g~E ~g~L ~g~D");
	PlayerTextDrawLetterSize(playerid, P[playerid][_p_speedo], 0.5, 2.0);
	PlayerTextDrawTextSize(playerid, P[playerid][_p_speedo], 80.0, 160.0);
	PlayerTextDrawAlignment(playerid, P[playerid][_p_speedo], 2);
	PlayerTextDrawColor(playerid, P[playerid][_p_speedo], 41215);
	PlayerTextDrawUseBox(playerid, P[playerid][_p_speedo], 1);
	PlayerTextDrawBoxColor(playerid, P[playerid][_p_speedo], 51);
	PlayerTextDrawSetShadow(playerid, P[playerid][_p_speedo], 0);
	PlayerTextDrawSetOutline(playerid, P[playerid][_p_speedo], 1);
	PlayerTextDrawBackgroundColor(playerid, P[playerid][_p_speedo], 255);
	PlayerTextDrawFont(playerid, P[playerid][_p_speedo], 2);
	PlayerTextDrawSetProportional(playerid, P[playerid][_p_speedo], 1);

	P[playerid][_p_cent] = CreatePlayerTextDraw(playerid, 607.0, 97.0, "12 cent");
	PlayerTextDrawLetterSize(playerid, P[playerid][_p_cent], 0.5, 2.1);
	PlayerTextDrawAlignment(playerid, P[playerid][_p_cent], 3);
	PlayerTextDrawColor(playerid, P[playerid][_p_cent], 0x33AA33AD);
	PlayerTextDrawSetShadow(playerid, P[playerid][_p_cent], 0);
	PlayerTextDrawSetOutline(playerid, P[playerid][_p_cent], 2);
	PlayerTextDrawBackgroundColor(playerid, P[playerid][_p_cent], 0x000000FF);
	PlayerTextDrawFont(playerid, P[playerid][_p_cent], 3);
	PlayerTextDrawSetProportional(playerid, P[playerid][_p_cent], 1);
	return 1;
}