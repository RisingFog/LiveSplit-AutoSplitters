state("THUG")
{
	string16 lastCutscene : "THUG.exe", 0x30A230;
	string16 currentLevel : "THUG.exe", 0x30B0A0;
}

init
{
	print("THUG.exe has been found."); // Debug
	print("The current level is " + current.currentLevel); // Debug
	print("The last cutscene is " + current.lastCutscene); // Debug
}

startup
{
	vars.startingCutscene = "Intro_02";
	vars.proGoalsCutscene = "NJ_07";
	vars.endProGoalsCutscene = "NJ_09";
	vars.endingCutscene = "NJ_10";
	vars.mainMenu = "skateshop";
	vars.njSkateshop = "nj_skateshop";
	vars.Manhattan = "NY";
	vars.ManhattanPart2Cutscene = "NY_03";
	vars.casBedroom = "cas_bedroom";
}

start
{
	return current.lastCutscene == vars.startingCutscene;
}

split
{
	bool startRun = current.currentLevel == "NJ" && old.currentLevel == vars.casBedroom;
	bool endSCJ = current.currentLevel == "VC" && old.currentLevel == vars.casBedroom;
	bool isNJSkateshop = current.currentLevel == vars.njSkateshop;
	bool isNYPart2 = current.currentLevel == vars.Manhattan && current.lastCutscene == vars.ManhattanPart2Cutscene;
	bool isProGoals = current.lastCutscene == vars.proGoalsCutscene;
	bool doneProGoals = current.lastCutscene == vars.endProGoalsCutscene && old.lastCutscene == vars.proGoalsCutscene;
	// Ignore the level transition from the CAS Bedroom to New Jersey or NJ Skateshop to Manhattan
	if (startRun || isNYPart2 || endSCJ)
	{
		print("Ignored the level"); // Debug
		return false;
	}
	// Most splits should be handled by this, avoids splitting on change to NJ Skateshop and during pro goals
	if (current.currentLevel != old.currentLevel && !isNJSkateshop && !isProGoals || doneProGoals)
	{
		print("Most splits"); // Debug
		return true;
	}
	// Split at the start of pro goals
	if (isProGoals && !isNJSkateshop && old.currentLevel == vars.njSkateshop)
	{
		print("Start pro goals"); // Debug
		return true;
	}
	// Final split at the last New Jersey Cutscene
	if (current.lastCutscene == vars.endingCutscene && current.lastCutscene != old.lastCutscene)
	{
		print("Final split"); // Debug
		return true;
	}
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}
