state("THawk2")
{
	string16 currentLevel : "THawk2.exe", 0x29D198;
	int careerTotalCash : "THawk2.exe", 0x1656D0;
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
	if (current.currentLevel == "Hangar" && old.currentLevel == "" && current.careerTotalCash == 0)
	{
		return true;
	}
}

split
{
	// Split on level changes (except when going to main menu)
	if (current.currentLevel != old.currentLevel && old.currentLevel != "")
	{
		return true;
	}
	// Split when final medal is collected
	if ((current.careerTotalCash == (old.careerTotalCash + 12500) || (current.careerTotalCash == (old.careerTotalCash + 62500))) && current.currentLevel == "Bullring")
	{
		return true;
	}
}

isLoading
{
	return current.isGamePaused == 1 || current.isRunPaused == 1;
}
