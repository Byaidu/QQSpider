@echo off
setlocal EnableDelayedExpansion
rem 删除无效数据以重新下载
for /f "delims=" %%a in ('findstr /s /m /c:"-4016" Level\*.txt') do del /s /q %%a >nul 2>nul
rem 统计已下载总数
set done=0
for /d %%a in (Level\L*) do for %%b in (%%a\*.txt) do set /a done+=1
rem 统计QQ号总数
set sum=0
for %%a in (Level\L*.txt) do for /f %%b in (%%a) do set /a sum+=1
rem 从第一个cookie开始使用
set cookie=1
rem 读取层文件列表
for %%a in (Level\L*.txt) do (
  set name=%%a
  rem 建立存放数据的文件夹
  if not exist "Level\!name:~6,-4!" md Level\!name:~6,-4!
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
if exist "Level\!name:~6,-4!\%1.txt" goto:eof
rem 读取当前cookie对应的g_tk值
set /p gtk=<Cookie\gtk!cookie!.txt
rem 下载个人数据，貌似只有个人数据对时间有要求
if not exist "Level\!name:~6,-4!\%1.txt" (
  curl -o Level\!name:~6,-4!\%1.txt -b Cookie\cookie!cookie!.txt --cacert Data\cacert.pem "https://mobile.qzone.qq.com/profile_get?g_tk=!gtk!^&hostuin=%1" >nul 2>nul
  rem 若提示访问过快则多延时30秒
  findstr /c:"-4016" Level\!name:~6,-4!\%1.txt >nul&&(
    for /l %%a in (30,-1,1) do ping localhost -n 2 >nul&title !done!/!sum! - delay %%a
    goto download
  )
  rem 使用下一个cookie，防止账号异常
  set /a cookie+=1
  rem 若当前使用的cookie是最后一个，则重新从第一个cookie开始使用
  if not exist Cookie\cookie!cookie!.txt set cookie=1
  rem 延时，防止账号异常
  rem 当然，如果cookie足够多的话可以注释掉这一行
  for /l %%c in (10,-1,1) do ping localhost -n 2 >nul&title !done!/!sum! - delay %%c
)
rem 已下载总数加一
set /a done+=1
goto:eof