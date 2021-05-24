disp('...')

for i=1:11
	fname = sprintf('train0\\s%d.wav',i); 
	[x,Fs] = audioread(fname); 
	[x1 x2] = vad(x); 
	m = mfcc(x);
    %[x1 x2]
	%m = m(x1-2:x2-2,:); 
	ref(i).mfcc = m; 
end 
 
%disp('...') 
for i=1:11
	fname = sprintf('test0\\s%d.wav',i); 
	[x,Fs] = audioread(fname); 
	[x1 x2] = vad(x); 
	m = mfcc(x); 
	%m = m(x1-2:x2-2,:); 
	test(i).mfcc = m; 
end 
 
%disp('...') 
dist = zeros(11,11); 
for i=1:11 
for j=1:11 
	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc); 
end 
end 
 
%disp('...') 
for i=1:11 
	[d,j] = min(dist(i,:)); 
	fprintf('%d %d\n', i, j); 
end 



