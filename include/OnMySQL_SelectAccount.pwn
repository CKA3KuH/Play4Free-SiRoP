forward OnMySQL_SelectAccount(playerid);
public OnMySQL_SelectAccount(playerid)
{
	switch(orm_errno(P[playerid][_p_ormid])) {
	    case ERROR_OK: ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "���� � ������� ������",SERVER_NAME"\n\n{FFFFFF}������� ������ �� ����� ������� ������ ��� ����� � ����","����","�����");
	    case ERROR_NO_DATA: ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "�������� ������� ������",SERVER_NAME"\n\n{FFFFFF}���������� � ������� ������ ��� �������� ������� ������.\n�������:\n- �� 5 �� 18 ��������\n- ���������� ����� � �����","�����","�����");
	}
	orm_setkey(P[playerid][_p_ormid], "UID");
	GetPlayerIp(playerid, P[playerid][p_last_ip], 46);
}
