%include "windows.inc"


[section code public use32 class=CODE]

..start:
	%include "Argument.asm"

 Next1:	cmp Dword [mSec],0
	je Error

	STDCALL Sleep,[mSec]	; <<-- ����������� - Process Priority: Paused -->>

	cmp byte [ShutDown],1	; <<-- "Force" ShutDown ��� ������ �� ������������� ��������� -->>
	jne Nex2
		STDCALL ExitWindowsEx,EWX_SHUTDOWN | EWX_FORCE,0
		jmp Exit

  Nex2:	cmp byte [File],0
	je Nex1
		STDCALL mciSendStringA,File,0,0,0

  Nex1:	STDCALL MessageBoxA,0,Text,Captio1,MB_ICONASTERISK
	jmp Exit

Error:	STDCALL MessageBoxA,0,Problem,Caption,MB_ICONASTERISK
Exit:	STDCALL ExitProcess,0



[section reloc public use32 class=CODE]

Play	db 'play ',0
Captio1	db '�����...',0
Text	db '�������� ����...',0
Caption	db '�� ���������� ��� ������������...',0
Problem	db '������ ��� ��� ����������� ����� ����������.',13,10,13,10
	db '/mXX	�� �� ����� ��� ���� (1 - 71582) �� ����� ��������.',13,10
	db '/t	����������� ��� ����������.',13,10
	db '/s"XX"	������ �� ������ ���� XX.',0



 ; <<-- Uninitialized �������� - ��� �������� ��� ������ - ���� ��� ����� -->>

[section bss public use32 class=BSS]

ShutDown	resb 1
mSec		resd 1
File		resb 300