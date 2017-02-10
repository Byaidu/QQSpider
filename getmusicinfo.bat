@echo off
setlocal EnableDelayedExpansion
rem 统计已下载总数
set done=0
for /d %%a in (Music\L*) do for %%b in (%%a\*.txt) do set /a done+=1
rem 统计QQ号总数
set sum=0
for %%a in (Level\L*.txt) do for /f %%b in (%%a) do set /a sum+=1
rem 从第一个cookie开始使用
set cookie=1
rem 读取层文件列表
for %%a in (Level\L*.txt) do (
  set name=%%a
  rem 建立存放数据的文件夹
  if not exist "Music\!name:~6,-4!" md Music\!name:~6,-4!
  rem 读取层文件中QQ号
  for /f %%b in (%%a) do (
    echo %%b
    rem 下载个人数据
    call:download %%b
  )
)
title !done!/!sum! - done
echo Done
pause
exit

:download
title !done!/!sum! - download
rem 防止重新下载
if exist "Music\!name:~6,-4!\%1.txt" goto:eof
rem 读取当前cookie对应的g_tk值
set /p gtk=<Cookie\gtk!cookie!.txt
rem 下载音乐数据，这个没有限制，嘿嘿
if not exist "Music\!name:~6,-4!\%1.txt" start /b curl -o Music\!name:~6,-4!\%1.txt -b Cookie\cookie!cookie!.txt "http://c.y.qq.com/splcloud/fcgi-bin/fcg_musiclist_getinfo_inner.fcg?uin=%1^&dirid=201^&from=0^&to=1000^&g_tk=!gtk!" >nul 2>nul
rem 已下载总数加一
set /a done+=1
goto:eof