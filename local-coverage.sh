mono --debug --profile=monocov:outfile=monocovCoverage.cov,+dotnetstack-slackbot ./packages/NUnit.ConsoleRunner.3.4.1/tools/nunit3-console.exe --process=Single ./dotnetstack-slackbot-Tests/bin/Release/dotnetstack-slackbot-Tests.dll
monocov --export-xml=monocovCoverage monocovCoverage.cov
cat monocovCoverage.cov
ls monocovCoverage