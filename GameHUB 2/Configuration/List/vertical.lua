function Initialize()
	total=tonumber(SKIN:GetVariable('Total','0'))
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
	meter_list = {}
	background_meter = nil
	offset=0
	offset_true=0
	offsetx=skinwidth
	scroll_limit=math.ceil(total/columns)
	scroll_limit=(scroll_limit * (bannerheight + space)) - skinheight
	scroll_limit=math.max(scroll_limit,0)
	if SKIN:GetVariable('Keyboard','0')=='0' then SKIN:Bang('!CommandMeasure','Control','Execute 1') end
	if SKIN:GetVariable('Gamepad','0')=='0' then SKIN:Bang('!CommandMeasure','Control','Execute 2') end
	if SKIN:GetVariable('ScrollLock','0')=='0' then scroll_lock=0 else scroll_lock=1 end
	static_background=tonumber(SKIN:GetVariable('StaticBackground','0'))
	action=''
	argument=''
	edit=0
end

function log(x)
	SKIN:Bang("!Log", x)
end

function get_meter()
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
		background_index = 1
		background_load_delay()	
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
		crop_x=meter_x
		crop_y=meter_y
		crop_w=meter_w
		crop_h=meter_h
		SKIN:Bang('!SetOption','Background'..i,'ImageCrop',crop_x..','..crop_y..','..crop_w..','..crop_h)
	end
end

function scroll(speed)
	if scroll_lock==1 then return end
	offset = offset - (speed * skinheight)
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

function is_image(f)
local p,f,extension = SplitFilename(f)
	if (extension == 'png') or (extension == 'jpg') or (extension == 'bmp') or (extension == 'gif') or (extension == 'tif') or (extension == 'ico') then 
		return 1 else return 0 end
end

function interact(index)
	if argument=='' then return end
	if action=='' then get_action() return end
	edit=index
	write_data()
end

function get_index()
	SKIN:Bang('!HideMeterGroup','Input')
	SKIN:Bang('!SetOption','Message2','Text','Select an entry')
	SKIN:Bang('!ShowMeter','Message2')
	meter_visible(1)
end

function set_index()
	edit=highlight_index
end

function get_action()
	SKIN:Bang('!HideMeterGroup','Input')
	if argument~='' and is_image(argument)==1 then
		SKIN:Bang('!ShowMeter','Option1')
		SKIN:Bang('!ShowMeter','Option2')
		SKIN:Bang('!ShowMeter','Option3')
		SKIN:Bang('!SetOption','Preview','ImageName',argument)
		SKIN:Bang('!ShowMeter','Preview')
	end
		SKIN:Bang('!ShowMeter','Option4')
	meter_visible(0)
end

function set_action(a)
	action=''
	if a=='icon' then action=a end
	if a=='cover' then action=a end
	if a=='background' then action=a end
	if a=='directory' then action=a end
	if a=='name' then action=a end
	write_data()
end

function get_input()
	local name=SKIN:GetVariable('Name'..edit,'')
	if action == 'name' then
	SKIN:Bang('!SetOption','MeasureInput','DefaultValue', name)
	SKIN:Bang('[!CommandMeasure "MeasureInput" "ExecuteBatch 1"]')
	return end
	SKIN:Bang('!HideMeterGroup','Input')
	SKIN:Bang('!SetOption','Message1','Text',name..' '..action)
	if action == 'directory' then SKIN:Bang('!SetOption','Message2','Text','Drag and drop executable file onto this windows') else SKIN:Bang('!SetOption','Message2','Text','Drag and drop image file onto this windows') end
	SKIN:Bang('!ShowMeter','Message1')
	SKIN:Bang('!ShowMeter','Message2')
	SKIN:Bang('!ShowMeter','IconInput')
	SKIN:Bang('!ShowMeter','IconInputOverlay')
	meter_visible(0)
end

function input_read()
	argument=SKIN:GetVariable('Input','')
	write_data()
end

function write_data()
	if argument == '' then get_input() return end
	if edit == 0 then get_index() return end
	if action == '' then get_action() return end
	local list = SKIN:GetVariable('List')
	print(list, action..' '..edit, argument)

	if action=='name' then
		SKIN:Bang('!SetVariable','Name'..edit, argument)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..edit, argument, '#@#User\\'..list)
	elseif action=='icon' then
		local path,filename = SplitFilename(argument)
		local to=SKIN:GetVariable('@')..'Icons'
		SKIN:Bang('[xcopy "'..argument..'" "'..to..'" /y]')
		SKIN:Bang('!SetVariable','Icon'..edit, filename)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..edit, filename, '#@#User\\'..list)
	elseif action=='cover' then
		local path,filename = SplitFilename(argument)
		local to=SKIN:GetVariable('@')..'Cover'
		SKIN:Bang('[xcopy "'..argument..'" "'..to..'" /y]')
		SKIN:Bang('!SetVariable','Cover'..edit, filename)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..edit, filename, '#@#User\\'..list)
	elseif action=='background' then
		local path,filename = SplitFilename(argument)
		local to=SKIN:GetVariable('@')..'Background'
		SKIN:Bang('[xcopy "'..argument..'" "'..to..'" /y]')
		SKIN:Bang('!SetVariable','Background'..edit, filename)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..edit, filename, '#@#User\\'..list)
	elseif action=='directory' then
		SKIN:Bang('!SetVariable','Dir'..edit, argument)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..edit, argument, '#@#User\\'..list)
	elseif action=='swap' then
		local n=SKIN:GetVariable('Name'..argument,'')
		local i=SKIN:GetVariable('Icon'..argument,'')
		local c=SKIN:GetVariable('Cover'..argument,'')
		local b=SKIN:GetVariable('Background'..argument,'')
		local d=SKIN:GetVariable('Dir'..argument,'')

		SKIN:Bang('!SetVariable','Name'..argument, SKIN:GetVariable('Name'..edit,''))
		SKIN:Bang('!SetVariable','Icon'..argument, SKIN:GetVariable('Icon'..edit,''))
		SKIN:Bang('!SetVariable','Cover'..argument, SKIN:GetVariable('Cover'..edit,''))
		SKIN:Bang('!SetVariable','Background'..argument, SKIN:GetVariable('Background'..edit,''))
		SKIN:Bang('!SetVariable','Dir'..argument, SKIN:GetVariable('Dir'..edit,''))
		SKIN:Bang('!SetVariable','Name'..edit, n)
		SKIN:Bang('!SetVariable','Icon'..edit, i)
		SKIN:Bang('!SetVariable','Cover'..edit, c)
		SKIN:Bang('!SetVariable','Background'..edit, b)
		SKIN:Bang('!SetVariable','Dir'..edit, d)

		SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..edit, SKIN:GetVariable('Name'..edit,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..edit, SKIN:GetVariable('Icon'..edit,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..edit, SKIN:GetVariable('Cover'..edit,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..edit, SKIN:GetVariable('Background'..edit,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..edit, SKIN:GetVariable('Dir'..edit,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..argument, SKIN:GetVariable('Name'..argument,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..argument, SKIN:GetVariable('Icon'..argument,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..argument, SKIN:GetVariable('Cover'..argument,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..argument, SKIN:GetVariable('Background'..argument,''), '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..argument, SKIN:GetVariable('Dir'..argument,''), '#@#User\\'..list)
	end

	argument = ''
	edit = 0
	action = ''
	SKIN:Bang('!HideMeterGroup','Input')
	meter_visible(1)
	SKIN:Bang('!Update')
end

function add_entry()
	local list = SKIN:GetVariable('List')
	edit = total + 1
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Total', edit, '#@#User\\'..list)
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..edit, 'new entry', '#@#User\\'..list)
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..edit, 'new.png', '#@#User\\'..list)
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..edit, '', '#@#User\\'..list)
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..edit, '', '#@#User\\'..list)
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..edit, '', '#@#User\\'..list)
	SKIN:Bang('!Refresh')
end

function delete_entry()
	local list = SKIN:GetVariable('List')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Total', total - 1, '#@#User\\'..list)
	if edit < total then
		for i=edit,total do
			SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..i, SKIN:GetVariable('Name'..i+1,''), '#@#User\\'..list)
			SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..i, SKIN:GetVariable('Icon'..i+1,''), '#@#User\\'..list)
			SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..i, SKIN:GetVariable('Cover'..i+1,''), '#@#User\\'..list)
			SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..i, SKIN:GetVariable('Background'..i+1,''), '#@#User\\'..list)
			SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..i, SKIN:GetVariable('Dir'..i+1,''), '#@#User\\'..list)
		end
	end
	SKIN:Bang('!Refresh')
end

function swap_entry()
	argument = edit
	action = 'swap'
	get_index()
end

function table.shallow_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return -1
end

function sort_alphabetically(descend)
	local entries, name, index, icon, cover, background, dir
	local list = SKIN:GetVariable('List')
	entries = {}
	for i=1, total do
		table.insert(entries, SKIN:GetVariable('Name'..i,''))
	end
	local sort = table.shallow_copy(entries)
	if descend==1 then table.sort(sort, function(a,b) return a > b end) else table.sort(sort) end
	
	log('sort result')
	for i=1, total do
		name = sort[i]
		index = indexOf(entries, name)
		if index ~= -1 then
		log(i..": "..name)
		icon = SKIN:GetVariable('Icon'..index,'')
		cover = SKIN:GetVariable('Cover'..index,'')
		background = SKIN:GetVariable('Background'..index,'')
		dir = SKIN:GetVariable('Dir'..index,'')
		
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..i, name, '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..i, icon, '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..i, cover, '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..i, background, '#@#User\\'..list)
		SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..i, dir, '#@#User\\'..list)
		end
	end
	log("sort completed")
	SKIN:Bang('!Refresh')
end