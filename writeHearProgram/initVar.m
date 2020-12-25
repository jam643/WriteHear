function p=initVar()
% Initializes variables
%
%   Cornell University
%   Author Name: Jesse Miller 
%   Author NetID: jam643

p.hz=16000; %recording frequency (samples/second)
% number of samples of the audio signal to be averaged in the moving
% average
p.smoothWidth=round(0.045*p.hz);
% number of samples skipped while performing moving average
p.smoothIncrem=round(0.015*p.hz);
% frequency of smoothed audio
p.hzs=p.hz/p.smoothIncrem;
% pause in writing constituting the end of a letter
p.spaceWidth=round(0.25*p.hzs);
% minimum pause in writing constituting a letter has been written
p.minWidth=round(0.1*p.hzs);
% pause in writing constituding 
p.endWidth=round(1.4*p.hzs);
% pause indicating all writing has ended
p.stopWidth=round(3*p.hzs);
p.recd=1;
p.highz=7000;
p.lowhz=100;
p.noiseC=10;
[p.b,p.a] = butter(5, 2*[p.lowhz p.highz]/p.hz, 'bandpass');