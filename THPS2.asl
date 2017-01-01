state("THawk2")
{
	string16 currentLevel : "THawk2.exe", 0x29D198;
	int compCash : "THawk2.exe", 0x15CB8C;
	byte isGamePaused : "THawk2.exe", 0x15E864;
	byte isRunPaused : "THawk2.exe", 0x29E050;
}

init
{
	print("THawk2.exe has been found."); // Debug
	print("The current level is " + current.currentLevel); // Debug
	print("The total career cash total is " + current.careerTotalCash); // Debug
	print("Is the game paused? (1/Yes 0/No) " + current.isGamePaused); // Debug
	print("Is the timer paused? (1/Yes 0/No) " + current.isRunPaused); // Debug
}

start
{
	if (current.currentLevel == "Hangar" && old.currentLevel == "")
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