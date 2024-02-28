@echo off
nasm -ic:\programs\utilities\assembly\nasm\Win32inc\ -fobj Alert.asm
alink -oPE Alert.obj
del *.obj