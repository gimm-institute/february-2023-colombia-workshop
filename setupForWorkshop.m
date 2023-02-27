
cd(userpath)
disp("    Setting up workshop repositories in " + pwd())

workshopDir = "gimm-messr";
irisDir = "iris-bleeding";
timeStamp = string(datestr(now(), 30));

backUpDirectoryWhenNeeded(workshopDir, timeStamp);
backUpDirectoryWhenNeeded(irisDir, timeStamp);

status = system("git clone --filter=blob:none https://github.com/gimm-institute/february-2023-colombia-workshop.git " + workshopDir);
if status~=0
    error("Cannot clone IGPMN GEES model repository.");
end

status = system("git clone --filter=blob:none https://github.com/IRIS-Solutions-Team/IRIS-Toolbox.git " + irisDir);
if status~=0
    error("Cannot clone Iris Toolbox repository.");
end


function backUpDirectoryWhenNeeded(dir, stamp)
    if exist(dir, "dir")
        dirStamped = dir + "-" + stamp;
        disp("    Moving the existing "+dir+" to "+dirStamped);
        movefile(dir, dirStamped);
    end
end%

