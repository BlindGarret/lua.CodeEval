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
    split = stringSplit(line, ',')
    --whoops, want to maintain my index 1 standard in lua, but this breaks at -1...
    solution = lastIndex(split[1],split[2]) - 1
    if solution < -1 then solution = -1 end
    print(solution) 
end
