function clearPPort(port)
    io32(port.ioObj,port.address,0);
end