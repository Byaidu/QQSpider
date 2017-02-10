@echo off
setlocal EnableDelayedExpansion
(rem 统计各层人数
set sum=0
for %%a in (Level\L*.txt) do (
  set name=%%a
  set count=0
  for /f %%b in (%%a) do set /a count+=1
  set /a sum+=count
  echo !name:~6,-4!:!count!
)
echo SUM:!sum!
rem 统计生日，地址等信息
set count=0
for /d %%a in (Level\L*) do (
  for /f "delims=" %%b in ('dir /b %%a\*.txt') do (
    set /p=%%~nb <nul
    for /f "delims=" %%c in (%%a\%%b) do (
      for %%d in (%%c) do (
        set read=%%d
        set read=!read:{=!
        set read=!read:}=!
        if "!read:~0,5!"==""age"" set /p="!read! "<nul
        if "!read:~0,8!"==""cityid"" set /p="!read! "<nul
        if "!read:~0,11!"==""countryid"" set /p="!read! "<nul
        if "!read:~0,12!"==""provinceid"" set /p="!read! "<nul
      )
    )
    echo;
    set /a count+=1
    title 1/5  !count!/!sum!
  )
))>Level\statistic.txt
echo Save as Level\statistic.txt
pause