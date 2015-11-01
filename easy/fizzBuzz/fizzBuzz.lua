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
	split = stringSplit(line)
	max = tonumber(split[3])
	fizz = tonumber(split[1])
	buzz = tonumber(split[2])
	output = {}	

	for i = 1 , max, 1 do
		val = ""
		if i % fizz == 0 then 
			val = val .. "F"
		end
		if i % buzz == 0 then 			
			val = val .. "B"
		end
		if val == "" then
			val = tostring(i)
		end
		output[i] = val
	end

	print(table.concat(output, " "))
end