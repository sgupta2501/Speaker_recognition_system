disp('Starting the Speaker Recognition ...')

for i=1:8
	fname = sprintf('trainNo_Yes\\s%d.wav',i); 
	[x,Fs] = audioread(fname); 
	[x1 x2] = vad(x); 
	m = mfcc(x);
    %[x1 x2]
	%m = m(x1-2:x2-2,:); 
	ref(i).mfcc = m; 
end 
 
%disp('...') 
for i=1:8
	fname = sprintf('testNo_Yes\\s%d.wav',i); 
	[x,Fs] = audioread(fname); 
	[x1 x2] = vad(x); 
	m = mfcc(x); 
	%m = m(x1-2:x2-2,:); 
	test(i).mfcc = m; 
end 
 
%disp('...') 
dist = zeros(8,8); 
for i=1:8 
for j=1:8 
	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc); 
end 
end 
 
%disp('...') 
for i=1:8 
	[d,j] = min(dist(i,:)); 
	fprintf('%d %d\n', i, j); 
end 