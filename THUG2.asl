state("THUG2")
{
	string16 lastCutscene : "THUG2.exe", 0x2F1058;
	string16 currentLevel : "THUG2.exe", 0x3CE698;
	string32 loadingScreen: "THUG2.exe", 0x27E95C, 0x0;
	byte totalClassicGoals : "THUG2.exe", 0x3CE478, 0x20, 0x5EE;
	byte isRunCompleted : "THUG2.exe", 0x2F3624, 0x1A18, 0xC;
}

state("THUG2 English")
{
	string16 lastCutscene : "THUG2 English.exe", 0x2F1058;
	string16 currentLevel : "THUG2 English.exe", 0x3CE698;
	string32 loadingScreen: "THUG2 English.exe", 0x27E95C, 0x0;
	byte totalClassicGoals : "THUG2 English.exe", 0x3CE478, 0x20, 0x5EE;
	byte isRunCompleted : "THUG2 English.exe", 0x2F3624, 0x1A18, 0xC;
}

state("THEMOD 1.3")
{
	string16 lastCutscene : "THEMOD 1.3.exe", 0x2F1058;
	string16 currentLevel : "THEMOD 1.3.exe", 0x3CE698;
	string32 loadingScreen: "THEMOD 1.3.exe", 0x27E95C, 0x0;
	byte totalClassicGoals : "THEMOD 1.3.exe", 0x3CE478, 0x20, 0x5EE;
	byte isRunCompleted : "THEMOD 1.3.exe", 0x2F3624, 0x1A18, 0xC;
}

init
{
	print("THUG2.exe has been found."); // Debug
	print("The current level is " + current.currentLevel); // Debug
	print("The last cutscene is " + current.lastCutscene); // Debug
	print("The last used loading screen is " + current.loadingScreen); // Debug
	print("The total amount of classic goals is " + current.totalClassicGoals); // Debug
	print("Is the run completed? (0 for no, 1 for yes): " + current.isRunCompleted); // Debug
}

startup
{
	vars.endingCutscene = "SK_9";
	vars.mainMenu = "mainmenu";
	vars.barcelonaClassic = "loadscrn_barcelona_classic";
}

start
{
	// Story Mode
	if (current.currentLevel == "BO" && current.lastCutscene == "TR_1C")
	{
		return true;
	}
	// Classic Mode
	if (current.loadingScreen == vars.barcelonaClassic && old.loadingScreen != current.loadingScreen && current.totalClassicGoals == 0)
	{
		return true;
	}
}

split
{
	// Split on change level
	if (current.currentLevel != old.currentLevel && old.currentLevel != vars.mainMenu)
	{
		return true;
	}
	// Final split for Story
	if (current.lastCutscene == vars.endingCutscene && current.lastCutscene != old.lastCutscene)
	{
		return true;
	}
	// Final split for Classic (all variants)
	if (current.isRunCompleted == 1 && current.isRunCompleted != old.isRunCompleted && (current.currentLevel == "SE2" && (current.totalClassicGoals == 130 || current.totalClassicGoals == 60 || current.totalClassicGoals == 80)))
	{
		return true;
	}
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}
