function lineByLineFileIter(t)
	local fh,err = io.open(arg[1])
	if(err) then
		print("File Open Err :" .. err)
		return nil
	end
	return function ()
		local line = fh:read()
		if line == nil then
			fh:close()
			return nil
		end
		return line
	end
end

function fold(func, val, tbl)
	for _,v in pairs(tbl) do
		val = func(val,v)
	end
	return val
end

function head(tbl)
	if #tbl < 1 then return nil end
	return tbl[1]
end

function tail(tbl)
	if #tbl < 1 then return nil end
	local tailTbl = {}
	local i = 2
	local max = #tbl
	while i <= max do
		tailTbl[i-1] = tbl[i]
		i = i + 1
	end
	return tailTbl
end

function reduce(func, tbl)
	return fold(func, head(tbl), tail(tbl))
end

function add(x,y)
	return x + y
end

for line in lineByLineFileIter(arg[1]) do
	t = {}
	i = 1
	for c in line:gmatch(".") do
		t[i] = tonumber(c)
		i = i + 1
	end
	print(reduce(add, t))
end