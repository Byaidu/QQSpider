@echo off
setlocal EnableDelayedExpansion
:loop
set /p num=qqnum:
rem 读取当前cookie对应的g_tk值
set /p gtk=<Cookie\gtk1.txt
rem 下载音乐数据，这个没有限制，嘿嘿
curl -o Music\%%a.txt -b Cookie\cookie1.txt "http://c.y.qq.com/splcloud/fcgi-bin/fcg_musiclist_getinfo_inner.fcg?uin=!num!^&dirid=201^&from=0^&to=1000^&g_tk=!gtk!" >nul 2>nul
goto loop