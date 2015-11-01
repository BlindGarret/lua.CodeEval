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