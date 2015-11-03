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
    split = stringSplit(line, ' ')
    numbers = map(tonumber, split)
    table.sort(numbers)
    formatted = map(function(x) return string.format("%.3f", x) end, numbers)
    print(table.concat(formatted, ' '))
end
