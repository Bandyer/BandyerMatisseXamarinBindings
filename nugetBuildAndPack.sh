#!/bin/bash -e 
# to be able to build you need installed:
# 1) xamarin itself
# 2) gradle

projectName=Bandyer.Matisse

# clean
rm -f *.nupkg

# clean android build
MSBuild $projectName/$projectName.csproj /t:Clean /target:Build /p:Configuration=Debug
MSBuild $projectName/$projectName.csproj /t:Clean /target:Build /p:Configuration=Release
cd $projectName
gradle clean
rm -rf bin
cd -

# fetch artifacts for android 
cd $projectName
gradle fetch
cd -

# build android project
MSBuild $projectName/$projectName.csproj /target:Build /p:Configuration=Debug 
MSBuild $projectName/$projectName.csproj /target:Build /p:Configuration=Release

# package for nuget
nuget pack $projectName/$projectName.nuspec -Verbosity detailed