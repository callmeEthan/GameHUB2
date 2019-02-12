-- RepeatSection v1.1 Modded for GameHUB2
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

function Initialize()
	w={}
	entry=1
end

function read(table)
	for key,file in pairs(table) do
	SKIN:Bang('!SetVariable', file, 1)
	local dir=SKIN:GetVariable('@')..'Include\\'
	local j,ini,gsub=1,io.input(dir..file):read("*all"),string.gsub
	local Sub,Index,Limit=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetNumberOption("Index")),SKIN:ParseFormula(SELF:GetNumberOption("Limit","0"))
		for i=Index,Limit do
			w[entry]=gsub(ini,Sub,i)
			j=j+1
			entry=entry+1
		end
	end
end

function write(file)
	local output=SKIN:GetVariable('CURRENTPATH')
	local f=io.open(output..file,"w")
	f:write(table.concat(w,"\n\n"))
	f:close()
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