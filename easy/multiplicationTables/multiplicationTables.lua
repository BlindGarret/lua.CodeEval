for i = 1, 12 do
	t = {}
	for j = 1, 12 do
		t[j] = string.format ("%4s", j * i)
	end
	print(table.concat(t))
end