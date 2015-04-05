stock Get_AccessName(playerid)
{
	new dest[15];
	switch(P[playerid][p_access]) {
	    case 0: dest = "Простой игрок";
	    case 1: dest = "Помощник";
	    case 2: dest = "Модератор";
	    case 3: dest = "Супермодератор";
	    case 4: dest = "Администратор";
	    case 5: dest = "Разработчик";
	}
	return dest;
}

stock Get_TeamName(playerid)
{
	new dest[32];
	switch(P[playerid][p_job_team]) {
		case ORG_UNKNOWN: dest = "Неизвестная организация";
		case ORG_GOVERNMENT: dest = "Правительство Штата";
		case ORG_FBI: dest = "Федеральное Бюро Расследований";
		case ORG_LSPD: dest = "Полиция Лос Сантос";
		case ORG_SFPD: dest = "Полиция Сан Фиерро";
		case ORG_LVPD: dest = "Полиция Лас Вентурас";
		case ORG_MILITARY: dest = "Национальная Гвардия";
		case ORG_EMERGENCY: dest = "Служба Экстренной Помощи";
		case ORG_SANNEWS: dest = "Новости Сан Андреас";
		case ORG_AUTOSCHOOL: dest = "Центр Аттестации";
		case ORG_GROVE: dest = "Банда Grove Street";
		case ORG_BALLAS: dest = "Банда Ballas";
		case ORG_AZTECAS: dest = "Банда Aztecas";
		case ORG_VAGOS: dest = "Банда Vagos";
		case ORG_DANANG: dest = "Банда Da Nang";
		case ORG_RIFA: dest = "Банда Rifa";
		case ORG_CHINESE: dest = "Семья 'Триада'";
		case ORG_RUSSIAN: dest = "Семья 'Воры в законе'";
		case ORG_ITALIAN: dest = "Семья 'Ла Коза Ностра'";
		case JOB_TAXI: dest = "Таксист";
		case JOB_ENGINEER: dest = "Инженер";
		case JOB_FREIGHTER: dest = "Грузоперевозчик";
	}
	return dest;
}

stock Vehicle_IsNotForPlayer(vehicleid, playerid)
{
	for(new i; i < sizeof(V_FBI); i++) {
	    if(vehicleid != V_FBI[i]) continue;
	    if(P[playerid][p_job_team] != ORG_FBI) return 1;
	    return 0;
	}
	for(new i; i < sizeof(V_LSPD); i++) {
	    if(vehicleid != V_LSPD[i]) continue;
	    if(P[playerid][p_job_team] != ORG_FBI && P[playerid][p_job_team] != ORG_LSPD) return 1;
	    return 0;
	}
	for(new i; i < sizeof(V_SFPD); i++) {
	    if(vehicleid != V_SFPD[i]) continue;
	    if(P[playerid][p_job_team] != ORG_FBI && P[playerid][p_job_team] != ORG_SFPD) return 1;
	    return 0;
	}
	for(new i; i < sizeof(V_LVPD); i++) {
	    if(vehicleid != V_LVPD[i]) continue;
	    if(P[playerid][p_job_team] != ORG_FBI && P[playerid][p_job_team] != ORG_LVPD) return 1;
	    return 0;
	}
	for(new i; i < sizeof(V_MILITARY); i++) {
	    if(vehicleid != V_MILITARY[i]) continue;
	    if(P[playerid][p_job_team] != ORG_FBI && P[playerid][p_job_team] != ORG_MILITARY) return 1;
	    return 0;
	}
	for(new i; i < sizeof(V_EMERGENCY); i++) {
	    if(vehicleid != V_EMERGENCY[i]) continue;
	    if(P[playerid][p_job_team] != ORG_FBI && P[playerid][p_job_team] != ORG_EMERGENCY) return 1;
	    return 0;
	}
	for(new i; i < sizeof(V_TAXI); i++) {
		if(vehicleid != V_TAXI[i]) continue;
		if(P[playerid][p_job_team] != JOB_TAXI) return 1;
		return 0;
	}
	for(new i; i < sizeof(V_ENGINEER); i++) {
		if(vehicleid != V_ENGINEER[i]) continue;
		if(P[playerid][p_job_team] != JOB_ENGINEER) return 1;
		return 0;
	}
	for(new i; i < sizeof(V_FREIGHTER); i++) {
		if(vehicleid != V_FREIGHTER[i]) continue;
		if(P[playerid][p_job_team] != JOB_FREIGHTER) return 1;
		return 0;
	}
	for(new i; i < sizeof(V_RENT); i++) {
	    if(vehicleid != V_RENT[i]) continue;
	    if(V_RENT_OWNER[i] != P[playerid][p_uid]) return 1;
	    return 0;
	}
	return 0;
}

stock Vehicle_GetMaxFuel(vehiclemodel)
{
	switch(vehiclemodel) {
	    // bikes
	    case 448,461..463,468,471,521..523,581,586: return 50;
	    // convertibles
	    case 439,480,533,555: return 75;
	    // industrial
	    case 403,408,413,414,422,440,443,455,456,459,478,482,498,499,514,515,524,531,543,552,554,578,582,600,605,609: return 150;
	    // lowriders
	    case 412,534..536,566,567,575,576: return 75;
	    // off road
	    case 424,568: return 50;
	    case 400,444,470,489,495,500,505,556,557,573,579: return 100;
	    // public service
	    case 407,416,420,427,438,490,528,544,596..599,601: return 75;
	    case 431..433,437: return 150;
	    // saloons
	    case 401,405,410,419,421,426,436,445,466,467,474,491,492,504,507,516..518,526,527,529,540,542,546,547,549..551,560,562,580,585,604: return 75;
	    // sport
	    case 402,411,415,429,451,475,477,494,496,502,503,506,541,558,559,565,587,589,602,603: return 75;
	    // station wagons
	    case 404,418,458,479,561: return 100;
	    // unique
	    case 406,486: return 150;
	    case 409,423,428,434,442,483,508,525,532,545,588: return 75;
	    case 457,485,530,539,571,572,574,583: return 50;
	}
	return 0;
}

stock Vehicle_WithoutFuel(vehiclemodel)
{
	switch(vehiclemodel) {
	    // air vehicles
	    case 417,425,447,460,469,476,487,488,497,511..513,519,520,548,553,563,577,592,593: return 1;
	    // boats
	    case 430,446,452..454,472,473,484,493,595: return 1;
	    // bikes
	    case 481,509,510: return 1;
	    // trailers
	    case 435,450,569,570,584,590,591,606..608,610,611: return 1;
	    // unique
	    case 449,537,538: return 1;
	    // RC
	    case 441,464,465,501,564,594: return 1;
	}
	return 0;
}

stock Vehicle_WithoutDoor(vehiclemodel)
{
	switch(vehiclemodel) {
	    // bikes
	    case 448,461..463,468,471,481,509,510,521..523,581,586: return 1;
	}
	return 0;
}

stock Vehicle_IsPlayerWithLicense(vehiclemodel, playerid)
{
	switch(vehiclemodel) {
	    // moto
	    case 461,463,468,471,521..523,581,586: return P[playerid][p_lic_moto];
	    // car
	    case 400..402,404,405,409,410..412,415,418..422,424,426,429,434,436,438,439,442,444,445,451,458,466,467,470,474,475,477..479,480,483,490..492,494..496,500,502..507,516..518,525..529,533..535,536,540..543,545..547,549..552,554..559,560..562,565..568,575,576,579,580,585,587,589,596..599,600,602..605: return P[playerid][p_lic_car];
	    // freight
	    case 403,406..408,413,414,416,423,427,428,431..433,437,440,443,455,456,459,482,486,498,499,508,514,515,524,531,532,544,573,578,582,588,601,609: return P[playerid][p_lic_freight];
	    // helicopter
	    case 417,425,447,469,487,488,497,563,548: return P[playerid][p_lic_helicopter];
	    // aircraft
	    case 460,476,511..513,519,520,553,577,592,593: return P[playerid][p_lic_aircraft];
	    // boat
	    case 430,446,452..454,472,473,484,493,595: return P[playerid][p_lic_boat];
	    // other
	    default: return 1;
	}
	return 0;
}

stock Vehicle_Add(model, Float:x, Float:y, Float:z, Float:angle, color1 = (-1), color2 = (-1))
{
	new vehicleid = CreateVehicle(model, x,y,z,angle, color1,color2, -1);

	if(vehicleid == INVALID_VEHICLE_ID) return vehicleid;

	SetVehicleNumberPlate(vehicleid, "P4F SiRoP");
	V[vehicleid][v_fuel] = Vehicle_GetMaxFuel(model);
	Iter_Add(Vehicle, vehicleid);
	return vehicleid;
}

stock Vehicle_Speed(vehicleid)
{
    new Float: x, Float: y, Float: z;
	GetVehicleVelocity(vehicleid, x,y,z);
	new Float: f_KMH = floatsqroot(((x * x) + (y * y)) + (z * z)) * 179.0;
	return floatround(f_KMH);
}

stock SkinShop_Show(playerid, team)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) TogglePlayerControllable(playerid, 0);
	switch(P[playerid][p_sex]) {
	    case SEX_FEMALE: TextDrawSetPreviewModel(skinshop_text, female_skins[team][1]);
	    case SEX_MALE: TextDrawSetPreviewModel(skinshop_text, male_skins[team][1]);
	}
	TextDrawShowForPlayer(playerid, skinshop_text);
	ShowMenuForPlayer(skinshop_menu, playerid);
	P[playerid][_p_skin_shop] = 1;
}

stock Cash_Give(playerid, Float: amount)
{
	P[playerid][p_cash] = floatadd(P[playerid][p_cash],amount);
	GivePlayerMoney(playerid, floatround(amount));
}

stock Name(playerid)
{
    new dest[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, dest, MAX_PLAYER_NAME);
	return dest;
}

stock Name_IsValid(const string[])
{
	new earth;
	for(new i; i < strlen(string); i++) {
		switch(string[i]) {
		    case 'a'..'z': continue;
		    case 'A'..'Z': continue;
		    case '_': earth++;
			default: return false;
        }
    }
    if(earth != 1) return false;

	return true;
}

stock IC_Name(playerid)
{
	new dest[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, dest, MAX_PLAYER_NAME);
	for(new i; i < strlen(dest); i++) {
		if(dest[i] == '_') {
			dest[i] = ' ';
			break;
		}
	}
	return dest;
}

stock IC_Me(playerid, action[])
{
	new Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x,y,z);
	SetPlayerChatBubble(playerid, action, 0xDDA0DDFF, 35.0, 5000);
	foreach(new i : Player) {
	    if(!P[i][_p_in_game]) continue;
	    if(!IsPlayerInRangeOfPoint(i, 35.0, x,y,z)) continue;
	    if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid)) continue;
	    if(GetPlayerInterior(i) != GetPlayerInterior(playerid)) continue;
	    va_SendClientMessage(i, 0xDDA0DDFF, "%s %s", IC_Name(playerid),action);
	}
	return 1;
}

stock Message_ToAll(color, const fmat[], va_args<>)
{
	foreach(new i : Player) {
		if(!P[i][_p_in_game]) continue;
		SendClientMessage(i, color, va_return(fmat, va_start<2>));
	}
}

stock containsAnyIP(const string[])
{
	new digits, digitGroups;
	for(new pos; ; pos++) {
		switch(string[pos]) {
			case 0: break;
			case '0'..'9', 'o', 'O', 'о', 'О', 'з', 'З': digits++;
			default: {
				if(digits >= 2) {
					digitGroups++;
					digits = 0;
				}
			}
		}
	}
	if(digits >= 2) digitGroups++;
	if(digitGroups >= 4) return 1;
	return 0;
}

stock strtolower(source[])
{
	for(new i; i < strlen(source); i++) switch(source[i]) {
		case 168: source[i] = 184;
		case 192..223: source[i] = (source[i] + 32);
		default: source[i] = tolower(source[i]);
	}
}

stock Weapon_Sync(playerid)
{
    if(P[playerid][_p_spawned] == false) return 1;
	switch(GetPlayerState(playerid)) {
	    case 0,7..9: return 1;
	}
    new weapon[13], ammo[13];
	for(new i; i < 13; i++) {
	    GetPlayerWeaponData(playerid, i, weapon[i], ammo[i]);
	    if(ammo[i] <= 0) continue;
	    switch(weapon[i]) {
	        case 0,46: continue;
	        case 1,10..18,33..42,44,45: {
				ResetPlayerWeapons(playerid);
				P[playerid][p_weapon_1] = 0;
				P[playerid][p_weapon_2] = 0;
				P[playerid][p_weapon_3] = 0;
				P[playerid][p_ammo_2] = 0;
				P[playerid][p_ammo_3] = 0;
				printf("[Защита]: Чёрный список оружия - %s[%d] | W: %d / A: %d", Name(playerid),playerid,weapon[i],ammo[i]);
				P[playerid][_p_cheater]++;
			}
			default: {
			    if(weapon[i] == P[playerid][p_weapon_1]) continue;
			    else if(weapon[i] == P[playerid][p_weapon_2]) {
			        if(ammo[i] > P[playerid][p_ammo_2]+1 && ammo[i] > P[playerid][p_ammo_2]+2) {
						printf("[Защита]: Несоответствие патронов - %s[%d] | %d | C: %d / S: %d",
							Name(playerid),playerid,weapon[i],ammo[i],P[playerid][p_ammo_2]);
						SetPlayerAmmo(playerid, P[playerid][p_weapon_2], P[playerid][p_ammo_2]);
						P[playerid][_p_cheater]++;
			        }
			    }
			    else if(weapon[i] == P[playerid][p_weapon_3]) {
			        if(ammo[i] > P[playerid][p_ammo_3]+1 && ammo[i] > P[playerid][p_ammo_3]+2) {
						printf("[Защита]: Несоответствие патронов - %s[%d] | %d | C: %d / S: %d",
							Name(playerid),playerid,weapon[i],ammo[i],P[playerid][p_ammo_3]);
						SetPlayerAmmo(playerid, P[playerid][p_weapon_3], P[playerid][p_ammo_3]);
						P[playerid][_p_cheater]++;
			        }
			    } else {
			        printf("[Защита]: Несоответствие оружия - %s[%d] | %d / %d",
						Name(playerid),playerid,weapon[i],ammo[i]);
			        ResetPlayerWeapons(playerid);
			        if(P[playerid][p_weapon_1] != 0) GivePlayerWeapon(playerid, P[playerid][p_weapon_1],1);
					if(P[playerid][p_weapon_2] != 0) GivePlayerWeapon(playerid, P[playerid][p_weapon_2],P[playerid][p_ammo_2]);
					if(P[playerid][p_weapon_3] != 0) GivePlayerWeapon(playerid, P[playerid][p_weapon_3],P[playerid][p_ammo_3]);
					P[playerid][_p_cheater]++;
			    }
			} // default
	    } // switch
	} // for
	return 1;
}

stock Health_Sync(playerid)
{
	if(P[playerid][_p_spawned] == false) return 1;
	switch(GetPlayerState(playerid)) {
	    case 0,7..9: return 1;
	}
    new Float: fhealth;
	GetPlayerHealth(playerid, fhealth);
	new health = floatround(fhealth);
	if(health > P[playerid][p_health]) {
	    if(IsPlayerNearVending(playerid)) {
			P[playerid][p_health] += 5;
			if(P[playerid][p_health] > 100) P[playerid][p_health] = 100;
			SetPlayerHealth(playerid, P[playerid][p_health]);
	    } else {
	        printf("[Защита]: Несоответствие здоровья - %s[%d] | C: %d / S: %d",
				Name(playerid),playerid,health,P[playerid][p_health]);
	        SetPlayerHealth(playerid, P[playerid][p_health]);
	        P[playerid][_p_cheater]++;
	    }
	}
	return 1;
}

stock Armour_Sync(playerid)
{
    if(P[playerid][_p_spawned] == false) return 1;
	switch(GetPlayerState(playerid)) {
	    case 0,7..9: return 1;
	}
    new Float: farmour;
	GetPlayerArmour(playerid, farmour);
	new armour = floatround(farmour);
	if(armour > P[playerid][p_armour]) {
	    printf("[Защита]: Несоответствие бронежилета - %s[%d] | C: %d / S: %d",
			Name(playerid),playerid,armour,P[playerid][p_armour]);
	    SetPlayerArmour(playerid, P[playerid][p_armour]);
	    P[playerid][_p_cheater]++;
	}
	return 1;
}

stock Speedo_Sync(playerid)
{
    new engine,lights,alarm,doors,bonnet,boot,objective;
	new string[102],str_E[5],str_L[5],str_D[5];
	new vehicleid = GetPlayerVehicleID(playerid);
	new KMH = Vehicle_Speed(vehicleid);
	GetVehicleParamsEx(vehicleid, engine,lights,alarm,doors,bonnet,boot,objective);
	switch(engine) {
	    case -1,0: {
			str_E = "~r~E";
			KMH = 0;
		}
	    case 1: str_E = "~g~E";
	}
	switch(lights) {
	    case -1,0: str_L = "~r~L";
	    case 1: str_L = "~g~L";
	}
	switch(doors) {
	    case -1,0: str_D = "~g~D";
	    case 1: str_D = "~r~D";
	}
	switch(Vehicle_WithoutFuel(GetVehicleModel(vehicleid))) {
		case 0: format(string, sizeof(string), "~w~%d ~b~KM/H~n~FUEL: ~w~%.0f~n~%s %s %s", KMH,V[vehicleid][v_fuel],str_E,str_L,str_D);
		case 1: format(string, sizeof(string), "~w~%d ~b~KM/H~n~%s %s %s", KMH,str_E,str_L,str_D);
	}
	PlayerTextDrawSetString(playerid, P[playerid][_p_speedo], string);
}