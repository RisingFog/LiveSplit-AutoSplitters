state("Skate4")
{
	string16 currentLevel : "Skate4.exe", 0x6B6BF0;
	byte proPoints : "Skate4.exe", 0x6B5B48, 0x86c, 0x20;
	bool isLoading : "Skate4.exe", 0x6728C0;
}

init
{
	print("Skate4.exe has been found."); // Debug
	print("The current level is " + current.currentLevel); // Debug
	print("The total pro points is " + current.proPoints); // Debug
}

start
{
	if (current.currentLevel == "sch" && old.currentLevel == "skateshop" && current.proPoints == 0)
	{
		return true;
	}
}

split
{
	// Split on level changes (except when going to Skateshop)
	if (current.currentLevel != old.currentLevel && current.currentLevel != "skateshop")
	{
		return true;
	}
	// Split when pro challenge is completed (91 goals)
	if (current.proPoints == 91 && old.proPoints == 90)
	{
		return true;
	}
}

reset
{
	if (current.currentLevel == "skateshop" && current.proPoints == 0 && current.proPoints != old.proPoints)
	{
		return true;
	}
}

isLoading
{
	return current.isLoading;
}
