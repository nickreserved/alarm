# Basic Information
A very simple Windows alarm, written in pure x86 Assembly when I jump from DOS to Windows and tried to wrote Assembly on Windows.

Strings in program, are in Greek language.

Written for NASM Assembler and ALINK Linker on April 2002.

# Command Line Parameters

|Parameter|Example     |Description|
|---------|------------|-----------|
|/mXX     |/m1000      |Alarm at XX minutes. XX can be 1 to 71583.<br>In 1000 minutes in example.<br>A message box appears (except if computer termination was selected).<br>Mandatory parameter.|
|/t       |/t          |Alarm does hard computer termination.<br>Optional parameter.|
|/s"XX"   |/s"c:\1.mp3"|Alarm will play file XX.<br>In example the file c:\1.mp3.<br>Quotes are mandatory.<br>File path must be at most 300 chars long (there is a "File resb 300" in code).<br>File path can contain spaces but not characters other than english because from console to gui they are not transfered correctly (use CHCP 65001 probably). It can play every file Windows Media Player can play.<br>Optional parameter.|
