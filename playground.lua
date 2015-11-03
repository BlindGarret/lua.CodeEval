require "snippets"

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

print(isSelfDescribingNumber(2020))
print(isSelfDescribingNumber(22))
print(isSelfDescribingNumber(1210))

