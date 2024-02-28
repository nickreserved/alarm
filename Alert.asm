%include "windows.inc"


[section code public use32 class=CODE]

..start:
	%include "Argument.asm"

 Next1:	cmp Dword [mSec],0
	je Error

	STDCALL Sleep,[mSec]	; <<-- Καθυστέρηση - Process Priority: Paused -->>

	cmp byte [ShutDown],1	; <<-- "Force" ShutDown και χάσιμο μη αποθηκευμένων δεδομένων -->>
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
Captio1	db 'Ξύπνα...',0
Text	db 'Αφύπνιση τώρα...',0
Caption	db 'Οι παράμετροι του προγράμματος...',0
Problem	db 'Κάποια από τις παραμέτρους είναι λανθασμένη.',13,10,13,10
	db '/mXX	Σε ΧΧ λεπτά από τώρα (1 - 71582) θα γίνει αφύπνιση.',13,10
	db '/t	Τερματισμός του υπολογιστή.',13,10
	db '/s"XX"	Παίζει το αρχείο ήχου XX.',0



 ; <<-- Uninitialized δεδομένα - Δεν υπάρχουν στο αρχείο - Μόνο στη μνήμη -->>

[section bss public use32 class=BSS]

ShutDown	resb 1
mSec		resd 1
File		resb 300