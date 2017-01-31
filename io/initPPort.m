function port = initPPort()
    port.is64 = ~isempty(strfind(computer,'64'));
    if port.is64
        port.ioObj = io64; %initialize the hwinterface.sys kernel-level I/O driver
        status = io64(port.ioObj); %if status = 0, you are now ready to write and read to a hardware port
    else
        port.ioObj = io32; %initialize the hwinterface.sys kernel-level I/O driver
        status = io32(port.ioObj); %if status = 0, you are now ready to write and read to a hardware port
    end
    if status ~= 0
        warning('Parellel Port Init Issue')
    end
    port.address = hex2dec('378'); %standard LPT1 output port address (0x378)  
    port.value = 0;
    clearPPort(port);   
end
