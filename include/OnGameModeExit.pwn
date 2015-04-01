public OnGameModeExit()
{
    SendRconCommand("unloadfs map");
    // Обновление игроков
    foreach(new i : Player) CallLocalFunction("OnPlayerDisconnect", "dd", i,1);
	// Обновление конфигурации
	new INI: txtfile = INI_Open("budget.ini");
	INI_WriteFloat(txtfile, "Government", Budget_GOVERNMENT);
	INI_Close(txtfile);
	txtfile = INI_Open("settings.ini");
	INI_WriteInt(txtfile, "Chat_OOC", g_Chat_OOC);
	INI_Close(txtfile);
	// АЗС
	for(new i; i < sizeof(PS); i++) {
		if(!PS[i][_ps_ormid]) continue;
		orm_update(PS[i][_ps_ormid]);
		orm_destroy(PS[i][_ps_ormid]);
	}
	// Отключение MySQL
	mysql_close();
	return 1;
}