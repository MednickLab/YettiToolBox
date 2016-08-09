function imgSize = scaleImageSize(imgSize,side,sideSize)
%resize the *imgSize* to closest pixel while maining scale so that the requested *side* (1=y,2=x) is at the correct
%*sideSize*, final *imgSize* is returned.
    imgSize(3-side) = round(imgSize(3-side)*sideSize/imgSize(side));
    imgSize(side) = sideSize;
end