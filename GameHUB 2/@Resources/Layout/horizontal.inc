[Rainmeter]
OnRefreshAction=[!ClickThrough #Clickthrough#][!KeepOnScreen 0][!Draggable 0][!ZPos 2][!CommandMeasure ScriptRepeatIcon "read(#LoadMeter#)"][!CommandMeasure ScriptRepeatIcon "write('meter.inc')"][!CommandMeasure Animation "get_meter()"]
Update=#Update#
SkinWidth=(#DisplayWidth#*#SkinWidth#)
SkinHeight=((#BannerHeight#+#RowSpace#)*#Rows#)
Group=G2Animate | GameHUB2

[Variables]
broadcast=-1
broadcast_data=
broadcast_id=

[ScriptRepeatIcon]
Measure=Script
ScriptFile=#@#Script\RepeatSection.lua
Sub=Repeat
Index=1
Limit=(#Total#)

[Animation]
Measure=Script
ScriptFile=#@#Script\horizontal.lua
OnUpdateAction=[!CommandMeasure Animation update()]
DynamicVariables=1

[Broadcast]
Measure=Script
ScriptFile=#@#Script\Broadcast.lua
DynamicVariables=1
IfCondition=(#broadcast# > 0)
IfTrueAction=[!CommandMeasure Broadcast update()][!SetVariable broadcast "-1"]
IfConditionMode=1

[MeterBackground]
Meter=Shape
X=0
Y=0
W=#CURRENTCONFIGWIDTH#
H=#CURRENTCONFIGHEIGHT#
Shape=Rectangle 0 , 0 , (#CURRENTCONFIGWIDTH#) , (#CURRENTCONFIGHEIGHT#), 3 | Fill Color 0,0,0,1 | StrokeWidth 0
MouseScrollUpAction=[!CommandMeasure "Animation" "scroll(-#ScrollSpeed#)"]
MouseScrollDownAction=[!CommandMeasure "Animation" "scroll(#ScrollSpeed#)"]
UpdateDivider=-1
Hidden=0

[Surface]
meter=Image
X=0
Y=0
W=#CURRENTCONFIGWIDTH#
H=#CURRENTCONFIGHEIGHT#
DynamicVariables=1
UpdateDivider=-1

[Title]
Meter=String
FontSize=#FontSize#
FontColor=#FontColor#
FontFace=#Font#
Y=#CURRENTCONFIGHEIGHT#
W=#BannerWidth#
H=#BannerHeight#
AntiAlias=1
StringAlign=#StringAlign#
ClipString=2
TransformationMatrix=1; 0; 0; 1; #TitleX#; #TitleY#
Group=Title
DynamicVariables=1
Hidden=1

[Cover]
Meter=Image 
Y=#CURRENTCONFIGHEIGHT#
W=#BannerWidth#
H=#BannerHeight#
SolidColor=0,0,0,1
Group=Cover
PreserveAspectRatio=#CoverAspectRatio#
Hidden=1

[Background]
Meter=Image 
Y=#CURRENTCONFIGHEIGHT#
W=#BannerWidth#
H=#BannerHeight#
SolidColor=0,0,0,1
Group=Cover
PreserveAspectRatio=#CoverAspectRatio#
Hidden=1

[Icon]
Y=#CURRENTCONFIGHEIGHT#
W=(#BannerWidth#*#IconScale#)
H=(#BannerHeight#*#IconScale#)
SolidColor=#IconSolid#
ImageTint=#IconTint#
PreserveAspectRatio=1
Group=Icon
Padding=(#BannerWidth#*(1-#IconScale#)/2),(#BannerHeight#*(1-#IconScale#)/2),(1+#BannerWidth#*(1-#IconScale#)/2),(2+#BannerHeight#*(1-#IconScale#)/2)
Hidden=1

[SpectrumCover]
meter=Image
Y=#CURRENTCONFIGHEIGHT#
W=#BannerWidth#
H=#BannerHeight#
SolidColor=0,0,0,1
PreserveAspectRatio=#CoverAspectRatio#
Group=Cover
Hidden=1
DynamicVariables=1
Hidden=1

@Include=#CURRENTPATH#\meter.inc
@Include2=#@#Include\input.inc

[HighlightCover]
meter=Image
ImageName=#@#Highlight.png
Y=#CURRENTCONFIGHEIGHT#
W=#BannerWidth#
H=#BannerHeight#
SolidColor=0,0,0,1
PreserveAspectRatio=0
Group=Cover
Hidden=1
DynamicVariables=1