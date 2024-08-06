echo MSBUILD
"C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" .\src\FrameworkWebApplication\FrameworkWebApplication.csproj /p:Configuration=Release /p:DeployOnBuild=true /p:PublishProfile=FolderProfile.pubxml

echo DOCKER CLEAN
docker rm dnfolwm
docker image rm dotnetframeworkonlinuxwithmono

echo DOCKER BUILD
docker build . -t dotnetframeworkonlinuxwithmono

echo DOCKER RUN
docker run -a stdout -p 1234:80 --name dnfolwm -t dotnetframeworkonlinuxwithmono

pause