@echo off
echo Killing Next.js development servers...

REM Next.js�J���T�[�o�[����肵�ďI��
wmic process where "name='node.exe' and commandline like '%%next dev%%'" delete 2>nul
if %errorlevel% equ 0 (
    echo Next.js dev servers terminated.
) else (
    echo No Next.js dev servers found by command line.
)

REM �|�[�g3000-3010��node.exe�v���Z�X���`�F�b�N
for /L %%i in (3000,1,3010) do (
    for /f "tokens=5" %%p in ('netstat -ano 2^>nul ^| findstr ":%%i "') do (
        tasklist /FI "PID eq %%p" /FI "IMAGENAME eq node.exe" 2>nul | findstr node.exe >nul
        if not errorlevel 1 (
            echo Killing Node.js on port %%i: PID %%p
            taskkill /PID %%p /F 2>nul
        )
    )
)

echo Done.
timeout 2 >nul