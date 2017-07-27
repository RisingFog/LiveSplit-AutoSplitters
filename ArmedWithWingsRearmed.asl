state("Armed with Wings Rearmed", "1.0.2")
{
	byte startingLevel : "Adobe AIR.dll", 0x13BBA6C, 0x1EC, 0x9C, 0x260;
	int sessionTimer : "Adobe AIR.dll", 0x13BBA6C, 0x1EC, 0x9C, 0x1E4;
	bool inGame : "Adobe AIR.dll", 0x13BBA6C, 0x1EC, 0x9C, 0x98;
	bool fromGametoMenu : "Adobe AIR.dll", 0x13BBA6C, 0x1EC, 0x9C, 0xC0;
	bool fromCutscenetoGame : "Adobe AIR.dll", 0x13BBA6C, 0x1EC, 0x9C, 0x90;
	int sessionScore : "Adobe AIR.dll", 0x13BBA6C, 0x1EC, 0x9C, 0x1E4;
}

state("Armed with Wings Rearmed", "1.0.3")
{
	byte startingLevel : "Adobe AIR.dll", 0x13BC92C, 0x1EC, 0x9C, 0x260;
	int sessionTimer : "Adobe AIR.dll", 0x13BC92C, 0x1EC, 0x9C, 0x1E4;
	bool inGame : "Adobe AIR.dll", 0x13BC92C, 0x1EC, 0x9C, 0x98;
	bool fromGametoMenu : "Adobe AIR.dll", 0x13BC92C, 0x1EC, 0x9C, 0xC0;
	bool fromCutscenetoGame : "Adobe AIR.dll", 0x13BC92C, 0x1EC, 0x9C, 0x90;
	int sessionScore : "Adobe AIR.dll", 0x13BC92C, 0x1EC, 0x9C, 0x1E4;
}

init
{
	int moduleSize = modules.First(x => x.ModuleName == "Adobe AIR.dll").ModuleMemorySize;
	switch (moduleSize) {
		case 22806528:
			version = "1.0.2";
			break;
		case 22810624:
			version = "1.0.3";
			break;
	}
	print("ModuleMemorySize: " + modules.First(x => x.ModuleName == "Adobe AIR.dll").ModuleMemorySize.ToString());
}

start
{
	if (current.startingLevel == 1 && current.sessionTimer == 0 && current.inGame && current.inGame != old.inGame)
	{
		return true;
	}
}

split
{
	// Split on level changes
	if (current.startingLevel != old.startingLevel)
	{
		return true;
	}
	// Final split
	if (current.startingLevel == 40 && !current.inGame && current.fromGametoMenu && old.fromGametoMenu != current.fromGametoMenu && current.sessionScore > 0 && current.sessionTimer > 0)
	{
		return true;
	}
}
