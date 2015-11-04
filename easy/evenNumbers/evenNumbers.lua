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
	if tonumber(line) % 2 == 0 then
        print(1)
    else
        print(0)
    end
end
