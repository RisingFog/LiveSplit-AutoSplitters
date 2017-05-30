state("TransformersDevastation")
{
	string32 currentCutscene : "TransformersDevastation.exe", 0x762DF4, 0x2D8, 0x1DC, 0x588;
	bool isMissionCompleted: "TransformersDevastation.exe", 0xA6A684;
}

start
{
	if (current.currentCutscene == "movie/cs1010.usm" && current.currentCutscene != old.currentCutscene)
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
}
