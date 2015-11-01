function isPrime(input)
	if input == 1 then return false end
	if input == 2 then return true end
	local highBounds = math.floor(math.sqrt(input))
	for i = 2, highBounds, 1 do
		if input % i == 0 then return false end
	end
	return true
end

counter = 1
i = 2
answer = 0
while counter <= 1000 do
	if isPrime(i) then
		answer = answer + i
		counter = counter + 1
	end
	i = i + 1
end
print(answer)