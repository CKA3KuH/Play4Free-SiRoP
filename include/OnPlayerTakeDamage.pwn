public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	switch(weaponid) {
	    case 37,47,49..51,53,54: {
	        P[playerid][p_health] -= floatround(amount);
            if(P[playerid][p_health] < 0) P[playerid][p_health] = 0;
            SetPlayerHealth(playerid, P[playerid][p_health]);
	    }
	    default: {
	        if(P[playerid][p_armour] > 0) {
	            P[playerid][p_armour] -= floatround(amount);
	            if(P[playerid][p_armour] < 0) {
	                P[playerid][p_health] -= P[playerid][p_armour];
	                P[playerid][p_armour] = 0;
	                SetPlayerHealth(playerid, P[playerid][p_health]);
	            }
	            SetPlayerArmour(playerid, P[playerid][p_armour]);
	        }
	        else if(P[playerid][p_armour] == 0) {
	            P[playerid][p_health] -= floatround(amount);
	            if(P[playerid][p_health] < 0) P[playerid][p_health] = 0;
	            SetPlayerHealth(playerid, P[playerid][p_health]);
	        }
	    }
	}
	return 0;
}