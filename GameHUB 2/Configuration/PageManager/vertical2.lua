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

function get_meter()
	local meter_entry=1
	if SKIN:GetVariable('cover_meter.inc','0') == '1' then
		local meter, entry = {},1
		meter_list[meter_entry] = meter
		for i=1, total do
			meter[entry] = SKIN:GetMeter('Cover'..entry)
			SKIN:Bang('!SetOption','Cover'..entry, 'ImageName', '#@#Include\\Default\\#Cover'..entry..'#')
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
			SKIN:Bang('!SetOption','Background'..entry, 'ImageName', '#@#Include\\Default\\#Background'..entry..'#')
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
		v[mk]:SetY(y[mk]+offset_true)
		end
	end
	if highlight_index ~=0 then
		spectrum_meter:SetX(x[highlight_index]+offsetx)
		spectrum_meter:SetY(y[highlight_index]+offset_true)
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

function interact(index)
	edit=index
	local edit_layout=SKIN:GetVariable('edit_layout')
	local edit_entry=SKIN:GetVariable('edit_entry')
	if edit_layout=='' then return end
	if edit_entry=='' then return end
	edit_layout='page_'..edit_layout..'.inc'
	edit_entry=tonumber(edit_entry)

	local root=SKIN:GetVariable('@')
	if file_exists(root..'User\\list_game.inc') ~= true then 
		file_copy(root..'Include\\Default\\list_default.inc',root..'User\\list_game.inc')
	end
	
	local preset=SKIN:GetVariable('Dir'..edit)	

	file_copy(root..'Include\\Default\\'..preset, root..'User\\'..edit_layout)
		
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Total', edit_entry, '#@#User\\list_page.inc')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Name'..edit_entry, 'new layout', '#@#User\\list_page.inc')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Icon'..edit_entry, 'new.png', '#@#User\\list_page.inc')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Cover'..edit_entry, '', '#@#User\\list_page.inc')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Background'..edit_entry, '', '#@#User\\list_page.inc')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'Dir'..edit_entry, edit_layout, '#@#User\\list_page.inc')
	SKIN:Bang('!ActivateConfig', SKIN:GetVariable('CURRENTCONFIG'), 'list.ini')
end
