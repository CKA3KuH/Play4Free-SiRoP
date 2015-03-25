public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu: m_current = GetPlayerMenu(playerid);
	new team = P[playerid][p_job_team];
	new s_current = P[playerid][_p_skin_shop];
	if(m_current == skinshop_menu) switch(P[playerid][p_sex]) {
	    case SEX_FEMALE: switch(row) {
	        case 0: {
	            if(s_current == female_skins[team][0]) s_current = 1;
	            else s_current++;
	            TextDrawHideForPlayer(playerid, skinshop_text);
	            TextDrawSetPreviewModel(skinshop_text, female_skins[team][s_current]);
				TextDrawShowForPlayer(playerid, skinshop_text);
				ShowMenuForPlayer(skinshop_menu, playerid);
	        }
	        case 1: {
	            if(s_current == 1) s_current = female_skins[team][0];
	            else s_current--;
	            TextDrawHideForPlayer(playerid, skinshop_text);
	            TextDrawSetPreviewModel(skinshop_text, female_skins[team][s_current]);
				TextDrawShowForPlayer(playerid, skinshop_text);
				ShowMenuForPlayer(skinshop_menu, playerid);
	        }
	        case 2: {
	            TextDrawHideForPlayer(playerid, skinshop_text);
	            P[playerid][p_skin] = female_skins[team][s_current];
	            switch(P[playerid][_p_in_game]) {
	                case false: orm_insert(P[playerid][_p_ormid], "OnMySQL_InsertAccount", "d", playerid);
	                case true: {
	                    TogglePlayerControllable(playerid, 1);
	                    SetPlayerSkin(playerid, P[playerid][p_skin]);
	                }
	            }
	        }
	    }
	    case SEX_MALE: switch(row) {
	        case 0: {
	            if(s_current == male_skins[team][0]) s_current = 1;
	            else s_current++;
	            TextDrawHideForPlayer(playerid, skinshop_text);
	            TextDrawSetPreviewModel(skinshop_text, male_skins[team][s_current]);
				TextDrawShowForPlayer(playerid, skinshop_text);
				ShowMenuForPlayer(skinshop_menu, playerid);
	        }
	        case 1: {
	            if(s_current == 1) s_current = male_skins[team][0];
	            else s_current--;
	            TextDrawHideForPlayer(playerid, skinshop_text);
	            TextDrawSetPreviewModel(skinshop_text, male_skins[team][s_current]);
				TextDrawShowForPlayer(playerid, skinshop_text);
				ShowMenuForPlayer(skinshop_menu, playerid);
	        }
	        case 2: {
	            TextDrawHideForPlayer(playerid, skinshop_text);
	            P[playerid][p_skin] = male_skins[team][s_current];
	            switch(P[playerid][_p_in_game]) {
	                case false: orm_insert(P[playerid][_p_ormid], "OnMySQL_InsertAccount", "d", playerid);
	                case true: {
	                    TogglePlayerControllable(playerid, 1);
	                    SetPlayerSkin(playerid, P[playerid][p_skin]);
	                }
	            }
	        }
	    }
	}
	P[playerid][_p_skin_shop] = s_current;
	return 1;
}
