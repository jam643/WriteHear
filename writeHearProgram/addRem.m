function ar=addRem(word,add)

% guidata(hObject, handles);
load('words','W');
letter=1;
% word=get(handles.dictionary,'string');
i=1;
sort=0;
ar=0;
while sort==0
    if i>length(W)
        sort=1;
        if add==1
            W=[W,word];
            ar=1;
        end
    elseif letter>length(W{i}) && letter>length(word)
        sort=1;
        if add==0
            W(i)=[];
            ar=1;
        end
    elseif letter>length(W{i})
        i=i+1;
        letter=1;
    elseif letter>length(word) || uint8(word(letter))<uint8(W{i}(letter))
        sort=1;
        if add==1
            if i>1
                W={W{1:i-1},word,W{i:end}};
            else
                W=[word,W];
            end
            ar=1;
        end
    elseif uint8(word(letter))>uint8(W{i}(letter))
        i=i+1;
        letter=1;
    elseif uint8(word(letter))==uint8(W{i}(letter))
        letter=letter+1;
    end
end
save('words','W');