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

function map(func, tbl)
    local t = {}
    for i,v in pairs(tbl) do
        t[i] = func(v)
    end

    return t
end

for line in lineByLineFileIter(arg[1]) do
    split = stringSplit(line, '|')
    charMap = {}
    for c in split[1]:gmatch('.') do
        charMap[#charMap + 1] = c
    end

    values = map(tonumber, stringSplit(split[2], ' '))

    solutionSet = {}

    for _,v in pairs(values) do
        solutionSet[#solutionSet + 1 ] = charMap[v]
    end

    print(table.concat(solutionSet, ''))
end
