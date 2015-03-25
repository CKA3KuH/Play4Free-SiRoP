public OnPlayerExitedMenu(playerid)
{
	new Menu: m_current = GetPlayerMenu(playerid);
    if(m_current == skinshop_menu) switch(P[playerid][_p_in_game]) {
        case false: ShowMenuForPlayer(skinshop_menu, playerid);
        case true: {
			TogglePlayerControllable(playerid, 1);
	    	TextDrawHideForPlayer(playerid, skinshop_text);
	    }
	}
	return 1;
}
