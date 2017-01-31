function clearScreen(ptbwin,noFlip)
    Screen(ptbwin,'FillRect',[255 255 255]);
    if exist('noFlip','var') return; end;
    Screen(ptbwin,'Flip');
end