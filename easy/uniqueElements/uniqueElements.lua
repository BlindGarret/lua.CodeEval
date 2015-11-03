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
    initialSet = stringSplit(line, ',')
    distinctSet = map(tonumber, distinct(initialSet)) -- forgot these were strings...
    table.sort(distinctSet)
    print(table.concat(distinctSet, ','))
end
