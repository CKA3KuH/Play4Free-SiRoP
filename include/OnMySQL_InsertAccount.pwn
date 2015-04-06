forward OnMySQL_InsertAccount(playerid);
public OnMySQL_InsertAccount(playerid)
{
	orm_load(P[playerid][_p_ormid]);
	P[playerid][p_cash] = g_Payment_Register;
	GivePlayerMoney(playerid, floatround(P[playerid][p_cash]));
	P[playerid][_p_in_game] = true;
	TogglePlayerSpectating(playerid, 0);
	SetSpawnInfo(playerid, 0, P[playerid][p_skin], 1642.4329,-2239.0205,13.4967,180.0, 0,0,0,0,0,0);
	Command_SetAccessToCommands(playerid);
	P[playerid][p_health] = 100;
	SendClientMessage(playerid, 0xB9C9BFFF, "Создание учётной записи успешно выполнено.");
    SendClientMessage(playerid, 0xB9C9BFFF, "Добро пожаловать, в игру на "SERVER_NAME);
	SendClientMessage(playerid, 0xB9C9BFFF, "Главное меню, клавиша - '{00FF00}~k~~CONVERSATION_NO~{FFFFFF}'");
    SendClientMessage(playerid, 0xB9C9BFFF, "Управление автомобилем, клавиша - '{00FF00}~k~~CONVERSATION_YES~{FFFFFF}'");
}