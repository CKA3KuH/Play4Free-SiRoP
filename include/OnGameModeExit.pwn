public OnGameModeExit()
{
    SendRconCommand("unloadfs map");
    // ���������� �������
    foreach(new i : Player) CallLocalFunction("OnPlayerDisconnect", "d", i);
	// ���������� ������������
	new INI: txtfile = INI_Open("budget.ini");
	INI_WriteFloat(txtfile, "Government", Budget_GOVERNMENT);
	INI_Close(txtfile);
	txtfile = INI_Open("settings.ini");
	INI_WriteInt(txtfile, "Chat_OOC", g_Chat_OOC);
	INI_Close(txtfile);
	// ���
	for(new i; i < sizeof(PS); i++) {
		if(!PS[i][_ps_ormid]) continue;
		orm_update(PS[i][_ps_ormid]);
		orm_destroy(PS[i][_ps_ormid]);
	}
	// ���������� MySQL
	mysql_close();
	return 1;
}
