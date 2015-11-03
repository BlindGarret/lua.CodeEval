function fileSize(file)
    local currentPointer = file:seek()
    local size = file:seek("end")
    file:seek("set", currentPointer)
    return size
end

currFile = io.open(arg[1])
print(fileSize(currFile))
