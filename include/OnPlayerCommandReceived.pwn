public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
    if(success != COMMAND_OK) {
		SendClientMessage(playerid, 0xB22222FF, "[�������]: {FFFFFF}����������� ������� '{00FF00}~k~~CONVERSATION_NO~{FFFFFF}' - ������� ����");
		return COMMAND_OK;
    }

    return success;
}