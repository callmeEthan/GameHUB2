function Initialize()
	Total=tonumber(SKIN:GetVariable('Total','0'))
	local page=''
	page_entry = {}
	for i=1,Total do
		page=SKIN:GetVariable('Dir'..i)
		SKIN:Bang('!SetVariable','Dir'..i,'[!WriteKeyValue "Variables" filelayout "'..page..'" "#*@*#Settings.inc"][!ActivateConfig "#ROOTCONFIG#" GameHUB.ini]')
		page_entry[page] = i
	end
	current_entry = page_entry[SKIN:GetVariable('filelayout')]
	if current_entry == nil then current_entry = 0 end
	SKIN:Bang('!SetOption','Icon'..current_entry, 'ImageTint', SKIN:GetVariable('HighlightTint'))
	SKIN:Bang('!SetOption','Icon'..current_entry, 'SolidColor', SKIN:GetVariable('HighlightColor'))
	SKIN:Bang('[!Delay 1000][!CommandMeasure "Animation" "highlight('..current_entry..')"')
end

function input(key)
	if key=='next' then
		if SKIN:GetVariable('SoundClick')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundClick')) end
		current_entry = current_entry + 1
		if current_entry > Total then current_entry = 1 end
		local action=SKIN:GetVariable('Dir'..current_entry)
		SKIN:Bang(action)
	elseif key=='previous' then
		if SKIN:GetVariable('SoundClick')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundClick')) end
		current_entry = current_entry - 1
		if current_entry < 1 then current_entry = Total end
		local action=SKIN:GetVariable('Dir'..current_entry)
		SKIN:Bang(action)
	end
end