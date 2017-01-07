state("THawk2")
{
	string16 currentLevel : "THawk2.exe", 0x29D198;
	int compCash : "THawk2.exe", 0x15CB8C;
	byte isGamePaused : "THawk2.exe", 0x15E864;
	byte isRunPaused : "THawk2.exe", 0x29E050;
}

start
{
	if (current.currentLevel == "Hangar" && current.isRunPaused == 0 and old.isRunPaused == 1)
	{
		return true;
	}
}

split
{
	// Split on level changes (except when going to main menu)
	if (current.currentLevel != old.currentLevel && current.currentLevel != "")
	{
		return true;
	}
	// Split when final medal is collected
	if (current.compCash >= 12500 && current.compCash != old.compCash && current.currentLevel == "Bullring")
	{
		return true;
	}
}

isLoading
{
	return current.isGamePaused == 1 || current.isRunPaused == 1;
}
