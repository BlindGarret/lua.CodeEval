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

function min(tbl)
    local val = tbl[1]
    for i = 2, #tbl do
        if val > tbl[i] then val = tbl[i] end
    end

    return val
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

function map(func, tbl)
    local t = {}
    for i,v in pairs(tbl) do
        t[i] = func(v)
    end

    return t
end

for line in lineByLineFileIter(arg[1]) do
    originalSet = map(tonumber, stringSplit(line, ' '))
	numbers = unique(originalSet)
    if #numbers == 0 then
        print(0)
    else
        winningVal = min(numbers)
    end
    for i,v in pairs(originalSet) do
        if v == winningVal then
            print(i)
            break
        end
    end
end
