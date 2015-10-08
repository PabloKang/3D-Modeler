function graycode = dec2gray(dec,nbits)

% function graycode = dec2gray(dec,nbits)
%
% convert a decimal number to nbit gray code
%
% dec : decimal values to return code of
% nbits: number of bits 
%
% graycode : table of binary values
%

if ~all(dec==floor(dec))
  error('Input values are not integer');
end

% change d to binary string
bin = dec2bin(dec,nbits);

if (size(bin,2) > nbits)
  error('Input values require more than nbit bits to code');
end

% now convert the standard binary code
% to gray code.
graycode = zeros(size(bin));
for i = 1:size(graycode,1)
  % loop down thru the bits, xoring as we go
  for bit  = nbits:-1:2            
    graycode(i,bit) = xor(str2num(bin(i,bit-1)),str2num(bin(i,bit)));
  end
  graycode(i,1) = str2num(bin(i,1));
end
