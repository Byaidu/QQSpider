@echo off
setlocal EnableDelayedExpansion
rem ͳ������������
set done=0
for /d %%a in (Music\L*) do for %%b in (%%a\*.txt) do set /a done+=1
rem ͳ��QQ������
set sum=0
for %%a in (Level\L*.txt) do for /f %%b in (%%a) do set /a sum+=1
rem �ӵ�һ��cookie��ʼʹ��
set cookie=1
rem ��ȡ���ļ��б�
for %%a in (Level\L*.txt) do (
  set name=%%a
  rem ����������ݵ��ļ���
  if not exist "Music\!name:~6,-4!" md Music\!name:~6,-4!
  rem ��ȡ���ļ���QQ��
  for /f %%b in (%%a) do (
    echo %%b
    rem ���ظ�������
    call:download %%b
  )
)
title !done!/!sum! - done
echo Done
pause
exit

:download
title !done!/!sum! - download
rem ��ֹ��������
if exist "Music\!name:~6,-4!\%1.txt" goto:eof
rem ��ȡ��ǰcookie��Ӧ��g_tkֵ
set /p gtk=<Cookie\gtk!cookie!.txt
rem �����������ݣ����û�����ƣ��ٺ�
if not exist "Music\!name:~6,-4!\%1.txt" start /b curl -o Music\!name:~6,-4!\%1.txt -b Cookie\cookie!cookie!.txt "http://c.y.qq.com/splcloud/fcgi-bin/fcg_musiclist_getinfo_inner.fcg?uin=%1^&dirid=201^&from=0^&to=1000^&g_tk=!gtk!" >nul 2>nul
rem ������������һ
set /a done+=1
goto:eof