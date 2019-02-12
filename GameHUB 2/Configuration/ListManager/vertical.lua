function Initialize()
	total=0
	if SKIN:GetVariable('InvertScroll')=='1' then scroll_multiplier=-1 else scroll_multiplier=1 end
	columns=tonumber(SKIN:GetVariable('Columns','1'))
	space=tonumber(SKIN:GetVariable('Space','0'))
	columnspace=tonumber(SKIN:GetVariable('ColumnSpace','0'))
	bannerwidth=tonumber(SKIN:GetVariable('BannerWidth','100','100'))
	bannerheight=tonumber(SKIN:GetVariable('BannerHeight','100','100'))
	skinwidth=tonumber(SKIN:GetVariable('CURRENTCONFIGWIDTH'))
	skinheight=tonumber(SKIN:GetVariable('CURRENTCONFIGHEIGHT'))-50
	divider=tonumber(SKIN:GetVariable('ScrollDivider','8'))
	transition=tonumber(SKIN:GetVariable('Transition','8'))
	SpectrumIcon=tonumber(SKIN:GetVariable('SpectrumIcon','1'))
	highlight_solid=SKIN:GetVariable('HighlightColor','0,0,0,1')
	highlight_tint=SKIN:GetVariable('HighlightTint','255,255,255')
	highlight_index = 0
	spectrum = 0
	x,y = {}, {}
	meter_list = {}
	background_meter = nil
	offset=0
	offset_true=0
	offsetx=skinwidth
	if SKIN:GetVariable('Keyboard','0')=='0' then SKIN:Bang('!CommandMeasure','Control','Execute 1') end
	if SKIN:GetVariable('Gamepad','0')=='0' then SKIN:Bang('!CommandMeasure','Control','Execute 2') end
	if SKIN:GetVariable('ScrollLock','0')=='0' then scroll_lock=0 else scroll_lock=1 end
	static_background=tonumber(SKIN:GetVariable('StaticBackground','0'))
	action=SKIN:GetVariable('Action','')
	argument=''
	edit=0
	if action ~= '' then action_perform() end
end

function get_meter()
	total=tonumber(SKIN:GetVariable('Total','0'))
	local xx,yy,entry=0,0,0
	for i=1, total do
		x[entry+1]=xx
		y[entry+1]=yy
		entry = entry + 1
		if entry % columns == 0 then
			yy = yy + bannerheight + space
			xx = 0
		else
			xx = xx + bannerwidth + columnspace
		end			
	end
	scroll_limit=math.ceil(total/columns)
	scroll_limit=(scroll_limit * (bannerheight + space)) - skinheight
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
		end

	if SKIN:GetVariable('directory_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Directory'..entry)
			entry = entry+1
		end
		meter_entry = meter_entry + 1
		end
	
	if SKIN:GetVariable('Title','1') == '0' then SKIN:Bang('!HideMeterGroup','Title') end
	if spectrum == 1 then spectrum_meter=SKIN:GetMeter('SpectrumCover') else spectrum_meter=SKIN:GetMeter('HighlightCover') end
	local last_open=tonumber(SKIN:GetVariable('LastOpen','0'))
end

function move()
	local skinx=tonumber(SKIN:GetVariable('SkinX'))
	local skiny=tonumber(SKIN:GetVariable('SkinY'))
	local displaywidth=tonumber(SKIN:GetVariable('DisplayWidth'))
	local displayheight=tonumber(SKIN:GetVariable('DisplayHeight'))
	SKIN:Bang('!Move',skinx * displaywidth,skiny * displayheight)
end

function update()
	offset_true = (offset_true-((offset_true-offset)/divider))
	offsetx = (offsetx-((offsetx-0)/transition))
	for k,v in pairs(meter_list) do
		for mk,mv in pairs(v) do
		v[mk]:SetX(x[mk]+offsetx)
		v[mk]:SetY(y[mk]+offset_true+50)
		end
	end
	if highlight_index ~=0 then
		spectrum_meter:SetX(x[highlight_index]+offsetx)
		spectrum_meter:SetY(y[highlight_index]+offset_true+50)
	end
	if static_background == 1 then static_background_set() end
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
		crop_x=meter_x
		crop_y=meter_y
		crop_w=meter_w
		crop_h=meter_h
		SKIN:Bang('!SetOption','Background'..i,'ImageCrop',crop_x..','..crop_y..','..crop_w..','..crop_h)
	end
end

function scroll(speed)
	if scroll_lock==1 then return end
	offset = offset - (speed * skinheight) * scroll_multiplier
	if offset>space then offset = space end
	if offset<-scroll_limit then offset = -scroll_limit end
end

function highlight(index)
	highlight_index = tonumber(index)
	spectrum_meter:Show()
	SKIN:Bang('!SetOptionGroup','Icon', 'SolidColor', SKIN:GetVariable('IconSolid'))
	SKIN:Bang('!SetOption','Icon'..highlight_index, 'SolidColor', highlight_solid)
	SKIN:Bang('!SetOption','Icon'..highlight_index, 'ImageTint', highlight_tint)
	if spectrum == 1 then SKIN:Bang('!SetOption','SpectrumCover', 'ImageName', '#@#\\Cover\\'..SKIN:GetVariable('Cover'..highlight_index)) end
	focus(highlight_index,0)
	if SpectrumIcon==0 then SKIN:Bang('!SetOption','Icon'..highlight_index,'ImageAlpha',0) end
end

function dehighlight(index)
	local index=tonumber(index)
	spectrum_meter:Hide()
	SKIN:Bang('!SetOption','Icon'..index, 'SolidColor',  SKIN:GetVariable('IconSolid','0,0,0,1'))
	SKIN:Bang('!SetOption','Icon'..index, 'ImageTint',  SKIN:GetVariable('IconTint','255,255,255'))
	if SpectrumIcon==0 then SKIN:Bang('!SetOption','Icon'..highlight_index,'ImageAlpha',255) end
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

function focus(index,scaling)
	if scroll_lock==1 then return end
	local center=skinheight*scaling
	local index=tonumber(index)
	offset=math.min(offset,-(y[index]-(skinheight-center-bannerheight)))
	offset=math.max(offset,-(y[index]-center))
	scroll(0)
end

function input(key)
	if key == 'back' then exit() return end
	if highlight_index==0 then
		highlight_index=1
		highlight(highlight_index)
		focus(highlight_index,0)
		return end
	if key == 'left' then
		if highlight_index - 1 > 0 then
		highlight_index = highlight_index - 1
		highlight(highlight_index)
		focus(highlight_index,0.2)
		end
	elseif key == 'right' then
		if highlight_index + 1 <= total then
		highlight_index = highlight_index + 1
		highlight(highlight_index)
		focus(highlight_index,0.2)
		end
	elseif key == 'up' then
		if highlight_index-columns > 0 then 
		highlight_index = highlight_index - columns
		highlight(highlight_index)
		focus(highlight_index,0.2)
		end
	elseif key == 'down' then
		if highlight_index+columns <= total then 
		highlight_index = highlight_index + columns
		highlight(highlight_index)
		focus(highlight_index,0.2)
		end
	elseif key == 'enter' then
		interact(highlight_index)
	end
end

function meter_visible(visible)
	if visible==0 then
	scroll_lock=1
	SKIN:Bang('!HideMeterGroup', 'Title')
	SKIN:Bang('!HideMeterGroup', 'Icon')
	SKIN:Bang('!HideMeterGroup', 'Cover')
	else
	scroll_lock=0
	SKIN:Bang('!ShowMeterGroup', 'Title')
	SKIN:Bang('!ShowMeterGroup', 'Icon')
	SKIN:Bang('!ShowMeterGroup', 'Cover')
	end
end

function exit()
	SKIN:Bang('!DeactivateConfig',SKIN:GetVariable('CURRENTCONFIG'))
end

function SplitFilename(strFilename)
	return string.match(strFilename, "(.-)([^\\]-([^\\%.]+))$")
end


function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function file_copy(from,to)
	if file_exists(to) then
		SKIN:Bang('!SetOption','Message2','Text','File already exists')
		SKIN:Bang('!ShowMeter','Message2')
		return 0 end
	local infile = io.open(from, "r")
	local instr = infile:read("*a")
	infile:close()

	local outfile = io.open(to, "w")
	outfile:write(instr)
	outfile:close()
	return 1
end

function is_image(f)
local p,f,extension = SplitFilename(f)
	if (extension == 'png') or (extension == 'jpg') or (extension == 'bmp') or (extension == 'gif') or (extension == 'tif') or (extension == 'ico') then 
		return 1 else return 0 end
end

function interact(index)
	if action=='' then return end
	edit=index
	action_perform()
end

function get_index()
	SKIN:Bang('!HideMeterGroup','Input')
	if action == 'delete_entry' then
		SKIN:Bang('!SetOption', 'Message2', 'Text', 'Select an entry#CRLF#(Delete a file in use may cause error)')
	else	SKIN:Bang('!SetOption','Message2','Text','Select an entry')
	end
	SKIN:Bang('!ShowMeter','Message2')
	meter_visible(1)
end

function set_index()
	edit=highlight_index
	if action == '' then return end
	action_perform()
end

function set_action(a)
	action=''
	if a=='add_list' then action = a end
	if a=='add_layout' then action = a end
	if a=='delete_entry' then action = a end
	if a=='edit_entry' then	action = a end
	if a=='delete_entry' then
		action = a
		edit = 0
		end
	action_perform()
end

function get_input(a)
	meter_visible(0)
	SKIN:Bang('!HideMeterGroup','Input')
	if action == 'add_list' then
		SKIN:Bang('!SetOption','MeasureInput','DefaultValue', 'name')
		SKIN:Bang('[!CommandMeasure "MeasureInput" "ExecuteBatch 1"]')
		SKIN:Bang('!SetOption','Message1','Text','Enter new list name:')
		SKIN:Bang('!ShowMeter','Message1')
	elseif action == 'add_layout' then
		SKIN:Bang('!SetOption','MeasureInput','DefaultValue', 'name')
		SKIN:Bang('[!CommandMeasure "MeasureInput" "ExecuteBatch 1"]')
		SKIN:Bang('!SetOption','Message1','Text','Enter new layout name:')
		SKIN:Bang('!ShowMeter','Message1')
	end
end

function input_read()
	argument =  SKIN:GetVariable('Input','')
	if argument == '' then return end
	action_perform()
end

function action_perform()
	if action == 'add_list' then
		if argument == '' then get_input() return end
		local root=SKIN:GetVariable('@')
		if file_copy(root..'Include\\Default\\list_default.inc',root..'User\\list_'..argument..'.inc') == 1 then
			SKIN:Bang('!Refresh')
			else
			SKIN:Bang('!HideMeterGroup','Input')
			meter_visible(1)
			SKIN:Bang('!SetOption','Message2','Text', 'File already exist')
			SKIN:Bang('!ShowMeter','Message2')
		end
	elseif action == 'add_layout' then
		if argument == '' then get_input() return end
		local root=SKIN:GetVariable('@')
		if file_copy(root..'Include\\Default\\list_default.inc',root..'User\\list_'..argument..'.inc') == 1 then
			SKIN:Bang('!Refresh')
			else
			SKIN:Bang('!HideMeterGroup','Input')
			meter_visible(1)
			SKIN:Bang('!SetOption','Message2','Text', 'File already exist')
			SKIN:Bang('!ShowMeter','Message2')
		end
	
	elseif action == 'edit_entry' then
		if edit==0 then get_index() return end
			local name=SKIN:GetVariable('Name'..edit)
		if string.sub(name, 1, 5)=='list_' then
			SKIN:Bang('[!WriteKeyValue Variables List "'..name..'" "#ROOTCONFIGPATH#Configuration\\List\\config.inc"][!ActivateConfig "#ROOTCONFIG#\\configuration\\List" "List.ini][!CommandMeasure Animation exit()]')
			else
			SKIN:Bang('"#@#User\\'..name..'"')
			end
	elseif action == 'delete_entry' then
		if edit==0 then get_index() return end
			local name=SKIN:GetVariable('Name'..edit)
			local root=SKIN:GetVariable('@')
			os.remove(root..'User\\'..name)
			SKIN:Bang('!Refresh')
	elseif action == 'set_list' then
		meter_visible(1)
		SKIN:Bang('!HideMeterGroup','Input')
		if edit==0 then get_index() return end
			local edit_config=SKIN:GetVariable('edit_config')
			local edit_page=SKIN:GetVariable('edit_page')
			if edit_config==nil or edit_page==nil then
				SKIN:Bang('!SetOption','Message2','Text', 'Failed: missing argument')
				SKIN:Bang('!ShowMeter','Message2')
			return end
		edit_config=split_string(edit_config,'\\')[2]
		argument=SKIN:GetVariable('Name'..edit)
		SKIN:Bang('!WriteKeyValue', edit_config, 'List', argument, '#@#User\\'..edit_page)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'filelayout', edit_page, '#@#Settings.inc')
		SKIN:Bang('!ActivateConfig', '#ROOTCONFIG#', 'GameHUB.ini')
		exit()
	end
	action=''
	argument=''
	edit=0
end