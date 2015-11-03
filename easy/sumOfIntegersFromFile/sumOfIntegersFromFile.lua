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

sum = 0
for line in lineByLineFileIter(arg[1]) do
    sum = sum + tonumber(line)
end

print(sum)
