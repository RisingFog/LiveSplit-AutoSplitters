state("THAW")
{
	string16 currentLevel : "THAW.exe", 0x43F230;
	string32 loadingScreen: "THAW.exe", 0x373F04, 0x0;
	string16 lastCutscene : "THAW.exe", 0x2E8820;
	byte totalGoals : "THAW.exe", 0x43E81C, 0x78, 0x38;
	byte isRunCompleted : "THAW.exe", 0x2DD4E0, 0x8;
}

init
{
	print("THAW.exe has been found."); // Debug
	print("The current level is " + current.currentLevel); // Debug
	print("The last used loading screen is " + current.loadingScreen); // Debug
	print("The total amount of goals is " + current.totalGoals); // Debug
	print("Is the run completed? (0 for no, 1 for yes): " + current.isRunCompleted); // Debug
}

startup
{
	vars.mainMenu = "z_mainmenu";
	vars.minneapolisClassic = "loadscrn_minneapolis_classic";
}

start
{
	// Story Mode
	if (current.currentLevel == "Z_HO" && old.currentLevel == "Z_StorySelect" && current.lastCutscene == "HO_1C")
	{
		return true;
	}
	// Classic Mode
	if (current.currentLevel == "Z_DN" && old.currentLevel == vars.mainMenu && current.loadingScreen == vars.minneapolisClassic && current.totalGoals == 0)
	{
		return true;
	}
}

split
{
	// Split on change level
	if (current.currentLevel != old.currentLevel)
	{
		return true;
	}
	// Final split for Story
	if (current.lastCutscene == "SR_13a" && current.lastCutscene != old.lastCutscene)
	{
		return true;
	}
	// Final split for Classic (all variants)
	if (current.isRunCompleted == 1 && current.isRunCompleted != old.isRunCompleted && (current.currentLevel == "Z_SV2" && current.totalGoals == 52 || current.totalGoals == 60))
	{
		return true;
	}
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}
