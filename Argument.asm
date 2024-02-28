	; <<-- Ελέγχος στο command line μέχρι να βρεθεί το " /" -->>

	STDCALL GetCommandLineA
.loop1:	cmp word [eax],' /'
	je .ne1
	inc eax
	cmp byte [eax],0
	jne .loop1
	jmp Next1

  .ne1:	add eax,2
	mov cx,[eax]
	cmp cl,'t'	; <<-- "/t" : Τερματισμός του υπολογιστή -->>
	jne .ne2
	inc byte [ShutDown]
	jmp .loop1

  .ne2:	cmp cl,'m'	; <<-- "/m" : Λεπτά απο τώρα -->>
	jne .ne3
	inc eax
	push eax
	LOCCALL String2Long,eax
	cmp eax,71583
	jnb near Error
	mov edx,60000		; <<-- Τόσα msec έχει ένα min
	mul dx
	shl edx,16
	mov dx,ax
	mov [mSec],edx
	pop eax
	jmp .loop1

  .ne3:	cmp cx,'s"'	; <<-- "/s"file"" : Αρχείο που θα παίξει -->>
	jne near Error
	inc eax
	mov ebx,eax
  .ne4:	inc eax
	cmp byte [eax],'"'
	jne .ne5
	push eax
	inc eax
	mov byte [eax],0
	STDCALL lstrcpy,File,Play
	STDCALL lstrcpy,File+5,ebx
	pop eax
	jmp .loop1
  .ne5:	cmp byte [eax],0
	je near Error
	jmp .ne4


; <<-- Μετατροπή string σε Long. Παράμετρος: pointer στο κείμενο. Επιστρέφει: ο αριθμός -->>

String2Long:
	push edx
	push ecx
	push ebx
	mov ebx,[esp+4+3*4]
	xor eax,eax
	xor ecx,ecx
.St2L1:	mov cl,[ebx]
	sub cl,48
	cmp cl,10
	jb .Str2L
	pop ebx
	pop ecx
	pop edx
	ret 4
.Str2L:	mov edx,10
	mul edx
	add eax,ecx
	inc ebx
	jmp .St2L1