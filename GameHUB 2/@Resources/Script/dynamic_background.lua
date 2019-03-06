function Initialize()
	SKIN:Bang('!WriteKeyValue','Variables', split_string(SKIN:GetVariable('CURRENTCONFIG'),'\\')[2], SKIN:GetVariable('CURRENTFILE'),'#@#Active.inc')
	variant=SKIN:GetVariable('CURRENTFILE')
	dynamic_background=tonumber(SKIN:GetVariable('DynamicBackground','0'))
	dynamic_title=tonumber(SKIN:GetVariable('DynamicTitle','0'))
	layout=SKIN:GetVariable('LayoutOverride','background.inc')
	if SKIN:GetVariable('Name','nil')=='nil' then SKIN:Bang('!HideMeter','Title') end
	if variant=='Display.ini' then variant='Display2.ini' else variant='Display.ini' end
	default_color=SKIN:GetVariable('FontColor','255,255,255')
	default_InlineSetting=SKIN:GetVariable('InlineSetting')
	default_StringStyle=SKIN:GetVariable('StringStyle')
end

function broadcast_highlight(index)
	local font_color=SKIN:GetVariable('Color'..index,'null')
	local InlineSetting=SKIN:GetVariable('InlineSetting'..index,'null')
	local StringStyle=SKIN:GetVariable('StringStyle'..index,'null')
	if dynamic_title==1 then 
		local name=SKIN:GetVariable('Name'..index)
		SKIN:Bang('!ShowMeter','Title')
		SKIN:Bang('!SetVariable','Name',name)
		if font_color ~= 'null' then SKIN:Bang('!SetVariable','FontColor',font_color) else SKIN:Bang('!SetVariable','FontColor', default_color) end
		if InlineSetting ~= 'null' then SKIN:Bang('!SetVariable','InlineSetting',InlineSetting) else SKIN:Bang('!SetVariable','InlineSetting', default_InlineSetting) end
		if StringStyle ~= 'null' then SKIN:Bang('!SetVariable','StringStyle',StringStyle) else SKIN:Bang('!SetVariable','StringStyle', default_StringStyle) end
		SKIN:Bang('!UpdateMeter','Title')
	end
	if dynamic_background==0 then return end
	SKIN:Bang('!CommandMeasure', 'ActionTimer', 'Stop 1')
	local background=SKIN:GetVariable('Background'..index)
	local name=SKIN:GetVariable('Name'..index)
	if SKIN:GetVariable('Background'..index)~=SKIN:GetVariable('Background') or SKIN:GetVariable('Name'..index)~=SKIN:GetVariable('Name') then
		if font_color ~= 'null' then SKIN:Bang('!WriteKeyValue', 'Variables','FontColor',font_color, 'config.inc') end
		if InlineSetting ~= 'null' then SKIN:Bang('!WriteKeyValue', 'Variables','InlineSetting', InlineSetting, 'config.inc') end
		if StringStyle ~= 'null' then SKIN:Bang('!WriteKeyValue', 'Variables','StringStyle', StringStyle, 'config.inc') end
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Layout', layout, 'config.inc')
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Background', background, 'config.inc')
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Name', name, 'config.inc')
		swap()
	end
end

function move()
	local displayx=tonumber(SKIN:GetVariable('DisplayX'))
	local displayy=tonumber(SKIN:GetVariable('DisplayY'))
	local skinx=tonumber(SKIN:GetVariable('SkinX'))
	local skiny=tonumber(SKIN:GetVariable('SkinY'))
	local displaywidth=tonumber(SKIN:GetVariable('DisplayWidth'))
	local displayheight=tonumber(SKIN:GetVariable('DisplayHeight'))
	SKIN:Bang('!Move',(skinx * displaywidth) + displayx,(skiny * displayheight)+displayy)
end

function swap()
	SKIN:Bang('!SetVariable', 'Config', variant)
	SKIN:Bang('!UpdateMeasure', 'ActionTimer')
	SKIN:Bang('!CommandMeasure', 'ActionTimer', 'Execute 1')
end

function split_string(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end
