@echo off
title QQSpider
setlocal EnableDelayedExpansion
if exist Data\save.txt (
  rem ��ȥ�ϴεĻ���
  for /f "delims=" %%a in (Data\save.txt) do set %%a
  rem �г����е���չ����
  for %%a in (Level\L*.txt) do type %%a
) else (
  set /p read=���������㣺
  cls
  echo !read!
  rem ��һ�������ʼ��
  set level=1
  set nextlevel=2
  set count=0
  rem �������д���һ����չ������
  (echo !read!)>Level\L1.txt
  rem ��ֹ���ڵ㱻��ӵ��ڶ�����չ������
  set exist_!read!=1
  rem �洢���棬����֧�ֶϵ�����
  set>Data\save.txt
)
:loop
rem ��һ��cookie��ʼʹ��
set cookie=1
rem ��չ
for /f %%a in (Level\L!level!.txt) do (
  rem ��ֹ�ظ���չ
  if "!expand_%%a!"=="" (
    title QQSpider L!nextlevel!:!count! - download
    rem ����QQ�ռ��һҳ
    curl -o Data\qzone.txt -b Cookie\cookie!cookie!.txt --cacert Data\cacert.pem "https://mobile.qzone.qq.com/profile?hostuin=%%a" >nul 2>nul
    rem ʹ����һ��cookie����ֹ�˺��쳣
    set /a cookie+=1
    rem ����ǰʹ�õ�cookie�����һ���������´ӵ�һ��cookie��ʼʹ��
    if not exist Cookie\cookie!cookie!.txt set cookie=1
    title QQSpider L!nextlevel!:!count!
    rem ��ȡQQ�����б�
    start /b /wait getlist
    rem ��QQ������ӵ���һ����չ������
    for /f %%b in ('findstr /v "[^0-9]" Data\list.txt') do (
      rem 6~10λ�����֣�����Ѷ�ȡ���ֹ��չ���������ظ���
      set read=%%b
      if not "!read:~5,1!"=="" if "!read:~10,1!"=="" if "!exist_%%b!"=="" echo;%%b&(echo;%%b)>>Level\L!nextlevel!.txt&set exist_%%b=1&set /a count+=1
    )
    rem �������չ��
    set expand_%%a=1
    rem �洢���棬����֧�ֶϵ�����
    set>Data\save.txt
    rem ��ʱ����ֹ�˺��쳣
    rem ��Ȼ�����cookie�㹻��Ļ�����ע�͵���һ��
    for /l %%a in (30,-1,1) do ping localhost -n 2 >nul&title QQSpider L!nextlevel!:!count! - delay %%a
  )
)
rem ��һ�������ʼ��
set /a level+=1
set /a nextlevel=level+1
set count=0
goto loop