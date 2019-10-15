state("Vanquish", "1.0")
{
	string256 currentCutscene : "Vanquish.exe", 0xD89890, 0x3C, 0x8, 0x1C8, 0xAC;
	bool isOnTitleScreen : "Vanquish.exe", 0xCF1C4C;
	bool isMissionCompleted: "Vanquish.exe", 0xAE8250;
}

state("Vanquish", "1.1")
{
	string256 currentCutscene : "Vanquish.exe", 0xD8C8D4, 0xAC;
	bool isOnTitleScreen : "Vanquish.exe", 0xCF4C7C;
	bool isMissionCompleted: "Vanquish.exe", 0xAEB280;
}

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	switch (moduleSize) {
		case 24494080:
			version = "1.1";
			break;
		default:
			version = "1.0";
			break;
	}
	print("ModuleMemorySize: " + modules.First().ModuleMemorySize.ToString());
}

start
{
	if (current.currentCutscene.Contains("ev51.sfd") && current.currentCutscene != old.currentCutscene && !current.isOnTitleScreen)
	{
		return true;
	}
}

split
{
	// Split on mission completed
	if (current.isMissionCompleted && current.isMissionCompleted != old.isMissionCompleted)
	{
		return true;
	}
	// Final split
	if (current.currentCutscene.Contains("ev4b.sfd") && current.currentCutscene != old.currentCutscene)
	{
		return true;
	}
}
