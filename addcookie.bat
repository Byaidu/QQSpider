@echo off
setlocal EnableDelayedExpansion
:loop
set /p login=url:
rem ����Ӧ�ñ��浽�ĸ�cookie��
set cookie=1
:loop2
if exist Cookie\cookie!cookie!.txt set /a cookie+=1&goto loop2
:loop3
rem ��ȡcookie
curl -o Data\login.txt -c Cookie\cookie!cookie!.txt "!login!"
rem ��ȡ��չcookie��URL
for /f "tokens=3 delims=," %%a in (Data\login.txt) do set checksig=%%a
if "!checksig:~1,-1!"=="" goto loop3
rem ��չcookie
curl -o Data\checksig.txt -b Cookie\cookie!cookie!.txt -c Cookie\cookie!cookie!.txt --cacert Data\cacert.pem "!checksig:~1,-1!"
rem ����gtk.js���㲢����g_tkֵ
for /f "tokens=7" %%a in ('findstr /r "\<skey\>" Cookie\cookie!cookie!.txt') do (set /p=%%a<nul)>Data\skey.txt
for /f %%b in ('cscript -nologo -e:jscript getgtk.js ^<Data\skey.txt') do (echo;%%b)>Cookie\gtk!cookie!.txt
echo Save as Cookie\cookie!cookie!.txt^&Cookie\gtk!cookie!.txt
goto loop