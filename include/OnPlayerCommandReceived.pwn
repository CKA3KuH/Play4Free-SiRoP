public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
    if(!P[playerid][_p_in_game]) return COMMAND_OK;

    if(success != COMMAND_OK) {
		SendClientMessage(playerid, 0xB22222FF, "[Справка]: {FFFFFF}Используйте клавишу '{00FF00}~k~~CONVERSATION_NO~{FFFFFF}' - главное меню");
		return COMMAND_OK;
    }

    return success;
}