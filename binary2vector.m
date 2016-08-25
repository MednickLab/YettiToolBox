function out = binary2vector(data,nBits)

powOf2 = 2.^[0:nBits-1];

out = false(1,nBits);

ct = nBits;

while data>0
if data >= powOf2(ct)
data = data-powOf2(ct);
out(ct) = true;
end
ct = ct - 1;
end