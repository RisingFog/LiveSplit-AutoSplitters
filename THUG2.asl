state("THUG2")
{
	string16 lastCutscene : "THUG2.exe", 0x2F1058;
	string16 currentLevel : "THUG2.exe", 0x3CE698;
}

state("THUG2 English")
{
	string16 lastCutscene : "THUG2 English.exe", 0x2F1058;
	string16 currentLevel : "THUG2 English.exe", 0x3CE698;
}

init
{
	print("THUG2.exe has been found.");
	print("The current level is " + current.currentLevel);
	print("The last cutscene is " + current.lastCutscene);
}

startup
{
	vars.endingCutscene = "SK_9";
	vars.mainMenu = "mainmenu";
}

start
{
	return current.currentLevel == "BO" && current.lastCutscene == "TR_1C";
}

split
{
	return (current.currentLevel != old.currentLevel) || (current.lastCutscene == vars.endingCutscene && current.lastCutscene != old.lastCutscene);
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}
