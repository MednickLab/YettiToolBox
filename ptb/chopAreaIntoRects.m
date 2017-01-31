function rects = chopAreaIntoRects(areaRect,rows,cols,paddingX,paddingY)
  areaW = areaRect(3)-areaRect(1);
  areaH = areaRect(4)-areaRect(2); 
  xBoxWithPadding = (areaW-paddingX)/cols;  
  yBoxWithPadding = (areaH-paddingY)/rows;
  xBox = xBoxWithPadding-paddingX;
  yBox = yBoxWithPadding-paddingY;
  rects = cell(rows*cols,1);
  for b=0:(rows*cols-1)
      ny = paddingY+floor(b/cols)*yBoxWithPadding+areaRect(2);
      nx = paddingX+mod(b,cols)*xBoxWithPadding+areaRect(1);
      rects{b+1} = [nx ny nx+xBox ny+yBox];
  end
end