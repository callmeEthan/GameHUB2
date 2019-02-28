function Initialize()
	FileName = SKIN:GetMeasure('MeasureFile')
	FileCount = SKIN:GetMeasure('FileCount')
	TotalFile = 0
	File = ''
	Action=SKIN:GetVariable('Action','')
	SKIN:Bang('!SetVariable','LastOpen', 1)
	filelist = {}
	total = 0
end

function get_file()
	total = 0
	TotalFile=FileCount:GetValue()
	if TotalFile==0 then return end
	for i=1, TotalFile do
		file(i)
		total = total + 1
		local path,name,extension = SplitFilename(File)
		name = name:match("(.+)%..+")
		name = name:gsub("%.", " ")
		name = name:gsub('%b()', '')
		name = name:gsub('%b[]', '')
		SKIN:Bang('!SetVariable','Name'..total, name)
		SKIN:Bang('!SetOption','Icon'..total,'ImageName','#@#Icons\\video.png')
		SKIN:Bang('!SetVariable','Dir'..total,File)
		SKIN:Bang('!HideMeter','Cover'..total)
		filelist [total] = File
	end
	SKIN:Bang('!SetVariable','Total', total)
	Index = 1
	SKIN:Bang('!CommandMeasure','ThumbnailLoop', 'Execute 1')
end

function SplitFilename(strFilename)
	return string.match(strFilename, "(.-)([^\\]-([^\\%.]+))$")
end

function file(i)
	SKIN:Bang('!SetVariable', 'Index',i)
	SKIN:Bang('!UpdateMeasure', 'MeasureFile')
	File=FileName:GetStringValue()
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function load()
	if Index <= total then
		local root=SKIN:GetVariable('@')
		path,name,extension = SplitFilename(filelist[Index])
		name = name:match("(.+)%..+")
		name = root..'Include\\Thumbnails\\'..name..'.jpg'
		if file_exists(name) then
			SKIN:Bang('!SetOption','Cover'..Index, 'ImageName', name)
			SKIN:Bang('!HideMeter','Icon'..Index)
			SKIN:Bang('!ShowMeter','Cover'..Index)
			SKIN:Bang('!CommandMeasure','ThumbnailLoop','Execute 1')
			Index = Index + 1
		else
			SKIN:Bang('"'..root..'Include\\mtn\\mtn.exe" -w 1024 -t -i -r 1 -c 1 -P -O "'..root..'Include\\Thumbnails" -o ".jpg" "'..filelist[Index]..'"')
			SKIN:Bang('!CommandMeasure','ThumbnailLoop','Execute 2')
		end
	end
end


function load_thumbnail()
	SKIN:Bang('!SetOption','Cover'..Index, 'ImageName', name)
	SKIN:Bang('!HideMeter','Icon'..Index)
	SKIN:Bang('!ShowMeter','Cover'..Index)
	SKIN:Bang('!CommandMeasure','ThumbnailLoop','Execute 1')
	Index = Index + 1
end