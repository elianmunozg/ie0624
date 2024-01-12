;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (MINGW64)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"bingo.c"
	list	p=12f683
	radix dec
	include "p12f683.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__mulint
	extern	__modsint
	extern	__divsint
	extern	__moduint
	extern	_ANSEL
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_numeroYaGenerado
	global	_mostrarNumero
	global	_generarNumeroAleatorio
	global	_initPIC
	global	_contador
	global	_contador99
	global	_indiceNumeros
	global	_numerosGenerados

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_bingo_0	udata
_numerosGenerados	res	20

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_bingo_0	udata
r0x101A	res	1
r0x101B	res	1
r0x101D	res	1
r0x101E	res	1
r0x101C	res	1
r0x101F	res	1
r0x1020	res	1
r0x1021	res	1
r0x1022	res	1
r0x1023	res	1
r0x1024	res	1
r0x1025	res	1
r0x1026	res	1
r0x1027	res	1
r0x1028	res	1
r0x1029	res	1
r0x102A	res	1
r0x102B	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_bingo_0	idata
_indiceNumeros
	db	0x00, 0x00	;  0


IDD_bingo_1	idata
_contador99
	db	0x00, 0x00	;  0


IDD_bingo_2	idata
_contador
	db	0x00, 0x00	; 0

;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_bingo	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _initPIC
;   _generarNumeroAleatorio
;   _numeroYaGenerado
;   __mulint
;   _mostrarNumero
;   _initPIC
;   _generarNumeroAleatorio
;   _numeroYaGenerado
;   __mulint
;   _mostrarNumero
;11 compiler assigned registers:
;   r0x1024
;   r0x1025
;   r0x1026
;   r0x1027
;   r0x1028
;   r0x1029
;   STK00
;   STK02
;   STK01
;   r0x102A
;   r0x102B
;; Starting pCode block
S_bingo__main	code
_main:
; 2 exit points
;	.line	56; "bingo.c"	initPIC(); // Inicializar el PIC
	PAGESEL	_initPIC
	CALL	_initPIC
	PAGESEL	$
;	.line	59; "bingo.c"	for (int i = 0; i < 10; i++) {
	BANKSEL	r0x1024
	CLRF	r0x1024
	CLRF	r0x1025
	CLRF	r0x1026
	CLRF	r0x1027
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
_00159_DS_:
	BANKSEL	r0x1025
	MOVF	r0x1025,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00203_DS_
	MOVLW	0x0a
	SUBWF	r0x1024,W
_00203_DS_:
	BTFSC	STATUS,0
	GOTO	_00156_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	60; "bingo.c"	numerosGenerados[i] = -1; // -1 indica que aún no se ha generado el número
	BANKSEL	r0x1026
	MOVF	r0x1026,W
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x1028
	MOVLW	high (_numerosGenerados + 0)
	MOVWF	r0x1029
	MOVF	r0x1027,W
	BTFSC	STATUS,0
	INCFSZ	r0x1027,W
	ADDWF	r0x1029,F
	MOVF	r0x1028,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1029
	BTFSC	r0x1029,0
	BSF	STATUS,7
	MOVLW	0xff
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	MOVLW	0xff
	MOVWF	INDF
;	.line	59; "bingo.c"	for (int i = 0; i < 10; i++) {
	MOVLW	0x02
	BANKSEL	r0x1026
	ADDWF	r0x1026,F
	BTFSC	STATUS,0
	INCF	r0x1027,F
	INCF	r0x1024,F
	BTFSC	STATUS,2
	INCF	r0x1025,F
	GOTO	_00159_DS_
_00156_DS_:
;	.line	65; "bingo.c"	if (BOTON == 1) { // Suponiendo que 1 es presionado
	BANKSEL	r0x1024
	CLRF	r0x1024
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,5
	GOTO	_00001_DS_
	BANKSEL	r0x1024
	INCF	r0x1024,F
_00001_DS_:
	BANKSEL	r0x1024
	MOVF	r0x1024,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00156_DS_
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
;	.line	68; "bingo.c"	if (indiceNumeros < 10) {
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00204_DS_
	MOVLW	0x0a
	SUBWF	_indiceNumeros,W
_00204_DS_:
	BTFSC	STATUS,0
	GOTO	_00151_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
_00143_DS_:
;	.line	70; "bingo.c"	numero = generarNumeroAleatorio();
	PAGESEL	_generarNumeroAleatorio
	CALL	_generarNumeroAleatorio
	PAGESEL	$
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVF	STK00,W
;	.line	71; "bingo.c"	} while (numeroYaGenerado(numero)); // Verificar si el número ya fue generado
	MOVWF	r0x1024
	MOVWF	STK00
	MOVF	r0x1025,W
	PAGESEL	_numeroYaGenerado
	CALL	_numeroYaGenerado
	PAGESEL	$
	BANKSEL	r0x1027
	MOVWF	r0x1027
	MOVF	STK00,W
	MOVWF	r0x1026
	IORWF	r0x1027,W
	BTFSS	STATUS,2
	GOTO	_00143_DS_
;	.line	73; "bingo.c"	numerosGenerados[indiceNumeros++] = numero;
	BANKSEL	_indiceNumeros
	MOVF	_indiceNumeros,W
	BANKSEL	r0x1026
	MOVWF	r0x1026
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	BANKSEL	r0x1027
	MOVWF	r0x1027
	BANKSEL	_indiceNumeros
	INCF	_indiceNumeros,F
	BTFSC	STATUS,2
	INCF	(_indiceNumeros + 1),F
	BANKSEL	r0x1026
	MOVF	r0x1026,W
	MOVWF	STK02
	MOVF	r0x1027,W
	MOVWF	STK01
	MOVLW	0x02
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__mulint
	CALL	__mulint
	PAGESEL	$
	BANKSEL	r0x1027
	MOVWF	r0x1027
	MOVF	STK00,W
	MOVWF	r0x1026
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x1026
	MOVF	r0x1027,W
	BTFSC	STATUS,0
	INCFSZ	r0x1027,W
	ADDLW	high (_numerosGenerados + 0)
	MOVWF	r0x1027
	MOVF	r0x1026,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1027
	BTFSC	r0x1027,0
	BSF	STATUS,7
	MOVF	r0x1024,W
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	BANKSEL	r0x1025
	MOVF	r0x1025,W
	BANKSEL	INDF
	MOVWF	INDF
	GOTO	_00152_DS_
;;signed compare: left < lit(0x3=3), size=2, mask=ffff
_00151_DS_:
;	.line	74; "bingo.c"	} else if (contador99 < 3) {
	BANKSEL	_contador99
	MOVF	(_contador99 + 1),W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00205_DS_
	MOVLW	0x03
	SUBWF	_contador99,W
_00205_DS_:
	BTFSC	STATUS,0
	GOTO	_00148_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	75; "bingo.c"	numero = 99;
	MOVLW	0x63
	BANKSEL	r0x1024
	MOVWF	r0x1024
	CLRF	r0x1025
;	.line	76; "bingo.c"	contador99++;
	BANKSEL	_contador99
	INCF	_contador99,F
	BTFSC	STATUS,2
	INCF	(_contador99 + 1),F
	GOTO	_00152_DS_
_00148_DS_:
;	.line	79; "bingo.c"	indiceNumeros = 0;
	BANKSEL	_indiceNumeros
	CLRF	_indiceNumeros
	CLRF	(_indiceNumeros + 1)
;	.line	80; "bingo.c"	contador99 = 0;
	BANKSEL	_contador99
	CLRF	_contador99
	CLRF	(_contador99 + 1)
;	.line	81; "bingo.c"	for (int i = 0; i < 10; i++) {
	BANKSEL	r0x1026
	CLRF	r0x1026
	CLRF	r0x1027
	CLRF	r0x1028
	CLRF	r0x1029
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
_00162_DS_:
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00206_DS_
	MOVLW	0x0a
	SUBWF	r0x1026,W
_00206_DS_:
	BTFSC	STATUS,0
	GOTO	_00156_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	82; "bingo.c"	numerosGenerados[i] = -1;
	BANKSEL	r0x1028
	MOVF	r0x1028,W
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x102A
	MOVLW	high (_numerosGenerados + 0)
	MOVWF	r0x102B
	MOVF	r0x1029,W
	BTFSC	STATUS,0
	INCFSZ	r0x1029,W
	ADDWF	r0x102B,F
	MOVF	r0x102A,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x102B
	BTFSC	r0x102B,0
	BSF	STATUS,7
	MOVLW	0xff
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	MOVLW	0xff
	MOVWF	INDF
;	.line	81; "bingo.c"	for (int i = 0; i < 10; i++) {
	MOVLW	0x02
	BANKSEL	r0x1028
	ADDWF	r0x1028,F
	BTFSC	STATUS,0
	INCF	r0x1029,F
	INCF	r0x1026,F
	BTFSC	STATUS,2
	INCF	r0x1027,F
	GOTO	_00162_DS_
_00152_DS_:
;	.line	87; "bingo.c"	mostrarNumero(numero);
	BANKSEL	r0x1024
	MOVF	r0x1024,W
	MOVWF	STK00
	MOVF	r0x1025,W
	PAGESEL	_mostrarNumero
	CALL	_mostrarNumero
	PAGESEL	$
	GOTO	_00156_DS_
;	.line	91; "bingo.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;11 compiler assigned registers:
;   r0x101A
;   STK00
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;   r0x101F
;   r0x1020
;   r0x1021
;   r0x1022
;   r0x1023
;; Starting pCode block
S_bingo__numeroYaGenerado	code
_numeroYaGenerado:
; 2 exit points
;	.line	43; "bingo.c"	int numeroYaGenerado(int numero) {
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
;	.line	44; "bingo.c"	for (int i = 0; i < 10; i++) {
	CLRF	r0x101C
	CLRF	r0x101D
	CLRF	r0x101E
	CLRF	r0x101F
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
_00121_DS_:
	BANKSEL	r0x101D
	MOVF	r0x101D,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00137_DS_
	MOVLW	0x0a
	SUBWF	r0x101C,W
_00137_DS_:
	BTFSC	STATUS,0
	GOTO	_00119_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	45; "bingo.c"	if (numerosGenerados[i] == numero) {
	BANKSEL	r0x101E
	MOVF	r0x101E,W
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x1020
	MOVLW	high (_numerosGenerados + 0)
	MOVWF	r0x1021
	MOVF	r0x101F,W
	BTFSC	STATUS,0
	INCFSZ	r0x101F,W
	ADDWF	r0x1021,F
	MOVF	r0x1020,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1021
	BTFSC	r0x1021,0
	BSF	STATUS,7
	BANKSEL	INDF
	MOVF	INDF,W
	BANKSEL	r0x1022
	MOVWF	r0x1022
	BANKSEL	FSR
	INCF	FSR,F
	MOVF	INDF,W
	BANKSEL	r0x1023
	MOVWF	r0x1023
	MOVF	r0x101B,W
	XORWF	r0x1022,W
	BTFSS	STATUS,2
	GOTO	_00122_DS_
	MOVF	r0x101A,W
	XORWF	r0x1023,W
	BTFSS	STATUS,2
	GOTO	_00122_DS_
;	.line	46; "bingo.c"	return 1; // Número ya fue generado
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	GOTO	_00123_DS_
_00122_DS_:
;	.line	44; "bingo.c"	for (int i = 0; i < 10; i++) {
	MOVLW	0x02
	BANKSEL	r0x101E
	ADDWF	r0x101E,F
	BTFSC	STATUS,0
	INCF	r0x101F,F
	INCF	r0x101C,F
	BTFSC	STATUS,2
	INCF	r0x101D,F
	GOTO	_00121_DS_
_00119_DS_:
;	.line	49; "bingo.c"	return 0; // Número no ha sido generado
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x00
_00123_DS_:
;	.line	50; "bingo.c"	}
	RETURN	
; exit point of _numeroYaGenerado

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __divsint
;   __modsint
;   __divsint
;   __modsint
;8 compiler assigned registers:
;   r0x101A
;   STK00
;   r0x101B
;   STK02
;   STK01
;   r0x101C
;   r0x101D
;   r0x101E
;; Starting pCode block
S_bingo__mostrarNumero	code
_mostrarNumero:
; 2 exit points
;	.line	33; "bingo.c"	void mostrarNumero(int numero) {
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
;	.line	34; "bingo.c"	int decenas = numero / 10; // Extraer las decenas
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101B,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
;;1	MOVWF	r0x101C
	MOVF	STK00,W
	BANKSEL	r0x101D
	MOVWF	r0x101D
;	.line	35; "bingo.c"	int unidades = numero % 10; // Extraer las unidades
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101B,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
;	.line	38; "bingo.c"	GP0 = unidades; // Enviar unidades al primer display
	MOVWF	r0x101B
	MOVWF	r0x101E
	RRF	r0x101E,W
	BTFSC	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
_00002_DS_:
	BTFSS	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
_00003_DS_:
;	.line	39; "bingo.c"	GP1 = decenas;  // Enviar decenas al segundo display
	BANKSEL	r0x101D
	MOVF	r0x101D,W
	MOVWF	r0x101B
	RRF	r0x101B,W
	BTFSC	STATUS,0
	GOTO	_00004_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00004_DS_:
	BTFSS	STATUS,0
	GOTO	_00005_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00005_DS_:
;	.line	40; "bingo.c"	}
	RETURN	
; exit point of _mostrarNumero

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __moduint
;   __moduint
;5 compiler assigned registers:
;   STK02
;   STK01
;   STK00
;   r0x101A
;   r0x101B
;; Starting pCode block
S_bingo__generarNumeroAleatorio	code
_generarNumeroAleatorio:
; 2 exit points
;	.line	28; "bingo.c"	contador++;  // Incrementar el contador
	BANKSEL	_contador
	INCF	_contador,F
	BTFSC	STATUS,2
	INCF	(_contador + 1),F
;	.line	29; "bingo.c"	return (contador % 100);  // Retornar un número entre 0 y 99
	MOVLW	0x64
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	_contador,W
	MOVWF	STK00
	MOVF	(_contador + 1),W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
;;1	MOVWF	r0x101B
	MOVWF	STK00
	MOVF	r0x101A,W
;	.line	30; "bingo.c"	}
	RETURN	
; exit point of _generarNumeroAleatorio

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_bingo__initPIC	code
_initPIC:
; 2 exit points
;	.line	18; "bingo.c"	ANSEL = 0x00; // Todos los pines como digitales
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	19; "bingo.c"	TRISIO = 0x20; // GP5 como entrada, otros como salida
	MOVLW	0x20
	MOVWF	_TRISIO
;	.line	20; "bingo.c"	GPIO = 0x00; // Todos los pines en bajo
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	23; "bingo.c"	}
	RETURN	
; exit point of _initPIC


;	code size estimation:
;	  295+   77 =   372 instructions (  898 byte)

	end
