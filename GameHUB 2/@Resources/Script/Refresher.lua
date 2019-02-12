-- @author Malody Hoe / GitHub: madhoe / Twitter: maddhoexD
-- Add this after all incs!
function Initialize()
	first_action = SKIN:GetVariable("WhenRefreshAction","")
	second_action = SKIN:GetVariable("WhenRefreshedAction","")

	if SELF:GetOption("Refreshed", "0") == "0" then
		if first_action ~= "" then SKIN:Bang(first_action) end
		SKIN:Bang("!WriteKeyValue", SELF:GetName(), "Refreshed", "1")
		SKIN:Bang("!Refresh")
	else
		if SKIN:GetVariable('SoundStart')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundStart')) end
		if second_action ~= "" then SKIN:Bang(second_action) end
		SKIN:Bang("!WriteKeyValue", SELF:GetName(), "Refreshed", "0")
	end
end