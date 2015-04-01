public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success) {
		new ip_dest[46];
		foreach(new i : Player) {
		    GetPlayerIp(i, ip_dest, sizeof(ip_dest));
		    if(!strcmp(ip, ip_dest, false)) continue;
		    printf("[Защита]: Взлом RCON - %s[%d] | %s", Name(i),i,ip_dest);
		    Kick(i);
		}
	}
	return 1;
}