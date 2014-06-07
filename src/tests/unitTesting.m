%Runs the tests of the TEAPhysio lib
%NB: runTests.sh should be called instead

init

allPaths = genpath('.');
allPathsSplitted = strsplit(allPaths, ':');
for path = allPathsSplitted
	runtests(path{1})
end

