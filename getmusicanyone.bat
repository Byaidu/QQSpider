@echo off
setlocal EnableDelayedExpansion
:loop
set /p num=qqnum:
rem ��ȡ��ǰcookie��Ӧ��g_tkֵ
set /p gtk=<Cookie\gtk1.txt
rem �����������ݣ����û�����ƣ��ٺ�
curl -o Music\%%a.txt -b Cookie\cookie1.txt "http://c.y.qq.com/splcloud/fcgi-bin/fcg_musiclist_getinfo_inner.fcg?uin=!num!^&dirid=201^&from=0^&to=1000^&g_tk=!gtk!" >nul 2>nul
goto loop