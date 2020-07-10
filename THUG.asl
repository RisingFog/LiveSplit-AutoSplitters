state("THUG")
{
	string16 lastCutscene : 0x36A7C8;
	string16 currentLevel : 0x36B638;
	byte chapterNumber : 0x36A788, 0x64C;
	bool isLoading : 0x29851C, 0x24, 0x174;
}

state("THUGONE")
{
	string16 lastCutscene : 0x36A7C8;
	string16 currentLevel : 0x36B638;
	byte chapterNumber : 0x36A788, 0x64C;
	bool isLoading : 0x29851C, 0x24, 0x174;
}

startup
{
	vars.startingCutscene = "Intro_02";
	vars.endingCutscene = "NJ_10";
	vars.mainMenu = "skateshop";
	vars.njSkateshop = "nj_skateshop";
	vars.Manhattan = "NY";
	vars.ManhattanPart2Cutscene = "NY_03";
	vars.casBedroom = "cas_bedroom";
	vars.NewJersey = "NJ";
	vars.Moscow = "RU";
	vars.proGoalsChapter = 25;
	vars.finalChapter = 26;
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
	bool isProGoals = current.chapterNumber == vars.proGoalsChapter;
	bool doneProGoals = current.chapterNumber == vars.finalChapter;
	// Ignore the level transition from the CAS Bedroom to New Jersey or NJ Skateshop to Manhattan
	if (startRun || isNYPart2 || endSCJ)
	{
		print("Ignored the level");
		return false;
	}
	// Most splits should be handled by this, avoids splitting on change to NJ Skateshop and during pro goals
	if (current.currentLevel != old.currentLevel && !isNJSkateshop && !isProGoals)
	{
		print("Most splits");
		return true;
	}
	// Split at the start of pro goals
	if (isProGoals && !isNJSkateshop && old.currentLevel == vars.njSkateshop)
	{
		print("Start pro goals");
		return true;
	}
	// Split at the end of pro goals
	if (doneProGoals && current.currentLevel == vars.NewJersey && current.chapterNumber != old.chapterNumber)
	{
		print("Done pro goals");
		return true;
	}
	// Final split at the last New Jersey Cutscene
	if (current.lastCutscene == vars.endingCutscene && current.lastCutscene != old.lastCutscene)
	{
		print("Final split");
		return true;
	}
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}

isLoading
{
	return current.isLoading;
}
