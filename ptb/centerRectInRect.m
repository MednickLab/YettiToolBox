function centeredRect = centerRectInRect(containerRect,centeredRect)
    conX = (containerRect(3)-containerRect(1))/2 + containerRect(1);
    conY = (containerRect(4)-containerRect(2))/2 + containerRect(2);
    cenX = (centeredRect(3)-centeredRect(1))/2 + centeredRect(1);
    cenY = (centeredRect(4)-centeredRect(2))/2 + centeredRect(2);
    moveX = conX - cenX;
    moveY = conY - cenY;
    centeredRect = [centeredRect(1)+moveX centeredRect(2)+moveY centeredRect(3)+moveX centeredRect(4)+moveY];
end