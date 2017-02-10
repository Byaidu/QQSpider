@echo off
rem 有空用js重写这个批处理
setlocal EnableDelayedExpansion
set next=0
set lastinput=0
cd.>Data\list.txt
(for /l %%a in (0,1,1000) do (
  set /p input=
  rem 若上一次读取的后20个字符和这一次读取的后20个字符相同则退出
  if "!input:~-20!"=="!lastinput:~-20!" exit
  set lastinput=!input!
  rem 跳过前15段无用数据
  if %%a gtr 15 (
    rem 替换关键字
    set input=!input:"='!
    set input=!input:^>= !
    set input=!input:^<= !
    for %%b in (!input!) do (
      set read=%%b
      rem 若QQ号被截断则继续读取
      if "!next!"=="2" (
        rem echo;!read:~0,-1!
        (echo;!read:~0,-1!)>>Data\list.txt
        set next=0
      )
      rem 读取QQ号
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
      rem 判断是否是QQ号前缀
      if "!read:~0,11!"=="data-params" set next=1
    )
  )
))<Data\qzone.txt