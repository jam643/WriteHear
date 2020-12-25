function f=listen(p)

recObj = audiorecorder(p.hz,16,1,1);

fprintf('3');
pause(0.7);
fprintf(', 2');
pause(0.7);
fprintf(', 1\n');
pause(0.7);
disp('I am listening for your signature');
record(recObj);
input('click enter to stop recording.');
stop(recObj);
clc

f.xUnfiltRaw = getaudiodata(recObj)';