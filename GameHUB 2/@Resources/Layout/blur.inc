[Rainmeter]
Update=-1
OnRefreshAction=[!ClickThrough #Clickthrough#][!ZPos 1][!KeepOnScreen 0][!Draggable 0][!CommandMeasure Animation "move()"]
SkinWidth=(#DisplayWidth#*#SkinWidth#)
SkinHeight=(#DisplayHeight#*#SkinHeight#)
Group=G2Animate | GameHUB2


[Variables]
broadcast=-1
broadcast_data=
broadcast_id=
SolidColor=0,0,0,1
ImageTint=200,200,200

[Animation]
Measure=Script
ScriptFile=#@#Script\dynamic_background.lua
DynamicVariables=1
UpdateDivider=-1

[Broadcast]
Measure=Script
ScriptFile=#@#Script\Broadcast.lua
DynamicVariables=1
IfCondition=(#broadcast# > 0)
IfTrueAction=[!CommandMeasure Broadcast update()][!SetVariable broadcast "-1"]
IfConditionMode=1

[Background]
Meter=Image
ImageName=Gradient.png
X=0
Y=0
W=#DisplayWidth#
H=#DisplayHeight#
SolidColor=#SolidColor#
ImageTint=#ImageTint#
PreserveAspectRatio=0
DynamicVariables=1
UpdateDivider=-1

[Title]
Meter=String
FontSize=#FontSize#
FontColor=#FontColor#
FontFace=#Font#
AntiAlias=1
StringAlign=#StringAlign#
TransformationMatrix=1; 0; 0; 1; #TitleX#; #TitleY#
Text=#Name#
DynamicVariables=1
Hidden=(#Title#=0 ? 1 : 0)
UpdateDivider=-1

[FrostedGlass]
Measure=Plugin
Plugin=FrostedGlass
Type=Blur
Border=None
UpdateDivider=-1

[ActionTimer]
Measure=Plugin
Plugin=ActionTimer
ActionList1=Wait #Delay# | Swap
Swap=[!ActivateConfig "#CURRENTCONFIG#" "#Config#"]
DynamicVariables=1
UpdateDivider=-1