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

function reverseIter(t)
    local i = #t + 1
    local n = 0
    return function ()
        i = i - 1
        if i >= n then
            return t[i]
        end
    end
end

function reverseTable(t)
	out = {}
	i = 1
	for item in reverseIter(t) do
		out[i] = item
		i = i + 1
	end
	return out
end

for line in lineByLineFileIter(arg[1]) do
	print(table.concat(reverseTable(stringSplit(line)), " "))
end