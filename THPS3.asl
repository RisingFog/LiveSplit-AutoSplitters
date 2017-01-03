state("Skate3")
{
	string32 currentLevel : "Skate3.exe", 0x45B558;
	bool isPaused : "Skate3.exe", 0x450BC8;
	bool isTimerRunning : "Skate3.exe", 0x450BC0;
	bool isLoading : "Skate3.exe", 0x1D0620;
	string32 moviePlayed : "Skate3.exe", 0x1D0861;
	string32 streamPlayed : "Skate3.exe", 0x1D0971;
	byte compRanking : "Skate3.exe", 0x4E1E90, 0x45c, 0x160;
	byte roundNumber : "Skate3.exe", 0x4E1E90, 0x45c, 0x0; // Starts from 0 instead of 1
	bool isCompetitionOver : "Skate3.exe", 0x4E1E90, 0x45c, 0x15c;
}

init
{
	print("Skate3.exe has been found."); // Debug
	print("The current level script is " + current.currentLevel); // Debug
}

startup
{
	vars.mainMenu = "levels\\skateshop\\skateshop.qb";
	vars.Foundry = "levels\\foun\\foun.qb";
	vars.Tokyo = "levels\\tok\\tok.qb";
	vars.CruiseShip = "levels\\shp\\shp.qb";
	vars.creditsMovie = "\\data\\movies\\credits.mpg";
	vars.tokyoCompStart = false;
}

start
{
	if (current.currentLevel == vars.Foundry && old.currentLevel == vars.mainMenu)
	{
		return true;
	}
}

update
{
	if (!vars.tokyoCompStart && current.currentLevel == vars.Tokyo && !current.isCompetitionOver && current.isCompetitionOver != old.isCompetitionOver)
	{
		vars.tokyoCompStart = true;
	}
	else if (vars.tokyoCompStart && current.currentLevel != vars.Tokyo)
	{
		vars.tokyoCompStart = false;
	}
}

split
{
	// Split on change level (except for Tokyo to Cruise Ship)
	if (current.currentLevel != old.currentLevel && current.currentLevel != vars.CruiseShip && old.currentLevel != vars.Tokyo)
	{
		return true;
	}
	// Final split for any%
	if (current.currentLevel == vars.Tokyo && current.compRanking <= 3 && vars.tokyoCompStart && current.isCompetitionOver && current.isCompetitionOver != old.isCompetitionOver)
	{
		return true;
	}
	// Final split for All Goals
	if (current.moviePlayed == vars.creditsMovie && current.moviePlayed != old.moviePlayed)
	{
		return true;
	}
}

reset
{
	if (current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu)
	{
		return true;
	}
}

isLoading
{
	return current.isLoading || !current.isTimerRunning || current.isPaused;
}
