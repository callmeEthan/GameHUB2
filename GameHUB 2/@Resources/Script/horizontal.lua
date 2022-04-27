function Initialize()
	SKIN:Bang('!WriteKeyValue','Variables', split_string(SKIN:GetVariable('CURRENTCONFIG'),'\\')[2], SKIN:GetVariable('CURRENTFILE'),'#@#Active.inc')
	total=0
	rows=tonumber(SKIN:GetVariable('Rows'))
	space=tonumber(SKIN:GetVariable('Space'))
	rowspace=tonumber(SKIN:GetVariable('RowSpace'))
	bannerwidth=tonumber(SKIN:GetVariable('BannerWidth'))
	bannerheight=tonumber(SKIN:GetVariable('BannerHeight'))
	skinwidth=tonumber(SKIN:GetVariable('CURRENTCONFIGWIDTH','100'))
	skinheight=tonumber(SKIN:GetVariable('CURRENTCONFIGHEIGHT','100'))
	divider=tonumber(SKIN:GetVariable('ScrollDivider'))
	transition=tonumber(SKIN:GetVariable('Transition'))
	SpectrumIcon=tonumber(SKIN:GetVariable('SpectrumIcon',1))
	highlight_solid=SKIN:GetVariable('HighlightColor','0,0,0,1')
	highlight_tint=SKIN:GetVariable('HighlightTint','255,255,255')
	move_x=tonumber(SKIN:GetVariable('Offset_x',0))
	move_y=tonumber(SKIN:GetVariable('Offset_y',0))
	highlight_index = 0
	spectrum = 0
	x,y = {}, {}
	meter_list = {}
	background_meter = nil
	scroll_limit=0
	offset=0
	offset_true=0
	offsety=skinheight
	shift_x=tonumber(SKIN:GetVariable('SkinX','0'))*skinwidth
	shift_y=tonumber(SKIN:GetVariable('SkinY','0'))*skinheight
	image_shift=tonumber(SKIN:GetVariable('ImageShift','0.9'))
	image_scale=tonumber(SKIN:GetVariable('ImageScale','1'))
	upscale=image_scale/tonumber(SKIN:GetVariable('SkinWidth','1'))
	move()
	if SKIN:GetVariable('Keyboard','0')=='0' then SKIN:Bang('!CommandMeasure','Control','Execute 1') end
	if SKIN:GetVariable('Gamepad','0')=='0' then SKIN:Bang('!CommandMeasure','Control','Execute 2') end
	if SKIN:GetVariable('ScrollLock','0')=='0' then scroll_lock=0 else scroll_lock=1 end
	static_background=tonumber(SKIN:GetVariable('StaticBackground','0'))
	if SKIN:GetVariable('InvertScroll')=='1' then scroll_multiplier=-1 else scroll_multiplier=1 end
end	


function get_meter()
	total=tonumber(SKIN:GetVariable('Total','0'))
	local xx,yy,entry=0,0,0
	for i=1, total do
		x[entry+1]=xx
		y[entry+1]=yy
		entry = entry + 1
		if entry % rows == 0 then
			xx = xx + bannerwidth + space
			yy = 0
		else
			yy = yy + bannerheight + rowspace
		end			
	end
	scroll_limit=math.ceil(total/rows)
	scroll_limit=(scroll_limit * (bannerwidth + space)) - skinwidth - space
	scroll_limit=math.max(scroll_limit,0)

	local meter_entry=1
	if SKIN:GetVariable('cover_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Cover'..entry)
			entry = entry+1
		end
		meter_entry = meter_entry + 1
		end
	if SKIN:GetVariable('title_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Title'..entry)
			entry = entry+1
		end
		meter_entry = meter_entry + 1
		end
	if SKIN:GetVariable('icon_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Icon'..entry)
			entry = entry+1
		end
		meter_entry = meter_entry + 1
		end
	if SKIN:GetVariable('spectrum_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Icon'..entry)
			entry = entry+1
		end
		meter_entry = meter_entry + 1
		spectrum = 1
		end
	if SKIN:GetVariable('background_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		background_meter = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Background'..entry)
			entry = entry+1
		end
		meter_entry = meter_entry + 1
		background_index = 1
		background_load_delay()	
	end
	
	if SKIN:GetVariable('Title','1') == '0' then SKIN:Bang('!HideMeterGroup','Title') end
	if spectrum == 1 then spectrum_meter=SKIN:GetMeter('SpectrumCover') else spectrum_meter=SKIN:GetMeter('HighlightCover') end
	local last_open=tonumber(SKIN:GetVariable('LastOpen','0'))
	if last_open ~= 0 then
		focus_now(last_open,0.1)
		highlight_index=last_open
		SKIN:Bang('!SetOption','Icon'..highlight_index, 'SolidColor', highlight_solid)
		SKIN:Bang('!SetOption','Icon'..highlight_index, 'ImageTint' , highlight_tint)
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

function update()
	offset_true = (offset_true-((offset_true-offset)/divider))
	offsety = (offsety-((offsety-0)/transition))
	for k,v in pairs(meter_list) do
		for mk,mv in pairs(v) do
		v[mk]:SetX(x[mk]+offset_true+move_x)
		v[mk]:SetY(y[mk]+offsety+move_y)
		end
	end
	if highlight_index ~=0 then
		spectrum_meter:SetX(x[highlight_index]+offset_true)
		spectrum_meter:SetY(y[highlight_index])
	end
	if static_background == 1 then static_background_set() end
end


function background_load_delay()
	SKIN:Bang('!SetOption','Background'..background_index,'ImageName','#@#Background\\#Background' .. background_index ..'#')
	if background_index < total then
		SKIN:Bang('!CommandMeasure','BackgroundLoadDelay','Execute 1')
		background_index = background_index + 1
	end
end

function static_background_set()
	if background_meter == nil then return end
	local meter_x,meter_y,meter_w,meter_h
	local crop_x,crop_y,crop_w,crop_h
	for i,v in pairs(background_meter) do
		meter_x=v:GetX()
		meter_y=v:GetY()
		meter_h=v:GetH()
		meter_w=v:GetW()
		crop_x=meter_x*upscale*image_shift+shift_x
		crop_y=meter_y*upscale*image_shift+shift_y
		crop_w=meter_w*upscale
		crop_h=meter_h*upscale
		SKIN:Bang('!SetOption','Background'..i,'ImageCrop',crop_x..','..crop_y..','..crop_w..','..crop_h)
	end
end

function scroll(speed)
	if scroll_lock==1 then return end
	offset = offset - (speed * skinwidth) * scroll_multiplier
	if offset>0 then offset = 0 end
	if offset<-scroll_limit then offset = -scroll_limit end
end

function highlight(index)
	index=tonumber(index)
	SKIN:Bang('!CommandMeasure','Broadcast','broadcast_cmd(\'broadcast_highlight('..index..')\')')
	spectrum_meter:Show()
	if spectrum == 1 then
		SKIN:Bang('!SetOption','SpectrumCover', 'ImageName', '#@#\\Cover\\'..SKIN:GetVariable('Cover'..index))
		end
	spectrum_meter:SetX(x[index]+offset_true)
	spectrum_meter:SetY(y[index]+offsety)
	focus(index,0)
	if SpectrumIcon==0 then SKIN:Bang('!SetOption','Icon'..index,'ImageAlpha',0) end
	if highlight_index ~= index then
		SKIN:Bang('!SetOption','Icon'..highlight_index, 'SolidColor',  SKIN:GetVariable('IconSolid','0,0,0,1'))
		SKIN:Bang('!SetOption','Icon'..highlight_index, 'ImageTint',  SKIN:GetVariable('IconTint','255,255,255'))
		end
	SKIN:Bang('!SetOption','Icon'..index, 'SolidColor', highlight_solid)
	SKIN:Bang('!SetOption','Icon'..index, 'ImageTint' , highlight_tint)
	highlight_index = tonumber(index)
	if SKIN:GetVariable('Sound'..index)~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('Sound'..index))
	elseif SKIN:GetVariable('SoundHover')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundHover')) end
end

function highlight_next()
	if highlight_index<total then
		local index=highlight_index + 1
		highlight(index)
	end
end

function highlight_previous()
	if highlight_index>1 then
		local index=highlight_index - 1
		highlight(index)
	end
end

function broadcast_highlight(index)
	index=tonumber(index)
	spectrum_meter:Show()
	if spectrum == 1 then
		SKIN:Bang('!SetOption','SpectrumCover', 'ImageName', '#@#\\Cover\\'..SKIN:GetVariable('Cover'..index))
		end
	spectrum_meter:SetX(x[index]+offset_true)
	spectrum_meter:SetY(y[index]+offsety)
	focus(index,0)
	if SpectrumIcon==0 then SKIN:Bang('!SetOption','Icon'..index,'ImageAlpha',0) end
	if highlight_index ~= index then
		SKIN:Bang('!SetOption','Icon'..highlight_index, 'SolidColor',  SKIN:GetVariable('IconSolid','0,0,0,1'))
		SKIN:Bang('!SetOption','Icon'..highlight_index, 'ImageTint',  SKIN:GetVariable('IconTint','255,255,255'))
		end
	SKIN:Bang('!SetOption','Icon'..index, 'SolidColor', highlight_solid)
	SKIN:Bang('!SetOption','Icon'..index, 'ImageTint' , highlight_tint)
	highlight_index = tonumber(index)
end

function dehighlight(index)
	local index=tonumber(index)
	spectrum_meter:Hide()
	SKIN:Bang('!SetOption','Icon'..index, 'SolidColor',  SKIN:GetVariable('IconSolid','0,0,0,1'))
	SKIN:Bang('!SetOption','Icon'..index, 'ImageTint',  SKIN:GetVariable('IconTint','255,255,255'))
	if SpectrumIcon==0 then SKIN:Bang('!SetOption','Icon'..highlight_index,'ImageAlpha',255) end
end

function interact(index)
	local command=SKIN:GetVariable('Dir'..index)
	if string.sub(command,1,7)=="layout:" then 
		SKIN:Bang("!WriteKeyValue", "Variables", "filelayout", string.sub(command,8), "#SKINSPATH#\\GameHub 2\\@Resources\\Settings.inc")
		SKIN:Bang("!ActivateConfig", "GameHub 2", "GameHUB.ini")
		return
		end
	SKIN:Bang('!ClickThrough', 1)
	if SKIN:GetVariable('SoundClick')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundClick')) end
	SKIN:Bang('!WriteKeyValue','Variables','LastOpen',index,'#@#User\\'..SKIN:GetVariable('List'))
	if string.sub(command,1,1) == '[' then
		SKIN:Bang(command)
	elseif string.match(command, '"') then
		SKIN:Bang('"'..command..'"')
	else
		SKIN:Bang('"'..command..'"')
	end
	local launch_action=SKIN:GetVariable('LaunchAction')
	if launch_action ~= nil then SKIN:Bang(launch_action) end
	if split_string(SKIN:GetVariable('CURRENTCONFIG'),'\\')[2]  == 'Controller' then return end
	exit(true)
end

function focus(index,scaling)
	if scroll_lock==1 then return end
	local center=skinwidth*scaling
	local index=tonumber(index)
	offset=math.min(offset,-(x[index]-(skinwidth-center-bannerwidth)))
	offset=math.max(offset,-(x[index]-center))
	scroll(0)
end

function focus_now(index,scaling)
	if scroll_lock==1 then return end
	local center=skinwidth*scaling
	local index=tonumber(index)
	offset=math.min(offset,-(x[index]-(skinwidth-center-bannerwidth)))
	offset=math.max(offset,-(x[index]-center))
	offset_true=offset
	scroll(0.15)
end

function input(key)
	if key == 'back' then exit() return end
	SKIN:Bang('!ClickThrough',1)
	if highlight_index==0 then
		highlight_index=1
		highlight(highlight_index)
		focus(highlight_index,0)
		return end
	if key == 'up' then
		if highlight_index - 1 > 0 then
		highlight(highlight_index - 1)
		focus(highlight_index,0.2)
		end
	elseif key == 'down' then
		if highlight_index + 1 <= total then
		highlight(highlight_index + 1)
		focus(highlight_index,0.2)
		end
	elseif key == 'left' then
		if highlight_index-rows > 0 then 
		highlight(highlight_index - rows)
		focus(highlight_index,0.2)
		end
	elseif key == 'right' then
		if highlight_index+rows <= total then 
		highlight(highlight_index + rows)
		focus(highlight_index,0.2)
		end
	elseif key == 'enter' then
		interact(highlight_index)
	end
end

function exit(mute)
	SKIN:Bang('!WriteKeyValue','Variables','Active','0','#@#Active.inc')
	if mute ~= true then
		if SKIN:GetVariable('SoundExit')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundExit')) end
	end
	SKIN:Bang('!DeactivateConfigGroup','GameHUB2')
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


function launch_effect()
	SKIN:Bang('!WriteKeyValue', 'Background', 'ImageName', '#@#Background\\'..SKIN:GetVariable('Background'..highlight_index), '#ROOTCONFIGPATH#\\Controller\\Background\\Image.ini')
	local gif=SKIN:GetVariable('Gif'..highlight_index)
	if gif ~= nil then
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Path', '"#@#Gif\\'..gif..'"', '#ROOTCONFIGPATH#\\Controller\\Launch\\GIF.ini')
		SKIN:Bang('!ActivateConfig','#ROOTCONFIG#\\Controller\\Launch', 'GIF.ini')
	else
	SKIN:Bang('!WriteKeyValue', 'MeterIcon', 'ImageName', '#@#Icons\\'..SKIN:GetVariable('Icon'..highlight_index), '#ROOTCONFIGPATH#\\Controller\\Launch\\Launching.ini')
	SKIN:Bang('!ActivateConfig','#ROOTCONFIG#\\Controller\\Launch', 'Launching.ini')
	end
end