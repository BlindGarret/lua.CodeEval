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

function isSelfDescribingNumber(integer)
    local digits = getDigits(integer)
    local maxVal = #digits
    local countSet = {}
    for _,v in pairs(digits) do
        if countSet[v] == nil then
            countSet[v] = 1
        else
            countSet[v] = countSet[v] + 1
        end
    end
    local success = true
    for i = 0, maxVal - 1 do
        if countSet[i] ~= digits[i+1] then
            if countSet[i] ~= nil or digits[i+1] ~= 0 then
                success = false
                break
            end
        end
    end
    return success
end

function getDigits(integer)
    local count = 0
    if integer > 0 then
        count = math.floor(math.log10(integer)) + 1
    else
        count = 1
    end

    local digits = {}
    while count > 0 do
        digits[count] = integer % 10
        integer = math.floor(integer / 10)
        count = count - 1
    end

    return digits
end

for line in lineByLineFileIter(arg[1]) do
    if isSelfDescribingNumber(tonumber(line)) then
        print(1)
    else
        print(0)
    end

end
