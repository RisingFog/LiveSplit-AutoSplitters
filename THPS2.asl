state("THawk2")
{
	string16 currentLevel : "THawk2.exe", 0x29D198;
	int compCash : "THawk2.exe", 0x15CB8C;
	bool isGamePaused : "THawk2.exe", 0x15E864;
	bool isRunPaused : "THawk2.exe", 0x29E050;
	bool isRunStarted : "THawk2.exe", 0x16B238;
}

start
{
	if (current.currentLevel == "Hangar" && !current.isRunPaused && old.isRunPaused && current.isRunStarted && !old.isRunStarted)
	{
		return true;
	}
}

init
{
	current.currentLevel = "none";
}

update
{
	if (current.currentLevel == "")
	{
		current.currentLevel = old.currentLevel;
	}
}

split
{
	// Split on level changes (except when going to main menu)
	if (current.currentLevel != old.currentLevel && current.currentLevel != "" && current.isRunStarted && !old.isRunStarted)
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
	return current.isGamePaused || current.isRunPaused;
}
