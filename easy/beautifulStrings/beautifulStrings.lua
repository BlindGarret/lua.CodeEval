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

function getMaxStringBeauty(input)
    local lowered = input:lower()
    local countSet = {}    
    for c in lowered:gmatch('.') do --forgot to handle numeric characters...
        if not(c:match('%W')) and not(c:match('%d')) then
            if countSet[c] == nil then
                countSet[c] = 1
            else
                countSet[c] = countSet[c] + 1
            end
        end
    end

    local valueSet = {}
    for i,v in pairs(countSet) do
        valueSet[#valueSet + 1] = v
    end

    table.sort(valueSet, function(a,b) return a > b end)
    local solution = 0
    local currentMax = 26
    for i,v in pairs(valueSet) do
        solution = solution + (currentMax * v)
        currentMax = currentMax - 1
    end
    return solution
end

for line in lineByLineFileIter(arg[1]) do
    print(getMaxStringBeauty(line))
end
