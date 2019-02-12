function Initialize()
	init=0
	list=SKIN:GetVariable('List')
	layout=SKIN:GetVariable('Layout')
end

function update()
	local code=tonumber(SKIN:GetVariable('broadcast',-1))
	local data=SKIN:GetVariable('broadcast_data','_')
	local receiver=SKIN:GetVariable('broadcast_id','null')
	if list ~= receiver then return end
	SKIN:Bang('!CommandMeasure','Animation',data)
end

function broadcast_cmd(cmd)
	SKIN:Bang('!SetVariableGroup','broadcast',1,'G2Animate')
	SKIN:Bang('!SetVariableGroup','broadcast_data',cmd,'G2Animate')
	SKIN:Bang('!SetVariableGroup','broadcast_id',list,'G2Animate')
	SKIN:Bang('!UpdateGroup','G2Animate')
end