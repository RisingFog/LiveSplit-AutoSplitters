state("NieRAutomata")
{
    bool isWorldLoaded : 0x110ADC0;
    byte playerNameSetStatus : 0x147B4BC;
    string32 currentCutscene : 0x19925E0, 0x1F4;
    bool isCutscenePlaying : 0x1415B10;
}

startup
{
	vars.Cutscenes = new string[] {
	"movie/ev0140.usm",
	"movie/ev0260.usm",
	"movie/ev0320.usm",
	"movie/ev0330.usm",
	"movie/ev0350.usm",
	"movie/ev0400.usm",
	"movie/ev0480.usm",
	"movie/ev0540.usm",
	"movie/ev0570.usm",
	"movie/ev0655.usm",
	"movie/ev0690.usm"
	};
}

start 
{
    if (current.playerNameSetStatus == 1 && current.isWorldLoaded && current.isWorldLoaded != old.isWorldLoaded)
    {
        return true;
    }
}

split
{
    foreach (string cutscene in vars.Cutscenes)
	{
		if (current.currentCutscene == cutscene && current.isCutscenePlaying && current.isCutscenePlaying != old.isCutscenePlaying)
		{
			return true;
		}
	}
}
