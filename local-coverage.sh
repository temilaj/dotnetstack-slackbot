nuget restore dotnetstack-slackbot.sln
sudo apt-get install gtk-sharp2
curl -sS https://api.nuget.org/packages/mono.cecil.0.9.6.4.nupkg > /tmp/mono.cecil.0.9.6.4.nupkg.zip
unzip /tmp/mono.cecil.0.9.6.4.nupkg.zip -d /tmp/cecil
cp /tmp/cecil/lib/net45/Mono.Cecil.dll .
cp /tmp/cecil/lib/net45/Mono.Cecil.dll /tmp/cecil/
git clone --depth=50 git://github.com/csMACnz/monocov.git ../../csMACnz/monocov
cd ../../csMACnz/monocov
cp /tmp/cecil/Mono.Cecil.dll .
./configure
make
sudo make install
cd ../../bolorundurowb/dotnetstack-slackbot

xbuild /p:Configuration=Release ./dotnetstack-slackbot.sln
export LD_LIBRARY_PATH=/usr/local/lib
mono --debug --profile=monocov:outfile=monocovCoverage.cov,+dotnetstack-slackbot ./src/packages/NUnit.Console.3.4.1/tools/nunit-console.exe --process=Single ./src/dotnetstack-slackbot-Tests/bin/Release/dotnetstack-slackbot-Tests.dll
monocov --export-xml=monocovCoverage monocovCoverage.cov
cat monocovCoverage.cov
ls monocovCoverage
REPO_COMMIT_AUTHOR=$(git show -s --pretty=format:"%cn")
REPO_COMMIT_AUTHOR_EMAIL=$(git show -s --pretty=format:"%ce")
REPO_COMMIT_MESSAGE=$(git show -s --pretty=format:"%s")
echo $TRAVIS_COMMIT
echo $TRAVIS_BRANCH
echo $REPO_COMMIT_AUTHOR
echo $REPO_COMMIT_AUTHOR_EMAIL
echo $REPO_COMMIT_MESSAGE
echo $TRAVIS_JOB_ID
mono ./src/packages/coveralls.net.0.7.0/tools/csmacnz.Coveralls.exe --monocov -i ./monocovCoverage --repoToken $COVERALLS_REPO_TOKEN --commitId $TRAVIS_COMMIT --commitBranch $TRAVIS_BRANCH --commitAuthor "$REPO_COMMIT_AUTHOR" --commitEmail "$REPO_COMMIT_AUTHOR_EMAIL" --commitMessage "$REPO_COMMIT_MESSAGE" --jobId $TRAVIS_JOB_ID  --serviceName travis-ci  --useRelativePaths