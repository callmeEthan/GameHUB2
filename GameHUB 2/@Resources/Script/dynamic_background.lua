function Initialize()
	SKIN:Bang('!WriteKeyValue','Variables', split_string(SKIN:GetVariable('CURRENTCONFIG'),'\\')[2], SKIN:GetVariable('CURRENTFILE'),'#@#Active.inc')
	variant=SKIN:GetVariable('CURRENTFILE')
	dynamic_background=tonumber(SKIN:GetVariable('DynamicBackground','0'))
	if variant=='Display.ini' then variant='Display2.ini' else variant='Display.ini' end
end

function broadcast_highlight(index)
	if dynamic_background==0 then return end
	SKIN:Bang('!CommandMeasure', 'ActionTimer', 'Stop 1')
	local background=SKIN:GetVariable('Background'..index)
	local name=SKIN:GetVariable('Name'..index)
	if SKIN:GetVariable('Background'..index)~=SKIN:GetVariable('Background') or SKIN:GetVariable('Name'..index)~=SKIN:GetVariable('Name') then
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Layout', 'background.inc', 'config.inc')
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