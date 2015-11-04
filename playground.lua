require "snippets"

function unique(tbl)
    local hashSet = {}
    for _,v in pairs(tbl) do
    	if hashSet[v] == nil then
    		hashSet[v] = 1
    	else
    		hashSet[v] = hashSet[v] + 1
    	end
    end

    local returnSet = {}
    for k,v in pairs(hashSet) do
    	if v == 1 then
        	returnSet[#returnSet+1] = k
        end
    end

    return returnSet
end

t = {1,4,4,2,5,6,5,6,3}

print(table.concat(unique(t)))
