[Control]
Measure=Plugin
Plugin=ActionTimer
Group=Animation
DynamicVariables=1
ActionList1=DisableKeyboard
ActionList2=DisableGamepad
ActionList3=EnableKeyboard
ActionList4=EnableGamepad
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

;/////////////////////// CONTROLLER 1 ///////////////////////

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

[measureXInput_0_JoyL_X]
Measure=Plugin
Plugin=XInput
Device=0
Channel=JoyL_X
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('left')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('right')"]
IfConditionMode=1
Group=Input | Gamepad

[measureXInput_0_JoyL_Y]
Measure=Plugin
Plugin=XInput
Device=0
Channel=JoyL_Y
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('down')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('up')"]
IfConditionMode=1
Group=Input | Gamepad

;/////////////////////// CONTROLLER 2 ///////////////////////

[measureXInput_1_Dpad_U]
Measure=Plugin
Plugin=XInput
Device=1
Channel=Dpad_U
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('up')"]
Group=Input | Gamepad

[measureXInput_1_Dpad_D]
Measure=Plugin
Plugin=XInput
Device=1
Channel=Dpad_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('down')"]
Group=Input | Gamepad

[measureXInput_1_Dpad_L]
Measure=Plugin
Plugin=XInput
Device=1
Channel=Dpad_L
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('left')"]
Group=Input | Gamepad

[measureXInput_1_Dpad_R]
Measure=Plugin
Plugin=XInput
Device=1
Channel=Dpad_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('right')"]
Group=Input | Gamepad

[measureXInput_1_Face_D]
Measure=Plugin
Plugin=XInput
Device=1
Channel=Face_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('enter')"]
Group=Input | Gamepad

[measureXInput_1_Face_R]
Measure=Plugin
Plugin=XInput
Device=1
Channel=Face_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('back')"]
Group=Input | Gamepad

[measureXInput_1_JoyL_X]
Measure=Plugin
Plugin=XInput
Device=1
Channel=JoyL_X
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('left')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('right')"]
IfConditionMode=1
Group=Input | Gamepad

[measureXInput_1_JoyL_Y]
Measure=Plugin
Plugin=XInput
Device=1
Channel=JoyL_Y
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('down')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('up')"]
IfConditionMode=1
Group=Input | Gamepad

;/////////////////////// CONTROLLER 3 ///////////////////////

[measureXInput_2_Dpad_U]
Measure=Plugin
Plugin=XInput
Device=2
Channel=Dpad_U
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('up')"]
Group=Input | Gamepad

[measureXInput_2_Dpad_D]
Measure=Plugin
Plugin=XInput
Device=2
Channel=Dpad_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('down')"]
Group=Input | Gamepad

[measureXInput_2_Dpad_L]
Measure=Plugin
Plugin=XInput
Device=2
Channel=Dpad_L
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('left')"]
Group=Input | Gamepad

[measureXInput_2_Dpad_R]
Measure=Plugin
Plugin=XInput
Device=2
Channel=Dpad_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('right')"]
Group=Input | Gamepad

[measureXInput_2_Face_D]
Measure=Plugin
Plugin=XInput
Device=2
Channel=Face_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('enter')"]
Group=Input | Gamepad

[measureXInput_2_Face_R]
Measure=Plugin
Plugin=XInput
Device=2
Channel=Face_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('back')"]
Group=Input | Gamepad

[measureXInput_2_JoyL_X]
Measure=Plugin
Plugin=XInput
Device=2
Channel=JoyL_X
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('left')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('right')"]
IfConditionMode=1
Group=Input | Gamepad

[measureXInput_2_JoyL_Y]
Measure=Plugin
Plugin=XInput
Device=2
Channel=JoyL_Y
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('down')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('up')"]
IfConditionMode=1
Group=Input | Gamepad


;/////////////////////// CONTROLLER 4 ///////////////////////

[measureXInput_3_Dpad_U]
Measure=Plugin
Plugin=XInput
Device=3
Channel=Dpad_U
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('up')"]
Group=Input | Gamepad

[measureXInput_3_Dpad_D]
Measure=Plugin
Plugin=XInput
Device=3
Channel=Dpad_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('down')"]
Group=Input | Gamepad

[measureXInput_3_Dpad_L]
Measure=Plugin
Plugin=XInput
Device=3
Channel=Dpad_L
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('left')"]
Group=Input | Gamepad

[measureXInput_3_Dpad_R]
Measure=Plugin
Plugin=XInput
Device=3
Channel=Dpad_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('right')"]
Group=Input | Gamepad

[measureXInput_3_Face_D]
Measure=Plugin
Plugin=XInput
Device=3
Channel=Face_D
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('enter')"]
Group=Input | Gamepad

[measureXInput_3_Face_R]
Measure=Plugin
Plugin=XInput
Device=3
Channel=Face_R
IfEqualValue=1
IfEqualAction=[!CommandMeasure Animation "input('back')"]
Group=Input | Gamepad

[measureXInput_3_JoyL_X]
Measure=Plugin
Plugin=XInput
Device=3
Channel=JoyL_X
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('left')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('right')"]
IfConditionMode=1
Group=Input | Gamepad

[measureXInput_3_JoyL_Y]
Measure=Plugin
Plugin=XInput
Device=3
Channel=JoyL_Y
IfBelowValue=-0.8
IfBelowAction=[!CommandMeasure Animation "input('down')"]
IfAboveValue=0.8
IfAboveAction=[!CommandMeasure Animation "input('up')"]
IfConditionMode=1
Group=Input | Gamepad