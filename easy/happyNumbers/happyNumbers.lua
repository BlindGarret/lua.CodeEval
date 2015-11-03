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

function map(func, tbl)
    local t = {}
    for i,v in pairs(tbl) do
        t[i] = func(v)
    end

    return t
end

function reduce(func, tbl)
    return fold(func, head(tbl), tail(tbl))
end

for line in lineByLineFileIter(arg[1]) do
    if isHappy(tonumber(line)) then
        print(1)
    else
        print(0)
    end
end

