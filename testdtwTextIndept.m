disp('Starting the Speaker Recognition ...')

for i=1:4
	fname = sprintf('trainNo\\s%d.wav',i); 
	[x,Fs] = audioread(fname); 
	[x1 x2] = vad(x); 
	m = mfcc(x);
    %[x1 x2]
	%m = m(x1-2:x2-2,:); 
	ref(i).mfcc = m; 
end 
 
%disp('...') 
for i=1:4
	fname = sprintf('testYes\\s%d.wav',i); 
	[x,Fs] = audioread(fname); 
	[x1 x2] = vad(x); 
	m = mfcc(x); 
	%m = m(x1-2:x2-2,:); 
	test(i).mfcc = m; 
end 
 
%disp('...') 
dist = zeros(4,4); 
for i=1:4 
for j=1:4 
	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc); 
end 
end 
 
%disp('...') 
for i=1:4 
	[d,j] = min(dist(i,:)); 
	fprintf('%d %d\n', i, j); 
end 



