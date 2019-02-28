[Variables]
Total=5
LastOpen=17
AutoRefresh=0

[MeasureFolder]
Measure=Plugin
Plugin=FileView
Path="#Path#"
Recursive=2
ShowDotDot=0
ShowFolder=0
Extensions="mkv;mp4;avi;flv;wmv;mov"
Count=1
UpdateDivider=-1
FinishAction=[!UpdateMeasure MeasureFile][!UpdateMeasure FileCount][!CommandMeasure "FileHandling" "get_file()"][!CommandMeasure ScriptRepeatIcon "read(#LoadMeter#)"][!CommandMeasure ScriptRepeatIcon "write('meter.inc')"][!CommandMeasure ScriptRefresher "refresh()"][!CommandMeasure Animation "get_meter()"]

[MeasureFile]
Measure=Plugin
Plugin=FileView
Path=[MeasureFolder]
Type=FilePath
Index=#Index#
IgnoreCount=1
DynamicVariables=1

[FileCount]
Measure=Plugin
Plugin=FileView
Path=[MeasureFolder]
Type=FileCount

[FileHandling]
Measure=Script
ScriptFile=#@#Script\Video_thumbnail.lua

[ThumbnailLoop]
Measure=Plugin
Plugin=ActionTimer
ActionList1=Wait 50 | Load
ActionList2=Wait 500 | LoadThumbnail
Load=[!CommandMeasure FileHandling "load()"]
LoadThumbnail=[!CommandMeasure FileHandling "load_thumbnail()"]
