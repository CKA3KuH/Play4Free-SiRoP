public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(weaponid == P[playerid][p_weapon_2]) {
		P[playerid][p_ammo_2]--;
		if(P[playerid][p_ammo_2] <= 0) {
		    P[playerid][p_ammo_2] = 0;
			P[playerid][p_weapon_2] = 0;
		}
	}
	else if(weaponid == P[playerid][p_weapon_3]) {
		P[playerid][p_ammo_3]--;
		if(P[playerid][p_ammo_3] <= 0) {
		    P[playerid][p_ammo_3] = 0;
			P[playerid][p_weapon_3] = 0;
		}
	}
    return 1;
}
