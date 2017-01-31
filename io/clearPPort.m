function clearPPort(port)
    if port.is64
        io64(port.ioObj,port.address,0);
    else
        io32(port.ioObj,port.address,0);
    end
end