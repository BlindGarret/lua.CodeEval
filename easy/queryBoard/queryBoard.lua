--[[Query Class Begin]]--

QueryBoard = {}

function QueryBoard:_setupGrid()
    self._grid = {}
    for i = 0, self.MaxSize  do
        self._grid[i] = {}
    end
end

function QueryBoard:_getValue(x,y)
    if self._grid[x][y] == nil then
        return 0
    else
        return self._grid[x][y]
    end
end

function QueryBoard:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    self.MaxSize = 255
    self:_setupGrid()
    return object
end

function QueryBoard:SetRow(rowIndex, value)
    for i = 0, self.MaxSize do
        self._grid[rowIndex][i] = value
    end
end

function QueryBoard:SetCol(colIndex, value)
    for i = 0, self.MaxSize do
        self._grid[i][colIndex] = value
    end
end

function QueryBoard:QueryRow(rowIndex)
    local output = 0
    for i = 0, self.MaxSize do 
        output = output + self:_getValue(rowIndex, i)
    end
    return output
end

function QueryBoard:QueryCol(colIndex)
    local output = 0
    for i = 0, self.MaxSize do 
        output = output + self:_getValue(i, colIndex)
    end
    return output
end

function QueryBoard:PrintBoard()
    for i = 0, self.MaxSize do 
        line = ''
        for j = 0, self.MaxSize do
            line = line .. self:_getValue(i,j)
        end
        print(line)
    end
end

--[[Query Class End]]--

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

function stringSplit(input, seperator)
    if seperator == nil then
        seperator = '%s'
    end
    local t = {}; i = 1
    for str in string.gmatch(input, "([^" .. seperator .. "]+)") do
        t[i] = str
        i = i+ 1
    end

    return t
end

board = QueryBoard:new()

jumpList = {}
jumpList["SetCol"] = function(x) board:SetCol(tonumber(x[2]),tonumber(x[3])) end
jumpList["SetRow"] = function(x) board:SetRow(tonumber(x[2]),tonumber(x[3])) end
jumpList["QueryCol"] = function(x) print(board:QueryCol(tonumber(x[2]))) end
jumpList["QueryRow"] = function(x) print(board:QueryRow(tonumber(x[2]))) end


for line in lineByLineFileIter(arg[1]) do
    split = stringSplit(line, ' ')
    jumpList[split[1]](split)
end
