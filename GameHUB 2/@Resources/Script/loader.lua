function Initialize()
	if SKIN:GetVariable('Active')=='0' then
		SKIN:Bang('!WriteKeyValue','Variables','Active','1','#@#Active.inc')
		if SKIN:GetVariable('SoundStart')~=nil then SKIN:Bang('Play #@#Sounds\\'..SKIN:GetVariable('SoundStart')) end
	end
	string=''
	blind=0
	config = {}
	root=SKIN:GetVariable('ROOTCONFIG')
	path=SKIN:GetVariable('ROOTCONFIGPATH')
	layout_file=SELF:GetOption("Layout")
	quick_setup(layout_file)
	dir=''
	local list=SKIN:GetVariable('LastActive',nil)
	if list==nil then return end
	last_active = {}
	for k,v in pairs(split_string(list,'|')) do last_active[v]=1 end
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
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


function quick_setup(file)
  if not file_exists(file) then
		print('Layout loader failed:Layout file missing')
		SKIN:Bang('!DeactivateConfig', root)
		return end
  for line in io.lines(file) do 
    check_line(line)
  end
end

function check_line(line)
	if string.sub(line, 1, 1)== '[' and string.match(line, ']') then
		line = line:gsub('%[', '')
		line = line:gsub('%]', '')
		if string.lower(line) == 'rainmeter' or string.lower(line) == 'variables'  then blind=1 else blind=0 end
		dir = SKIN:GetVariable('ROOTCONFIGPATH')..line..'\\config.inc'
			if blind==0 then
				table.insert(config,line)
				filewrite = io.open(dir, "w")
				filewrite:write('[Variables]\n')
				filewrite:close()
			end
	elseif string.match(line, '=') and blind==0 then
		line=split_string(line,'=')
		SKIN:Bang('!WriteKeyValue', 'Variables', line[1], line[2], dir)
	else
		filewrite = io.open(dir, "a")
		filewrite:write('\n'..line)
		filewrite:close()
	end
end

function activate_config()
	table.insert(config,'Controller')
	local list=nil
	for i, v in pairs(config) do
		if list == nil then list = v else list=list..'|'..v end
		if last_active[v] == 1 then last_active[v] = 0 end
		if SKIN:GetVariable(v,'')=='Display.ini' then SKIN:Bang('!ActivateConfig', root..'\\'..v, 'Display2.ini')
		else SKIN:Bang('!ActivateConfig', root..'\\'..v, 'Display.ini') end
	end
	for k,v in pairs(last_active) do
		if v == 1 then SKIN:Bang('!DeactivateConfig',root..'\\'..k) end
	end
	SKIN:Bang('!WriteKeyValue','Variables','LastActive',list,'#@#Active.inc')
	SKIN:Bang('!DeactivateConfig', root)
end