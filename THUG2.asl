state("THUG2")
{
	string16 lastCutscene : 0x2F1058;
	string16 currentLevel : 0x3CE698;
	string32 loadingScreen: 0x27E95C, 0x0;
	byte totalClassicGoals : 0x3CE478, 0x20, 0x5EE;
	byte isRunCompleted : 0x2F3624, 0x1A18, 0xC;
	bool isLoading : 0x2FC49C;
}

state("THUG2 English")
{
	string16 lastCutscene : 0x2F1058;
	string16 currentLevel : 0x3CE698;
	string32 loadingScreen: 0x27E95C, 0x0;
	byte totalClassicGoals : 0x3CE478, 0x20, 0x5EE;
	byte isRunCompleted : 0x2F3624, 0x1A18, 0xC;
	bool isLoading : 0x2FC49C;
}

state("THEMOD 1.3")
{
	string16 lastCutscene : 0x2F1058;
	string16 currentLevel : 0x3CE698;
	string32 loadingScreen: 0x27E95C, 0x0;
	byte totalClassicGoals : 0x3CE478, 0x20, 0x5EE;
	byte isRunCompleted : 0x2F3624, 0x1A18, 0xC;
	bool isLoading : 0x2FC49C;
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
	if (current.currentLevel == "BO")
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
	if (current.isRunCompleted == 1 && current.isRunCompleted != old.isRunCompleted && (current.currentLevel == "SE2" && current.totalClassicGoals == 130 || current.totalClassicGoals == 60 || current.totalClassicGoals == 80))
	{
		return true;
	}
}

isLoading
{
	return current.isLoading;
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}
