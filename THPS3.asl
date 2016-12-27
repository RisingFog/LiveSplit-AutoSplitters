state("Skate3")
{
	string32 currentLevel : "Skate3.exe", 0x45B558;
	bool isPaused : "Skate3.exe", 0x450BC8;
	bool isTimerRunning : "Skate3.exe", 0x450BC8;
	bool isLoading : "Skate3.exe", 0x1D0620;
	string32 moviePlayed : "Skate3.exe", 0x1D0861;
	string32 streamPlayed : "Skate3.exe", 0x1D0971;
	
}

init
{
	print("Skate3.exe has been found."); // Debug
	print("The current level script is " + current.currentLevel); // Debug
}

startup
{
	vars.mainMenu = "levels\skateshop\skateshop.qb";
	vars.crowdTokyo = "\data\streams\tok\crowdI01.mp3";
	vars.Foundry = "levels\Foun\Foun.qb";
	vars.Tokyo = "levels\Tok\Tok.qb";
	vars.creditsMovie = "\data\movies\credits.mpg"
	vars.proBailsMovie = "\data\movies\bails01.mpg"
}

start
{
	if (current.currentLevel == vars.Foundry && old.currentLevel == vars.mainMenu)
	{
		return true;
	}
}

split
{
	// Split on change level (except for Tokyo to Cruise Ship)
	if (current.currentLevel != old.currentLevel && old.currentLevel != vars.Tokyo)
	{
		return true;
	}
	// Final split for any%
	if (current.moviePlayed == vars.proBailsMovie && current.moviePlayed != old.moviePlayed)
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
	return current.currentLevel == vars.mainMenu && old.currentLevel != vars.mainMenu;
}

isLoading
{
	return current.isLoading || current.isTimerRunning || current.isPaused;
}
