INI:budget[](name[], value[])
{
	INI_Float("Government", Budget_GOVERNMENT);
	return 0;
}

INI:mysql[](name[], value[])
{
	INI_String("Host", g_MySQL_Host, 46);
	INI_String("User", g_MySQL_User, 46);
	INI_String("Database", g_MySQL_Database, 46);
	INI_String("Password", g_MySQL_Password, 46);
	return 0;
}

INI:prices[](name[], value[])
{
	INI_Float("Fuel", Prices_Fuel);
	INI_Float("RentCar", Prices_RentCar);
	return 0;
}

INI:settings[](name[], value[])
{
	INI_Int("Chat_OOC", g_Chat_OOC);
	INI_Float("Payment_Register", g_Payment_Register);
	return 0;
}
