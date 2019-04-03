// 2013 - By Dread
state("TombRaider"){
    bool FMV             : "binkw32.dll", 0x2830C;
    int  ingameCutscene  : 0x211AB5C;
    bool isLoading       : 0x1E33250;
}

// Rise - By Leemyy / Atorizil + Dread & Aphox
state("ROTTR", "Rise: 820.0"){
	bool LegacyFMV : 0xF85AB0;
	int Cutscene : 0x1A0D094;
	bool FMV : 0x22C345C;
	bool Loading : 0x2D129A8, 0x4C;
	float Percentage : 0xF866C8;
	string50 Area : 0x2CDE661;
}

state("ROTTR", "Rise: 813.4"){
	bool LegacyLoading	: 0xF25FB8;
	bool LegacyFMV		: 0xF9A990;
	int  Cutscene		: 0x1A22014;
	bool FMV			: 0x22D83D8;
	bool Loading		: 0x2CCD940, 0xC8;
	float Percentage	: 0x1A21EE8, 0xC38;
	string50 Area : 0x2CF35F1;
}

// Shadow - By Atorizil
state("SOTTR", "Shadow: 286.0"){
  bool Loading : 0x3587640;
  bool Loading2 : 0x3587640;
  bool Cutscene : 0x1491BD8;
}
state("SOTTR", "Shadow: 280.0"){
  bool Loading : 0x358D8C0;
  bool Loading2 : 0x358D8C0;
  bool Cutscene : 0x1497BD8;
}
state("SOTTR", "Shadow: 279.0"){
  bool Loading : 0x3586540;
  bool Loading2 : 0x3586540;
  bool Cutscene : 0x1490A58;
}
state("SOTTR", "Shadow: 270.0"){
  bool Loading : 0x357D2C0;
  bool Loading2 : 0x357D2C0;
  bool Cutscene : 0x1487A58;
}
state("SOTTR", "Shadow: 260.0"){
  bool Loading : 0x1448910;
  bool Loading2 : 0x147C490;
  bool Cutscene : 0x1483A70;
}

state("SOTTR", "Shadow: 247.0"){
  bool Loading : 0x142F8A0;
  bool Loading2 : 0x146D830;
  bool Cutscene : 0x146A930;
}

state("SOTTR", "Shadow: 243.0"){
  bool Loading : 0x14298A0;
  bool Loading2 : 0x145D370;
  bool Cutscene : 0x1464930;
}

state("SOTTR", "Shadow: 241.0"){
  bool Loading : 0x14238A0;
  bool Loading2 : 0x1457370;
  bool Cutscene : 0x145E930;
}

state("SOTTR", "Shadow: 236.1"){
  bool Loading : 0x13E18E0;
  bool Loading2 : 0x14153D0;
  bool Cutscene : 0x141C9F0;
}

state("SOTTR", "Shadow: 235.3"){
  bool Loading : 0x13E18E0;
  bool Loading2 : 0x14153D0;
  bool Cutscene : 0x141C9F0;
}

state("SOTTR", "Shadow: 230.9"){
  bool Loading : 0x13DE7E0;
  bool Loading2 : 0x14122D0;
  bool Cutscene : 0x14198F0;
}

state("SOTTR", "Shadow: 234.1"){
	bool Loading : 0x13E07E0;
	bool Loading2 : 0x14142D0;
	bool Cutscene : 0x141B8F0;
}

init{
  timer.IsGameTimePaused = false;

  // Version Detection
  switch(game.ProcessName){
    case "ROTTR":
      switch(modules.First().ModuleMemorySize){
        case 296157184:
          version = "Rise: 820.0";
          break;
        case 137060352:
          version = "Rise: 813.4";
          break;
        }
      break;
    case "SOTTR":
      switch(modules.First().ModuleMemorySize){
        case 306704384:
          version = "Shadow: 286.0";
          break;
         case 312975360:
          version = "Shadow: 280.0";
          break;
        case 311033856:
          version = "Shadow: 279.0";
          break;
        case 308297728:
          version = "Shadow: 270.0";  
          break;
        case 313040896:
          version = "Shadow: 260.0";
          break;
        case 312098816:
          version = "Shadow: 247.0";
          break;
        case 314839040:
          version = "Shadow: 243.0";
          break;
        case 317931520:
          version = "Shadow: 241.0";
          break;
        case 316497920:
          version = "Shadow: 236.1";
          break;
        case 314748928:
          version = "Shadow: 235.3";
          break;
    		case 310804480:
    			version = "Shadow: 234.1";
    			break;
        case 311508992:
          version = "Shadow: 230.9";
          break;
    	}
      break;
  }
}

isLoading{
  switch(game.ProcessName){
    case "TombRaider":
      return current.ingameCutscene == 520 || current.isLoading || current.FMV;
      break;
    case "ROTTR":
      return current.Cutscene != 0 || current.FMV || current.Loading || current.Percentage < .1f;
      if(current.Area != "st_cistern")
        return current.LegacyFMV;
      if(version == "813.4")
        return current.LegacyLoading;
      break;
    case "SOTTR":
      return current.Loading || current.Cutscene || current.Loading2;
      break;
  }
}

exit{
    timer.IsGameTimePaused = true;
}
