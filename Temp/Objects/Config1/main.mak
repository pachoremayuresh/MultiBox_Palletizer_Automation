SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Intel\Intel(R) Management Engine Components\DAL;C:\Program Files\Intel\Intel(R) Management Engine Components\DAL;C:\Program Files\Git\cmd;C:\Users\pacho\AppData\Local\Programs\Python\Python312\Scripts\;C:\Users\pacho\AppData\Local\Programs\Python\Python312\;C:\Users\pacho\AppData\Local\Microsoft\WindowsApps;C:\Users\pacho\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\pacho\AppData\Local\GitHubDesktop\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\pacho\AppData\Local\Programs\Python\Python312\Scripts\;C:\Users\pacho\AppData\Local\Programs\Python\Python312\;C:\Users\pacho\AppData\Local\Microsoft\WindowsApps;C:\Users\pacho\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\pacho\AppData\Local\GitHubDesktop\bin;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Program Files\BRAutomation4\AS412\bin-en\4.12;C:\Program Files\BRAutomation4\AS412\bin-en\4.11;C:\Program Files\BRAutomation4\AS412\bin-en\4.10;C:\Program Files\BRAutomation4\AS412\bin-en\4.9;C:\Program Files\BRAutomation4\AS412\bin-en\4.8;C:\Program Files\BRAutomation4\AS412\bin-en\4.7;C:\Program Files\BRAutomation4\AS412\bin-en\4.6;C:\Program Files\BRAutomation4\AS412\bin-en\4.5;C:\Program Files\BRAutomation4\AS412\bin-en\4.4;C:\Program Files\BRAutomation4\AS412\bin-en\4.3;C:\Program Files\BRAutomation4\AS412\bin-en\4.2;C:\Program Files\BRAutomation4\AS412\bin-en\4.1;C:\Program Files\BRAutomation4\AS412\bin-en\4.0;C:\Program Files\BRAutomation4\AS412\bin-en
export AS_BUILD_MODE := BuildAndTransfer
export AS_VERSION := 4.12.6.106
export AS_WORKINGVERSION := 4.12
export AS_COMPANY_NAME :=  
export AS_USER_NAME := pacho
export AS_PATH := C:/Program Files/BRAutomation4/AS412
export AS_BIN_PATH := C:/Program Files/BRAutomation4/AS412/bin-en
export AS_PROJECT_PATH := D:/Pachore_Mayuresh_ASDP/Pachore_Mayuresh_Project_3/Pachore_Mayuresh_Project_3
export AS_PROJECT_NAME := Pachore_Mayuresh_Project_3
export AS_SYSTEM_PATH := C:/Program\ Files/BRAutomation4/AS/System
export AS_VC_PATH := C:/Program\ Files/BRAutomation4/AS412/AS/VC
export AS_TEMP_PATH := D:/Pachore_Mayuresh_ASDP/Pachore_Mayuresh_Project_3/Pachore_Mayuresh_Project_3/Temp
export AS_CONFIGURATION := Config1
export AS_BINARIES_PATH := D:/Pachore_Mayuresh_ASDP/Pachore_Mayuresh_Project_3/Pachore_Mayuresh_Project_3/Binaries
export AS_GNU_INST_PATH := C:/Program\ Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := C:/Program\ Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/Program Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := C:/Program Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_INSTALL_PATH := C:/Program\ Files/BRAutomation4/AS412
export WIN32_AS_PATH := "C:\Program Files\BRAutomation4\AS412"
export WIN32_AS_BIN_PATH := "C:\Program Files\BRAutomation4\AS412\bin-en"
export WIN32_AS_PROJECT_PATH := "D:\Pachore_Mayuresh_ASDP\Pachore_Mayuresh_Project_3\Pachore_Mayuresh_Project_3"
export WIN32_AS_SYSTEM_PATH := "C:\Program Files\BRAutomation4\AS\System"
export WIN32_AS_VC_PATH := "C:\Program Files\BRAutomation4\AS412\AS\VC"
export WIN32_AS_TEMP_PATH := "D:\Pachore_Mayuresh_ASDP\Pachore_Mayuresh_Project_3\Pachore_Mayuresh_Project_3\Temp"
export WIN32_AS_BINARIES_PATH := "D:\Pachore_Mayuresh_ASDP\Pachore_Mayuresh_Project_3\Pachore_Mayuresh_Project_3\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\Program Files\BRAutomation4\AS412\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "C:\Program Files\BRAutomation4\AS412\AS\GnuInst\V4.1.2\bin"
export WIN32_AS_INSTALL_PATH := "C:\Program Files\BRAutomation4\AS412"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/4.9/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/Pachore_Mayuresh_Project_3.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'BuildAndTransfer'   

