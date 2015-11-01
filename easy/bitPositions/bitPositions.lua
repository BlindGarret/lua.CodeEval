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

function toBinary(num,bits)
    bits = bits or select(2,math.frexp(num))
    local t={} -- will contain the bits        
    for b=bits,1,-1 do
        t[b]=math.fmod(num,2)
        num=(num-t[b])/2
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

function reverse(t)
	local out = {}
	local i = 1
	for item in reverseIter(t) do
		out[i] = item
		i = i + 1
	end
	return out
end

for line in lineByLineFileIter(arg[1]) do
	split = stringSplit(line, ",")
	indexOne = tonumber(split[2])
	indexTwo = tonumber(split[3])
	val = tonumber(split[1])
	binary = reverse(toBinary(val))
	if binary[indexOne] == binary[indexTwo] then
		print("true")
	else
		print("false")
	end
end