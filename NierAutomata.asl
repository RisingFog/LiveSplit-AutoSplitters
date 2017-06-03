state("NieRAutomata", "1.0")
{
	bool isWorldLoaded : 0x18F3978;
	byte playerNameSetStatus : 0x1461B38;
	string32 currentCutscene : 0x196DAE0, 0x18;
	bool isCutscenePlaying : 0x146A1AC;
}

state("NieRAutomata", "1.01")
{
	bool isWorldLoaded : 0x110ADC0;
	byte playerNameSetStatus : 0x147B4BC;
	string32 currentCutscene : 0x19925E0, 0x1F4;
	bool isCutscenePlaying : 0x1483974;
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
	"movie/ev0580.usm", // So-Shi Fight Finish [A/B]
	"movie/ev0655.usm", // Boku-Shi Fight Finish [A/B]
	"movie/ev0693.usm", // Ending A Finish
	// Ending B Cutscenes
	"movie/ev0262.usm", // Adam Desert Fight Finish
	"movie/ev0322.usm", // Beauvoir Fight Finish
	"movie/ev0352.usm", // Negotiations Finish
	"movie/ev0483.usm", // Grun Fight Finish
	"movie/ev0552.usm", // Copied City Finish
	"movie/ev0694.usm", // Ending B Finish
	// Ending C/D Cutscenes
	"movie/ev0830.usm", // Bunker Finish
	"movie/ev0875.usm", // A2 Desert Fight Finish
	"movie/ev0940.usm", // Meat Box Finish
	"movie/ev0970.usm", // Pascal Finish
	"movie/ev1010.usm", // Soul Box Finish
	"movie/ev1060.usm", // God Box Finish
	"movie/ev1125.usm", // 2B Clones Finish
	"movie/ev1190.usm", // Red Girls Finish
	"movie/ev1210.usm", // Ko-Shi & Ro-Shi Finish
	"movie/ev1232.usm", // Ending D Finish Variation 1
	"movie/ev1233.usm", // Ending D Finish Variation 2
	"movie/ev1234.usm", // Ending D Finish Variation 3
	"movie/ev1235.usm", // Ending D Finish Variation 4
	"movie/ev1250.usm", // Ending C Finish
	// Ending E Cutscenes
	"movie/ev1270.usm" // Ending E Finish
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
