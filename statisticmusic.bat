@echo off
setlocal EnableDelayedExpansion
rem ͳ��������Ϣ
rem ֱ��д���ڴ����������������ļ�����ת
title 1/4
set count=0
(for /d %%a in (Music\L*) do type %%a\*.txt 2>nul)|cscript -nologo -e:jscript getmusic.js >Data\music.txt
title 2/4
rem �Ӵ�С������ļ�
set musicsum=0
for /f %%a in (Data\music.txt) do set /a musicsum+=1
set count=0
for /f %%a in (Data\music.txt) do (
  rem ???
  if not "%%a"=="jsonCallback({" (
    set /a popular_%%a+=1
    if !popular_%%a! gtr !popularest! set popularest=!popular_%%a!
  )
  set /a count+=1
  title 3/4  !count!/!musicsum!
)
title 4/4
for /f "tokens=2,3 delims==_" %%a in ('set popular_') do set popularlist_%%b=%%a !popularlist_%%b!
(for /l %%a in (!popularest!,-1,1) do if not "!popularlist_%%a!"=="" echo %%a !popularlist_%%a!)>Music\statistic.txt
echo Save as Music\statistic.txt
pause