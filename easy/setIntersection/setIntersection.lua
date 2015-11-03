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

function map(func, tbl)
    local t = {}
    for i,v in pairs(tbl) do
        t[i] = func(v)
    end

    return t
end

for line in lineByLineFileIter(arg[1]) do
    sets = stringSplit(line, ';')
    setOne = stringSplit(sets[1], ',')
    setTwo = stringSplit(sets[2], ',')
    intersectSet = intersect(setOne, setTwo)
    if #intersectSet > 0 then
        finalSet = map(tonumber, intersectSet)
        table.sort(finalSet) --forgot to sort
        print(table.concat(finalSet, ','))
    end
end
