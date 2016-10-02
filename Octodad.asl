state("OctodadDadliestCatch")
{
	string16 currentLevel : "OctodadDadliestCatch.exe", 0x2B2B58, 0xD0, 0x8, 0xC4, 0x0;
	bool isLoading : "OctodadDadliestCatch.exe", 0x2B2B68, 0xAA;
	bool isStoryMode : "OctodadDadliestCatch.exe", 0x2B2B58, 0x13A;
}

init
{
	print("OctodadDadliestCatch.exe has been found."); // Debug
	print("The current level is " + current.currentLevel); // Debug
}

start
{
	// WIP
	// return !current.isLoading && current.currentLevel.Contains("Church_Main.irr") && current.isStoryMode;
}

split
{
	// WIP
	// return !current.isLoading && !current.currentLevel.Contains("MainScreen") && !old.currentLevel.Contains("MainScreen") && current.currentLevel != old.currentLevel;
}

isLoading
{
	return current.isLoading;
}
