state("Vanquish")
{
	string32 lastCheckpoint : "Vanquish.exe", 0xD2B1A0;
	string256 currentCutscene : "Vanquish.exe", 0xD89890, 0x3C, 0x8, 0x1C8, 0xAC;
	bool isOnTitleScreen : "Vanquish.exe", 0xCF1C4C;
	bool isMissionCompleted: "Vanquish.exe", 0xAE8250;
}

start
{
	if (current.lastCheckpoint == "C100_START" && current.lastCheckpoint != old.lastCheckpoint && !current.isOnTitleScreen)
	{
		return true;
	}
}

split
{
	// Split on mission completed
	if (current.isMissionCompleted && current.isMissionCompleted != old.isMissionCompleted)
	{
		return true;
	}
	// Final split
	if (current.currentCutscene.Contains("ev4b.sfd") && current.currentCutscene != old.currentCutscene)
	{
		return true;
	}
}

reset
{
	return current.isOnTitleScreen && current.isOnTitleScreen != old.isOnTitleScreen;
}
