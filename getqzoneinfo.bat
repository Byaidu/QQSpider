@echo off
setlocal EnableDelayedExpansion
rem ɾ����Ч��������������
for /f "delims=" %%a in ('findstr /s /m /c:"-4016" Level\*.txt') do del /s /q %%a >nul 2>nul
rem ͳ������������
set done=0
for /d %%a in (Level\L*) do for %%b in (%%a\*.txt) do set /a done+=1
rem ͳ��QQ������
set sum=0
for %%a in (Level\L*.txt) do for /f %%b in (%%a) do set /a sum+=1
rem �ӵ�һ��cookie��ʼʹ��
set cookie=1
rem ��ȡ���ļ��б�
for %%a in (Level\L*.txt) do (
  set name=%%a
  rem ����������ݵ��ļ���
  if not exist "Level\!name:~6,-4!" md Level\!name:~6,-4!
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
if exist "Level\!name:~6,-4!\%1.txt" goto:eof
rem ��ȡ��ǰcookie��Ӧ��g_tkֵ
set /p gtk=<Cookie\gtk!cookie!.txt
rem ���ظ������ݣ�ò��ֻ�и������ݶ�ʱ����Ҫ��
if not exist "Level\!name:~6,-4!\%1.txt" (
  curl -o Level\!name:~6,-4!\%1.txt -b Cookie\cookie!cookie!.txt --cacert Data\cacert.pem "https://mobile.qzone.qq.com/profile_get?g_tk=!gtk!^&hostuin=%1" >nul 2>nul
  rem ����ʾ���ʹ��������ʱ30��
  findstr /c:"-4016" Level\!name:~6,-4!\%1.txt >nul&&(
    for /l %%a in (30,-1,1) do ping localhost -n 2 >nul&title !done!/!sum! - delay %%a
    goto download
  )
  rem ʹ����һ��cookie����ֹ�˺��쳣
  set /a cookie+=1
  rem ����ǰʹ�õ�cookie�����һ���������´ӵ�һ��cookie��ʼʹ��
  if not exist Cookie\cookie!cookie!.txt set cookie=1
  rem ��ʱ����ֹ�˺��쳣
  rem ��Ȼ�����cookie�㹻��Ļ�����ע�͵���һ��
  for /l %%c in (10,-1,1) do ping localhost -n 2 >nul&title !done!/!sum! - delay %%c
)
rem ������������һ
set /a done+=1
goto:eof