state("NieRAutomata", "1.0")
{
	// NOT IMPLEMENTED
	bool isWorldLoaded : 0x110ADC0;
	byte playerNameSetStatus : 0x147B4BC;
	string32 currentCutscene : 0x19925E0, 0x1F4;
	bool isCutscenePlaying : 0x1415B10;
}

state("NieRAutomata", "1.01")
{
	bool isWorldLoaded : 0x110ADC0;
	byte playerNameSetStatus : 0x147B4BC;
	string32 currentCutscene : 0x19925E0, 0x1F4;
	bool isCutscenePlaying : 0x1415B10;
}

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	switch (moduleSize) {
		case 113471488:
			version = "1.0";
			break;
		case 106266624:
			version = "1.01";
			break;
        	default:
			// Presumed to be current Steam Version
			version = "1.01";
			break;
	}
	print("ModuleMemorySize: " + modules.First().ModuleMemorySize.ToString());
}

startup
{
	vars.Cutscenes = new string[] {
	// Ending A Cutscenes
	"movie/ev0140.usm", // Prologue Finish [A/B]
	"movie/ev0260.usm", // Adam Desert Fight Finish
	"movie/ev0320.usm", // Beauvoir Fight Finish
	"movie/ev0330.usm", // Engels City Fight Finish [A/B]
	"movie/ev0350.usm", // Negotiations Finish
	"movie/ev0400.usm", // A2 Fight Finish [A/B]
	"movie/ev0482.usm", // Grun Fight Finish
	"movie/ev0550.usm", // Copied City Finish
	"movie/ev0570.usm", // So-Shi Fight Finish [A/B]
	"movie/ev0655.usm", // Boko-Shi Fight Finish [A/B]
	"movie/ev0693.usm", // Ending A Finish
	// Ending B Cutscenes
	"movie/ev0262.usm", // Adam Desert Fight Finish
	"movie/ev0322.usm", // Beauvoir Fight Finish
	"movie/ev0352.usm", // Negotiations Finish
	"movie/ev0483.usm", // Grun Fight Finish
	"movie/ev0552.usm", // Copied City Finish
	"movie/ev0694.usm", // Ending B Finish
	// Ending C/D Cutscenes (In Progress)
	"movie/ev0830.usm", // Bunker Finish
	// Ending E Cutscene
	"movie/ev1270.usm"
	};
}

start 
{
	// Thanks Kate for this auto-start logic
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
