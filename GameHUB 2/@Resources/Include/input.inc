[Control]
Measure=Plugin
Plugin=ActionTimer
Group=Animation
DynamicVariables=1
ActionList1=DisableKeyboard
ActionList2=DisableGamepad
DisableKeyboard=[!CommandMeasure UP Stop][!CommandMeasure DOWN Stop][!CommandMeasure LEFT Stop][!CommandMeasure RIGHT Stop][!CommandMeasure ENTER Stop][!CommandMeasure ESCAPE Stop]
DisableGamepad=[!DisableMeasureGroup Gamepad]
EnableKeyboard=[!CommandMeasure UP Start][!CommandMeasure DOWN Start][!CommandMeasure LEFT Start][!CommandMeasure RIGHT Start][!CommandMeasure ENTER Start][!CommandMeasure ESCAPE Start]
EnableGamepad=[!EnableMeasureGroup Gamepad]

[UP]
Measure=Plugin
Plugin=HotKey
HotKey=UP
KeyDownAction=[!CommandMeasure Animation "input('up')"]
Group=Input | Keyboard

[DOWN]
Measure=Plugin
Plugin=HotKey
HotKey=DOWN
KeyDownAction=[!CommandMeasure Animation "input('down')"]
Group=Input | Keyboard

[RIGHT]
Measure=Plugin
Plugin=HotKey
HotKey=RIGHT
KeyDownAction=[!CommandMeasure Animation "input('right')"]
Group=Input | Keyboard

[LEFT]
Measure=Plugin
Plugin=HotKey
HotKey=LEFT
KeyDownAction=[!CommandMeasure Animation "input('left')"]
Group=Input | Keyboard

[ENTER]
Measure=Plugin
Plugin=HotKey
HotKey=ENTER
KeyDownAction=[!CommandMeasure Animation "input('enter')"]
Group=Input | Keyboard

[ESCAPE]
Measure=Plugin
Plugin=HotKey
HotKey=ESCAPE
KeyDownAction=[!CommandMeasure Animation "input('back')"]
Group=Input | Keyboard

[measureXInput_0_Dpad_U]
Measure=Plugin
Plugin=XInput
Device=0
Channel=Dpad_U
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('up')"]
Group=Input | Gamepad

[measureXInput_0_Dpad_D]
Measure=Plugin
Plugin=XInput
Device=0
Channel=Dpad_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('down')"]
Group=Input | Gamepad

[measureXInput_0_Dpad_L]
Measure=Plugin
Plugin=XInput
Device=0
Channel=Dpad_L
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('left')"]
Group=Input | Gamepad

[measureXInput_0_Dpad_R]
Measure=Plugin
Plugin=XInput
Device=0
Channel=Dpad_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('right')"]
Group=Input | Gamepad

[measureXInput_0_Face_D]
Measure=Plugin
Plugin=XInput
Device=0
Channel=Face_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('enter')"]
Group=Input | Gamepad

[measureXInput_0_Face_R]
Measure=Plugin
Plugin=XInput
Device=0
Channel=Face_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('back')"]
Group=Input | Gamepad