

timeStamp = string(datestr(now(), 30));
backUpDirectoryWhenNeeded(fullfile(userpath(), 'IRIS-Toolbox-stable'), timeStamp);
backUpDirectoryWhenNeeded(fullfile(userpath(), 'february-2023-colombia-workshop-master'), timeStamp);

unzip('IRIS-Toolbox-stable.zip', userpath());
unzip('february-2023-colombia-workshop-master.zip', userpath());

function backUpDirectoryWhenNeeded(dir, stamp)
    if exist(dir, "dir")
        dirStamped = dir + "-" + stamp;
        disp("    Moving the existing "+dir+" to "+dirStamped);
        movefile(dir, dirStamped);
    end
end%

