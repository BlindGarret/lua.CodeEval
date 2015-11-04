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

numericSet = {}
numericSet["zero"] = 0
numericSet["one"] = 1
numericSet["two"] = 2
numericSet["three"] = 3
numericSet["four"] = 4
numericSet["five"] = 5
numericSet["six"] = 6
numericSet["seven"] = 7
numericSet["eight"] = 8
numericSet["nine"] = 9

for line in lineByLineFileIter(arg[1]) do
	split = stringSplit(line, ';')
    numbers = {}
    for _,v in pairs(split) do
        numbers[#numbers + 1] = numericSet[v]
    end
    print(table.concat(numbers))
end
