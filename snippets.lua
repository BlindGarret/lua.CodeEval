function lineByLineFileIter(t)
    local fh,err = io.open(arg[1])
    if(err) then
        print("File Open Err :" .. err)
        return nil
    end

    return function ()
        local line = ''
        while line == '' do
            line = fh:read()
        end

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

function reverse(t)
	local out = {}
	local i = 1
	for item in reverseIter(t) do
		out[i] = item
		i = i + 1
	end

	return out
end

function map(func, tbl)
	local t = {}
	for i,v in pairs(tbl) do
		t[i] = func(v)
	end

	return t
end

function filter(func, tbl)
	local t = {}
	local i = 1
	for _,v in pairs(tbl) do
		if func(v) then
			t[i] = v
			i = i + 1
		end
	end

	return t
end

function fold(func, val, tbl)
	for _,v in pairs(tbl) do
		val = func(val,v)
	end

	return val
end

function head(tbl)
	if #tbl < 1 then return nil end
	return tbl[1]
end

function last(tbl)
	if #tbl < 1 then return nil end
	return tbl[#tbl]
end

function tail(tbl)
	if #tbl < 1 then return nil end
	local tailTbl = {}
	local i = 2
	local max = #tbl
	while i <= max do
		tailTbl[i-1] = tbl[i]
		i = i + 1
	end

	return tailTbl
end

function init(tbl)
	if #tbl < 1 then return nil end
	local initTbl = {}
	local i = 1
	local max = #tbl -1 
	while i <= max do
		initTbl[i] = tbl[i]
		i = i + 1
	end

	return initTbl
end

function reduce(func, tbl)
	return fold(func, head(tbl), tail(tbl))
end

function reverseString(input)
	local tempTbl = {}
	local i = 1
	for c in input:gmatch(".") do
		tempTbl[#input + 1 - i] = c
		i = i + 1
	end

	return table.concat(tempTbl, "")
end

function isPalindrome(input)
	local val = tostring(input)
	return reverseString(val) == val
end

function isPrime(input)
	if input == 1 then return false end
	if input == 2 then return true end
	local highBounds = math.floor(math.sqrt(input))
	for i = 2, highBounds, 1 do
		if input % i == 0 then return false end
	end

	return true
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

function max(tbl)
	local val = tbl[1]
	for i = 2, #tbl do
		if val < tbl[i] then val = tbl[i] end
	end

	return val
end

function min(tbl)
	local val = tbl[1]
	for i = 2, #tbl do
		if val > tbl[i] then val = tbl[i] end
	end

	return val
end

function fileSize(file)
	local currentPointer = file:seek()
	local size = file:seek("end")
	file:seek("set", currentPointer)
	return size
end

function distinct(tbl)
    --mimics a hashset to distinct a
    -- list in one iterations of the
    -- input and one of the output.
    local hashSet = {}
    for _,v in pairs(tbl) do
        hashSet[v] = 1
    end

    local returnSet = {}
    for k,_ in pairs(hashSet) do
        returnSet[#returnSet+1] = k
    end

    return returnSet
end

function intersect(setOne, setTwo)
    --using a quick dictionary as iteration over both lists
    --  twice is still better than iteration over one list
    --  once and one list n times. I think...
    local holder = {}

    for _,v in pairs(setOne) do
        holder[v] = 0
    end

    for _,v in pairs(setTwo) do
        if holder[v] == 0 then
            holder[v] = 1
        end
    end

    local returnVal = {}
    for k,v in pairs(holder) do
        if v == 1 then
            returnVal[#returnVal+1] = k
        end
    end

    return returnVal
end

function lastIndex(string, char)
    local returnVal = -1
    local index = 1
    for c in string:gmatch('.') do
        if c == char then
            returnVal = index
        end
        index = index + 1
    end
    return returnVal
end

function getDigits(integer)
    local count = 0
    if integer > 0 then
        count = math.floor(math.log10(integer)) + 1
    else
        count = 1
    end

    local digits = {}
    while count > 0 do
        digits[count] = integer % 10
        integer = math.floor(integer / 10)
        count = count - 1
    end

    return digits
end

function isHappy(integer)
    local cache = {}
    while integer ~= 1 do
        if cache[integer] == 1 then
            break
        end
        cache[integer] = 1
        local digits = getDigits(integer)
        local doubled = map(function(x) return x*x end,digits)
        integer = reduce(function(x,y) return x+y end, doubled) 
    end
    if integer == 1 then
        return true
    else
        return false
    end
end

function isSelfDescribingNumber(integer)
    local digits = getDigits(integer)
    local maxVal = #digits
    local countSet = {}
    for _,v in pairs(digits) do
        if countSet[v] == nil then
            countSet[v] = 1
        else
            countSet[v] = countSet[v] + 1
        end
    end
    local success = true
    for i = 0, maxVal - 1 do
        if countSet[i] ~= digits[i+1] then
            if countSet[i] ~= nil or digits[i+1] ~= 0 then
                success = false
                break
            end
        end
    end
    return success
end

function unique(tbl)
    local hashSet = {}
    for _,v in pairs(tbl) do
    	if hashSet[v] == nil then
    		hashSet[v] = 1
    	else
    		hashSet[v] = hashSet[v] + 1
    	end
    end

    local returnSet = {}
    for k,v in pairs(hashSet) do
    	if v == 1 then
        	returnSet[#returnSet+1] = k
        end
    end

    return returnSet
end