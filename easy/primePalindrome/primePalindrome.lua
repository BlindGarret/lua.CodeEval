function reverseString(input)
	local tempTbl = {}
	local i = 1
	for c in input:gmatch(".") do
		tempTbl[#input + 1 - i] = c
		i = i + 1
	end
	return table.concat(tempTbl, "")
end

function isPalindrome(input)
	local val = tostring(input)
	return reverseString(val) == val
end

function isPrime(input)
	if input == 1 then return false end
	if input == 2 then return true end
	local highBounds = math.floor(math.sqrt(input))
	for i = 2, highBounds, 1 do
		if input % i == 0 then return false end
	end
	return true
end

for i = 1000, 0, -1 do
	if isPalindrome(i) and isPrime(i) then
		print(i)
		break;
	end
end