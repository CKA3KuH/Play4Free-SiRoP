public OnPlayerUpdate(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(P[playerid][_p_in_game] == false) return 0;

    if(P[playerid][_p_cheater] >= 10) {
        Kick(playerid);
        return 0;
    }
    // Реактивный ранец
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) {
		printf("[Защита]: Реактивный ранец - %s[%d]", Name(playerid),playerid);
	    Kick(playerid);
	    return 0;
	}
	// Обновление спидометра
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
	    Speedo_Sync(playerid);
	}
	// Оружие
	Weapon_Sync(playerid);
	// Здоровье
	Health_Sync(playerid);
	// Бронежилет
	Armour_Sync(playerid);
	// Обновление времени
	SetPlayerTime(playerid, g_hour, g_minute);
	return 1;
}
