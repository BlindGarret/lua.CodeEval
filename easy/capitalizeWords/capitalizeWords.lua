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

for line in lineByLineFileIter(arg[1]) do
    fixedChars = {}
    lastChar = ' '
    for c in line:gmatch('.') do
        if lastChar == ' ' then
            fixedChars[#fixedChars + 1] = c:upper()
        else
            fixedChars[#fixedChars + 1] = c
        end
        lastChar = c
    end

    print(table.concat(fixedChars, ''))
end
