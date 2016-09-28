state("THUG2")
{
	string16 lastCutscene : "THUG2.exe", 0x2F1058;
	string16 currentLevel : "THUG2.exe", 0x3CE698;
	string32 loadingScreen: "THUG2.exe", 0x27E95C, 0x0;
	byte totalClassicGoals : "THUG2.exe", 0x3CE478, 0x20, 0x5EE;
}

state("THUG2 English")
{
	string16 lastCutscene : "THUG2 English.exe", 0x2F1058;
	string16 currentLevel : "THUG2 English.exe", 0x3CE698;
	string32 loadingScreen: "THUG2 English.exe", 0x27E95C, 0x0;
	byte totalClassicGoals : "THUG2 English.exe", 0x3CE478, 0x20, 0x5EE;
}

init
{
	print("THUG2.exe has been found.");
	print("The current level is " + current.currentLevel);
	print("The last cutscene is " + current.lastCutscene);
	print("The last used loading screen is " + current.loadingScreen);
	print("The total amount of classic goals is " + current.totalClassicGoals);
}

startup
{
	vars.endingCutscene = "SK_9";
	vars.mainMenu = "mainmenu";
	vars.barcelonaClassic = "loadscrn_barcelona_classic";
}

start
{
	return (current.currentLevel == "BO" && current.lastCutscene == "TR_1C") || (current.currentLevel == "BA" && old.currentLevel == vars.mainMenu && current.loadingScreen == vars.barcelonaClassic && current.totalClassicGoals == 0);
}

split
{
	return (current.currentLevel != old.currentLevel) || (current.lastCutscene == vars.endingCutscene && current.lastCutscene != old.lastCutscene);
}

reset
{
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}
