@echo on
set BASH_COMMAND=C:\Program Files\Git\bin\bash.exe

ping localhost -n 11 > nul

pushd "C:\Program Files\Docker Toolbox"
"%BASH_COMMAND%" --login -i "C:\Program Files\Docker Toolbox\start.sh" exit 0
popd

