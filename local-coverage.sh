mono --debug --profile=monocov:outfile=monocovCoverage.cov,+dotnetstack-slackbot ./packages/NUnit.Console.3.0.0/tools/nunit3-console.exe --process=Single ./dotnetstack-slackbot-Tests/bin/Debug/dotnetstack-slackbot-Tests.dll
monocov --export-xml=monocovCoverage monocovCoverage.cov
cat monocovCoverage.cov
ls monocovCoverage