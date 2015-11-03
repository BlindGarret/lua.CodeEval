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

for line in lineByLineFileIter(arg[1]) do
    points = {}

    for s in line:gmatch("%((%-?%d+, %-?%d+)%)") do
        split = stringSplit(s, ', ')
        local point = {}
        point.X = tonumber(split[1])
        point.Y = tonumber(split[2])
        points[#points + 1] = point
    end

    answer = math.sqrt(math.pow(points[2].X - points[1].X, 2) + math.pow(points[2].Y - points[1].Y, 2))
    print(string.format("%d", answer))
end
