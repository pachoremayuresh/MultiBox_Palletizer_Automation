<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="Main_Contr" Source="Main_Control.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="Input_Brid" Source="Input_Bridge.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Output_Bri" Source="Output_Bridge.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Pallet" Source="Pallet.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Crane" Source="Crane.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Feeder" Source="Feeder.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="ComTCP_P" Source="Libraries.ComTCP.ComTCP_P.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4">
    <Task Name="Signal_Man" Source="Signal_Mangement.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="FWRules" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="TCLang" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="ashwac" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="operator" Source="Libraries.operator.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArLog" Source="Libraries.AsArLog.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsTCP" Source="Libraries.AsTCP.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="ComTCP_L" Source="Libraries.ComTCP.ComTCP_L.lby" Memory="None" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="Signal_Mng" Source="Libraries.Signal_Mng.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="Gen_Axis" Source="Libraries.Gen_Axis.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="Gen_Device" Source="Libraries.Gen_Device.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="fileio" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asieccon" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="arssl" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="binary" Debugging="true" />
    <LibraryObject Name="Blink" Source="Libraries.Blink.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="S_filter" Source="Libraries.S_filter.lby" Memory="UserROM" Language="IEC" Debugging="true" />
  </Libraries>
</SwConfiguration>