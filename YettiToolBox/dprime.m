function [dPrime] = dprime(pHit,pFA,N)
%If pHit = 1 or pFA = 0, then by convention:
if(exist('N'))
    pHit(pHit<1/N) = 1/N;
    pHit(pHit>((N-1)/N)) = (N-1)/N;
    pFA(pFA<1/N) = 1/N;
    pFA(pFA>((N-1)/N)) = (N-1)/N;
end

%-- Convert to Z scores, no error checking
zHit = norminv(double(pHit));
zFA  = norminv(double(pFA));

%-- Calculate d-prime
dPrime = zHit - zFA ;