function ccc = mfcc(x) 

bank=melbankm(24,256,8000,0,0.5,'m'); 
bank=full(bank); 
bank=bank/max(bank(:)); 
 

for k=1:12 
  n=0:23; 
  dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24)); 
end 
 

w = 1 + 6 * sin(pi * [1:12] ./ 12); 
w = w/max(w); 
 

xx=double(x); 
xx=filter([1 -0.9375],1,xx); 
 

xx=enframe(xx,256,80); 
 

for i=1:size(xx,1) 
  y = xx(i,:); 
  s = y' .* hamming(256); 
  t = abs(fft(s)); 
  t = t.^2; 
  c1=dctcoef * log(bank * t(1:129)); 
  c2 = c1.*w'; 
  m(i,:)=c2'; 
end 
 

dtm = zeros(size(m)); 
for i=3:size(m,1)-2 
  dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:); 
end 
dtm = dtm / 3; 
 

ccc = [m dtm]; 

ccc = ccc(3:size(m,1)-2,:); 


