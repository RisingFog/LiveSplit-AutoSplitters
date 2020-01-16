state("deadspace2")
{
	bool isLoading : "deadspace2.exe", 0x1C20460, 0x10;
}

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	switch (moduleSize) {
		case 69615616:
			version = "1.0 FLT";
			break;
		case 63586304:
			version = "1.0 Retail" //un-tested
			break;
	}
	print("ModuleMemorySize: " + modules.First().ModuleMemorySize.ToString());
}

isLoading
{
	return current.isLoading;
}
