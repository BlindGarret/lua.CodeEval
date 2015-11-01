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

function stringSplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	local t = {}; i = 1
	for str in string.gmatch(input, "([^" .. seperator .. "]+)") do
		t[i] = str
		i = i+ 1
	end
	return t
end

for line in lineByLineFileIter(arg[1]) do
	split = stringSplit(line, ",")
	min = tonumber(split[1])
	start = tonumber(split[2])
	actual = 0
	multiplier = 1
	while actual < min do
		actual = start * multiplier
		multiplier = multiplier + 1
	end
	print(actual)
end