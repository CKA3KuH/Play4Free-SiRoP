forward OnMySQL_SelectAccount(playerid);
public OnMySQL_SelectAccount(playerid)
{
	switch(orm_errno(P[playerid][_p_ormid])) {
	    case ERROR_OK: ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Вход в учётную запись",SERVER_NAME"\n\n{FFFFFF}Введите пароль от своей учётной записи для входа в игру","Вход","Выход");
	    case ERROR_NO_DATA: ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "Создание учётной записи",SERVER_NAME"\n\n{FFFFFF}Придумайте и введите пароль для создания учётной записи.\nУсловия:\n- От 5 до 18 символов\n- Английские буквы и цифры","Далее","Выход");
	}
	orm_setkey(P[playerid][_p_ormid], "UID");
	GetPlayerIp(playerid, P[playerid][p_last_ip], 46);
}
