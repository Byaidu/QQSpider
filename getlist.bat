@echo off
rem �п���js��д���������
setlocal EnableDelayedExpansion
set next=0
set lastinput=0
cd.>Data\list.txt
(for /l %%a in (0,1,1000) do (
  set /p input=
  rem ����һ�ζ�ȡ�ĺ�20���ַ�����һ�ζ�ȡ�ĺ�20���ַ���ͬ���˳�
  if "!input:~-20!"=="!lastinput:~-20!" exit
  set lastinput=!input!
  rem ����ǰ15����������
  if %%a gtr 15 (
    rem �滻�ؼ���
    set input=!input:"='!
    set input=!input:^>= !
    set input=!input:^<= !
    for %%b in (!input!) do (
      set read=%%b
      rem ��QQ�ű��ض��������ȡ
      if "!next!"=="2" (
        rem echo;!read:~0,-1!
        (echo;!read:~0,-1!)>>Data\list.txt
        set next=0
      )
      rem ��ȡQQ��
      if "!next!"=="1" (
        set next=0
        if "!read:~0,1!"=="'" if "!read:~-1!"=="'" (
          rem echo;!read:~1,-1!
          (echo;!read:~1,-1!)>>Data\list.txt
        ) else (
          rem set /p=!read:~1!<nul
          (set /p=!read:~1!<nul)>>Data\list.txt
          set next=2
        )
      )
      rem �ж��Ƿ���QQ��ǰ׺
      if "!read:~0,11!"=="data-params" set next=1
    )
  )
))<Data\qzone.txt