@echo off
title QQSpider
setlocal EnableDelayedExpansion
if exist Data\save.txt (
  rem 读去上次的缓存
  for /f "delims=" %%a in (Data\save.txt) do set %%a
  rem 列出所有的扩展队列
  for %%a in (Level\L*.txt) do type %%a
) else (
  set /p read=请输入根结点：
  cls
  echo !read!
  rem 第一层变量初始化
  set level=1
  set nextlevel=2
  set count=0
  rem 将根结点写入第一层扩展队列中
  (echo !read!)>Level\L1.txt
  rem 防止根节点被添加到第二层扩展队列中
  set exist_!read!=1
  rem 存储缓存，用于支持断点续传
  set>Data\save.txt
)
:loop
rem 第一个cookie开始使用
set cookie=1
rem 扩展
for /f %%a in (Level\L!level!.txt) do (
  rem 防止重复扩展
  if "!expand_%%a!"=="" (
    title QQSpider L!nextlevel!:!count! - download
    rem 下载QQ空间第一页
    curl -o Data\qzone.txt -b Cookie\cookie!cookie!.txt --cacert Data\cacert.pem "https://mobile.qzone.qq.com/profile?hostuin=%%a" >nul 2>nul
    rem 使用下一个cookie，防止账号异常
    set /a cookie+=1
    rem 若当前使用的cookie是最后一个，则重新从第一个cookie开始使用
    if not exist Cookie\cookie!cookie!.txt set cookie=1
    title QQSpider L!nextlevel!:!count!
    rem 获取QQ好友列表
    start /b /wait getlist
    rem 将QQ好友添加到下一层扩展队列中
    for /f %%b in ('findstr /v "[^0-9]" Data\list.txt') do (
      rem 6~10位纯数字，标记已读取项，防止扩展队列中有重复项
      set read=%%b
      if not "!read:~5,1!"=="" if "!read:~10,1!"=="" if "!exist_%%b!"=="" echo;%%b&(echo;%%b)>>Level\L!nextlevel!.txt&set exist_%%b=1&set /a count+=1
    )
    rem 标记已扩展项
    set expand_%%a=1
    rem 存储缓存，用于支持断点续传
    set>Data\save.txt
    rem 延时，防止账号异常
    rem 当然，如果cookie足够多的话可以注释掉这一行
    for /l %%a in (30,-1,1) do ping localhost -n 2 >nul&title QQSpider L!nextlevel!:!count! - delay %%a
  )
)
rem 下一层变量初始化
set /a level+=1
set /a nextlevel=level+1
set count=0
goto loop