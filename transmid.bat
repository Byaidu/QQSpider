@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
set aim=200
if not exist Music\Sum md Music\Sum
set top=0
for /f "delims=" %%a in (Music\statistic.txt) do (
  set skip=1
  for %%b in (%%a) do (
    if "!skip!"=="0" (
      set /a top+=1
      title !top!/!aim!
      start /b curl -o Music\Sum\%%b.txt "http://y.qq.com/portal/song/%%b.html" >nul 2>nul
      if "!top!"=="!aim!" goto skip
    ) else (
      set skip=0
    )
  )
)
:skip
title download
ping localhost -n 1 >nul
tasklist|find "curl.exe" >nul&&goto skip
set top=0
(for /f "delims=" %%a in (Music\statistic.txt) do (
  set skip=1
  for %%b in (%%a) do (
    if "!skip!"=="0" (
      set /a top+=1
      title pop:!pop!  !top!/!aim!
      for /f "tokens=2 delims=>#" %%c in ('findstr /c:"<title>" Music\Sum\%%b.txt') do set read=%%c&echo !read:~0,-1!
      if "!top!"=="!aim!" goto skip2
    ) else (
      set pop=%%b
      set skip=0
    )
  )
))>Music\top.txt
:skip2
pause