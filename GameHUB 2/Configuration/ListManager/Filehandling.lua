function Initialize()
	FileName = SKIN:GetMeasure('MeasureFile')
	FileCount = SKIN:GetMeasure('FileCount')
	TotalFile = 0
	File = ''
	Action=SKIN:GetVariable('Action','')
	Filter = 'list_'
end

function get_file()
	local total = 0
	TotalFile=FileCount:GetValue()
	if TotalFile==0 then return end
	for i=0, TotalFile do
		file(i)
		local path,name,extension = SplitFilename(File)
		if name ~= 'list_page.inc' then
			if Filter == '' or string.sub(name, 1, 5) == Filter then
				total = total + 1
				SKIN:Bang('!SetVariable','Name'..total, name)
				if string.sub(name, 1, 5)=='list_' then SKIN:Bang('!SetOption','Icon'..total,'ImageName','list.png')
				elseif string.sub(name, 1, 5)=='page_' then SKIN:Bang('!SetOption','Icon'..total,'ImageName','layout.png')
				else SKIN:Bang('!SetOption','Icon'..total,'ImageName','question.png')
				end
			end
		end
	end
	SKIN:Bang('!SetVariable','Total', total)
end

function SplitFilename(strFilename)
	return string.match(strFilename, "(.-)([^\\]-([^\\%.]+))$")
end

function file(index)
	SKIN:Bang('!SetVariable', 'Index',index)
	SKIN:Bang('!UpdateMeasure', 'MeasureFile')
	File=FileName:GetStringValue()
end

