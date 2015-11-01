function lineByLineFileIter(t)
	local fh,err = io.open(arg[1])
	if(err) then
		print("File Open Err :" .. err)
		return nil
	end
	return function ()
		local line = fh:read()
		if line == nil then
			fh:close()
			return nil
		end
		return line
	end
end

function max(tbl)
	local val = tbl[1]
	for i = 2, #tbl do
		if val < tbl[i] then val = tbl[i] end
	end
	return val
end

function getFibonnacci(max)
	if max == 0 then return nil end
	local returnVal = { 1 }
	returnVal[0] = 0
	local current = 1
	local last = 0
	for i = 2 , max do
		local temp = current + last
		returnVal[i] = temp
		last = current
		current = temp
	end
	return returnVal
end

vals = {}
i = 1
for line in lineByLineFileIter(arg[1]) do
	vals[i] = tonumber(line)
	i = i + 1
end

highVal = max(vals)

fibSet = getFibonnacci(highVal)

for _,v in pairs(vals) do
	print(fibSet[v])
end

