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
	extern	__moduint
	extern	__mulint
	extern	_ANSEL
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_parpadearNumero9
	global	_generarYMostrarNumeros
	global	_reiniciarNumerosGenerados
	global	_delay_ms
	global	_numeroYaGenerado
	global	_mostrarNumeroBCD
	global	_generarNumeroAleatorio
	global	_initPIC
	global	_seed
	global	_contador9
	global	_contador
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
r0x101B	res	1
r0x101A	res	1
r0x101C	res	1
r0x101D	res	1
r0x101E	res	1
r0x101F	res	1
r0x1020	res	1
r0x1021	res	1
r0x1022	res	1
r0x1023	res	1
r0x1029	res	1
r0x1028	res	1
r0x102B	res	1
r0x102A	res	1
r0x1024	res	1
r0x1025	res	1
r0x1027	res	1
r0x1026	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_bingo_0	idata
_indiceNumeros
	db	0x00, 0x00	;  0


IDD_bingo_1	idata
_contador
	db	0x00, 0x00	; 0


IDD_bingo_2	idata
_contador9
	db	0x00, 0x00	;  0


IDD_bingo_3	idata
_seed
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
;   _reiniciarNumerosGenerados
;   _generarNumeroAleatorio
;   _numeroYaGenerado
;   __mulint
;   _mostrarNumeroBCD
;   _delay_ms
;   _parpadearNumero9
;   _delay_ms
;   _reiniciarNumerosGenerados
;   _initPIC
;   _reiniciarNumerosGenerados
;   _generarNumeroAleatorio
;   _numeroYaGenerado
;   __mulint
;   _mostrarNumeroBCD
;   _delay_ms
;   _parpadearNumero9
;   _delay_ms
;   _reiniciarNumerosGenerados
;7 compiler assigned registers:
;   r0x1024
;   r0x1025
;   STK00
;   r0x1026
;   r0x1027
;   STK02
;   STK01
;; Starting pCode block
S_bingo__main	code
_main:
; 2 exit points
;	.line	89; "bingo.c"	initPIC();
	PAGESEL	_initPIC
	CALL	_initPIC
	PAGESEL	$
;	.line	90; "bingo.c"	reiniciarNumerosGenerados();
	PAGESEL	_reiniciarNumerosGenerados
	CALL	_reiniciarNumerosGenerados
	PAGESEL	$
_00243_DS_:
;	.line	93; "bingo.c"	if (BOTON == 1) { // Verificar si el botón es presionado
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
	GOTO	_00236_DS_
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
;	.line	94; "bingo.c"	if (indiceNumeros < 10) {
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00275_DS_
	MOVLW	0x0a
	SUBWF	_indiceNumeros,W
_00275_DS_:
	BTFSC	STATUS,0
	GOTO	_00236_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
_00230_DS_:
;	.line	97; "bingo.c"	numero = generarNumeroAleatorio();
	PAGESEL	_generarNumeroAleatorio
	CALL	_generarNumeroAleatorio
	PAGESEL	$
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVF	STK00,W
;	.line	98; "bingo.c"	} while (numeroYaGenerado(numero));
	MOVWF	r0x1024
	MOVWF	STK00
	MOVF	r0x1025,W
	PAGESEL	_numeroYaGenerado
	CALL	_numeroYaGenerado
	PAGESEL	$
	BANKSEL	r0x1026
	MOVWF	r0x1026
	MOVF	STK00,W
	MOVWF	r0x1027
	IORWF	r0x1026,W
	BTFSS	STATUS,2
	GOTO	_00230_DS_
;	.line	100; "bingo.c"	numerosGenerados[indiceNumeros++] = numero;
	BANKSEL	_indiceNumeros
	MOVF	_indiceNumeros,W
	BANKSEL	r0x1027
	MOVWF	r0x1027
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	BANKSEL	r0x1026
	MOVWF	r0x1026
	BANKSEL	_indiceNumeros
	INCF	_indiceNumeros,F
	BTFSC	STATUS,2
	INCF	(_indiceNumeros + 1),F
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	MOVWF	STK02
	MOVF	r0x1026,W
	MOVWF	STK01
	MOVLW	0x02
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__mulint
	CALL	__mulint
	PAGESEL	$
	BANKSEL	r0x1026
	MOVWF	r0x1026
	MOVF	STK00,W
	MOVWF	r0x1027
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x1027
	MOVF	r0x1026,W
	BTFSC	STATUS,0
	INCFSZ	r0x1026,W
	ADDLW	high (_numerosGenerados + 0)
	MOVWF	r0x1026
	MOVF	r0x1027,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1026
	BTFSC	r0x1026,0
	BSF	STATUS,7
	MOVF	r0x1024,W
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	BANKSEL	r0x1025
	MOVF	r0x1025,W
	BANKSEL	INDF
	MOVWF	INDF
;	.line	101; "bingo.c"	mostrarNumeroBCD(numero);
	BANKSEL	r0x1024
	MOVF	r0x1024,W
	MOVWF	STK00
	MOVF	r0x1025,W
	PAGESEL	_mostrarNumeroBCD
	CALL	_mostrarNumeroBCD
	PAGESEL	$
;	.line	102; "bingo.c"	delay_ms(2000); // Mostrar el número durante 2 segundos
	MOVLW	0xd0
	MOVWF	STK00
	MOVLW	0x07
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
_00236_DS_:
;	.line	107; "bingo.c"	if (indiceNumeros >= 10 && contador9 < 3) {
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00276_DS_
	MOVLW	0x0a
	SUBWF	_indiceNumeros,W
_00276_DS_:
	BTFSS	STATUS,0
	GOTO	_00243_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;;signed compare: left < lit(0x3=3), size=2, mask=ffff
	BANKSEL	_contador9
	MOVF	(_contador9 + 1),W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00277_DS_
	MOVLW	0x03
	SUBWF	_contador9,W
_00277_DS_:
	BTFSC	STATUS,0
	GOTO	_00243_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	108; "bingo.c"	parpadearNumero9();
	PAGESEL	_parpadearNumero9
	CALL	_parpadearNumero9
	PAGESEL	$
;	.line	109; "bingo.c"	contador9++;
	BANKSEL	_contador9
	INCF	_contador9,F
	BTFSC	STATUS,2
	INCF	(_contador9 + 1),F
;;signed compare: left < lit(0x3=3), size=2, mask=ffff
;	.line	110; "bingo.c"	if (contador9 >= 3) {
	MOVF	(_contador9 + 1),W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00278_DS_
	MOVLW	0x03
	SUBWF	_contador9,W
_00278_DS_:
	BTFSS	STATUS,0
	GOTO	_00243_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	111; "bingo.c"	delay_ms(1000); // Esperar un poco antes de reiniciar
	MOVLW	0xe8
	MOVWF	STK00
	MOVLW	0x03
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	112; "bingo.c"	reiniciarNumerosGenerados();
	PAGESEL	_reiniciarNumerosGenerados
	CALL	_reiniciarNumerosGenerados
	PAGESEL	$
	GOTO	_00243_DS_
;	.line	116; "bingo.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _mostrarNumeroBCD
;   _delay_ms
;   _delay_ms
;   _mostrarNumeroBCD
;   _delay_ms
;   _delay_ms
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_bingo__parpadearNumero9	code
_parpadearNumero9:
; 2 exit points
;	.line	82; "bingo.c"	mostrarNumeroBCD(9);
	MOVLW	0x09
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_mostrarNumeroBCD
	CALL	_mostrarNumeroBCD
	PAGESEL	$
;	.line	83; "bingo.c"	delay_ms(1000); // Encendido durante 500 ms
	MOVLW	0xe8
	MOVWF	STK00
	MOVLW	0x03
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	84; "bingo.c"	GPIO &= 0xF0;  // Apagar GP0-GP3
	MOVLW	0xf0
	BANKSEL	_GPIO
	ANDWF	_GPIO,F
;	.line	85; "bingo.c"	delay_ms(500); // Apagado durante 500 ms
	MOVLW	0xf4
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	86; "bingo.c"	}
	RETURN	
; exit point of _parpadearNumero9

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _generarNumeroAleatorio
;   _numeroYaGenerado
;   _generarNumeroAleatorio
;   __mulint
;   _mostrarNumeroBCD
;   _delay_ms
;   _generarNumeroAleatorio
;   _numeroYaGenerado
;   _generarNumeroAleatorio
;   __mulint
;   _mostrarNumeroBCD
;   _delay_ms
;7 compiler assigned registers:
;   r0x1028
;   STK00
;   r0x1029
;   r0x102A
;   r0x102B
;   STK02
;   STK01
;; Starting pCode block
S_bingo__generarYMostrarNumeros	code
_generarYMostrarNumeros:
; 2 exit points
;	.line	72; "bingo.c"	int numero = generarNumeroAleatorio();
	PAGESEL	_generarNumeroAleatorio
	CALL	_generarNumeroAleatorio
	PAGESEL	$
	BANKSEL	r0x1028
	MOVWF	r0x1028
	MOVF	STK00,W
	MOVWF	r0x1029
_00219_DS_:
;	.line	73; "bingo.c"	while (numeroYaGenerado(numero)) {
	BANKSEL	r0x1029
	MOVF	r0x1029,W
	MOVWF	STK00
	MOVF	r0x1028,W
	PAGESEL	_numeroYaGenerado
	CALL	_numeroYaGenerado
	PAGESEL	$
	BANKSEL	r0x102A
	MOVWF	r0x102A
	MOVF	STK00,W
	MOVWF	r0x102B
	IORWF	r0x102A,W
	BTFSC	STATUS,2
	GOTO	_00221_DS_
;	.line	74; "bingo.c"	numero = generarNumeroAleatorio();
	PAGESEL	_generarNumeroAleatorio
	CALL	_generarNumeroAleatorio
	PAGESEL	$
	BANKSEL	r0x1028
	MOVWF	r0x1028
	MOVF	STK00,W
	MOVWF	r0x1029
	GOTO	_00219_DS_
_00221_DS_:
;	.line	76; "bingo.c"	numerosGenerados[indiceNumeros++] = numero;
	BANKSEL	_indiceNumeros
	MOVF	_indiceNumeros,W
	BANKSEL	r0x102B
	MOVWF	r0x102B
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	BANKSEL	r0x102A
	MOVWF	r0x102A
	BANKSEL	_indiceNumeros
	INCF	_indiceNumeros,F
	BTFSC	STATUS,2
	INCF	(_indiceNumeros + 1),F
	BANKSEL	r0x102B
	MOVF	r0x102B,W
	MOVWF	STK02
	MOVF	r0x102A,W
	MOVWF	STK01
	MOVLW	0x02
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__mulint
	CALL	__mulint
	PAGESEL	$
	BANKSEL	r0x102A
	MOVWF	r0x102A
	MOVF	STK00,W
	MOVWF	r0x102B
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x102B
	MOVF	r0x102A,W
	BTFSC	STATUS,0
	INCFSZ	r0x102A,W
	ADDLW	high (_numerosGenerados + 0)
	MOVWF	r0x102A
	MOVF	r0x102B,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x102A
	BTFSC	r0x102A,0
	BSF	STATUS,7
	MOVF	r0x1029,W
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	BANKSEL	r0x1028
	MOVF	r0x1028,W
	BANKSEL	INDF
	MOVWF	INDF
;	.line	77; "bingo.c"	mostrarNumeroBCD(numero);
	BANKSEL	r0x1029
	MOVF	r0x1029,W
	MOVWF	STK00
	MOVF	r0x1028,W
	PAGESEL	_mostrarNumeroBCD
	CALL	_mostrarNumeroBCD
	PAGESEL	$
;	.line	78; "bingo.c"	delay_ms(1000);
	MOVLW	0xe8
	MOVWF	STK00
	MOVLW	0x03
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	79; "bingo.c"	}
	RETURN	
; exit point of _generarYMostrarNumeros

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;6 compiler assigned registers:
;   r0x101A
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;   r0x101F
;; Starting pCode block
S_bingo__reiniciarNumerosGenerados	code
_reiniciarNumerosGenerados:
; 2 exit points
;	.line	64; "bingo.c"	for (int i = 0; i < 10; i++) {
	BANKSEL	r0x101A
	CLRF	r0x101A
	CLRF	r0x101B
	CLRF	r0x101C
	CLRF	r0x101D
;;signed compare: left < lit(0xA=10), size=2, mask=ffff
_00201_DS_:
	BANKSEL	r0x101B
	MOVF	r0x101B,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00214_DS_
	MOVLW	0x0a
	SUBWF	r0x101A,W
_00214_DS_:
	BTFSC	STATUS,0
	GOTO	_00199_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	65; "bingo.c"	numerosGenerados[i] = -1;
	BANKSEL	r0x101C
	MOVF	r0x101C,W
	ADDLW	(_numerosGenerados + 0)
	MOVWF	r0x101E
	MOVLW	high (_numerosGenerados + 0)
	MOVWF	r0x101F
	MOVF	r0x101D,W
	BTFSC	STATUS,0
	INCFSZ	r0x101D,W
	ADDWF	r0x101F,F
	MOVF	r0x101E,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x101F
	BTFSC	r0x101F,0
	BSF	STATUS,7
	MOVLW	0xff
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	MOVLW	0xff
	MOVWF	INDF
;	.line	64; "bingo.c"	for (int i = 0; i < 10; i++) {
	MOVLW	0x02
	BANKSEL	r0x101C
	ADDWF	r0x101C,F
	BTFSC	STATUS,0
	INCF	r0x101D,F
	INCF	r0x101A,F
	BTFSC	STATUS,2
	INCF	r0x101B,F
	GOTO	_00201_DS_
_00199_DS_:
;	.line	67; "bingo.c"	indiceNumeros = 0;
	BANKSEL	_indiceNumeros
	CLRF	_indiceNumeros
	CLRF	(_indiceNumeros + 1)
;	.line	68; "bingo.c"	contador9 = 0;
	BANKSEL	_contador9
	CLRF	_contador9
	CLRF	(_contador9 + 1)
;	.line	69; "bingo.c"	}
	RETURN	
; exit point of _reiniciarNumerosGenerados

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x101A
;   STK00
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;   r0x101F
;   r0x1020
;   r0x1021
;; Starting pCode block
S_bingo__delay_ms	code
_delay_ms:
; 2 exit points
;	.line	56; "bingo.c"	void delay_ms(unsigned int milliseconds) {
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
;	.line	58; "bingo.c"	for (i = 0; i < milliseconds; i++) {
	CLRF	r0x101C
	CLRF	r0x101D
_00173_DS_:
	BANKSEL	r0x101A
	MOVF	r0x101A,W
	SUBWF	r0x101D,W
	BTFSS	STATUS,2
	GOTO	_00194_DS_
	MOVF	r0x101B,W
	SUBWF	r0x101C,W
_00194_DS_:
	BTFSC	STATUS,0
	GOTO	_00175_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	59; "bingo.c"	for (j = 0; j < 200; j++) { }
	MOVLW	0xc8
	BANKSEL	r0x101E
	MOVWF	r0x101E
	CLRF	r0x101F
_00171_DS_:
	MOVLW	0xff
	BANKSEL	r0x101E
	ADDWF	r0x101E,W
	MOVWF	r0x1020
	MOVLW	0xff
	MOVWF	r0x1021
	MOVF	r0x101F,W
	BTFSC	STATUS,0
	INCFSZ	r0x101F,W
	ADDWF	r0x1021,F
	MOVF	r0x1020,W
	MOVWF	r0x101E
	MOVF	r0x1021,W
	MOVWF	r0x101F
	MOVF	r0x1021,W
	IORWF	r0x1020,W
	BTFSS	STATUS,2
	GOTO	_00171_DS_
;	.line	58; "bingo.c"	for (i = 0; i < milliseconds; i++) {
	INCF	r0x101C,F
	BTFSC	STATUS,2
	INCF	r0x101D,F
	GOTO	_00173_DS_
_00175_DS_:
;	.line	61; "bingo.c"	}
	RETURN	
; exit point of _delay_ms

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
;	.line	47; "bingo.c"	int numeroYaGenerado(int numero) {
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
;	.line	48; "bingo.c"	for (int i = 0; i < indiceNumeros; i++) {
	CLRF	r0x101C
	CLRF	r0x101D
	CLRF	r0x101E
	CLRF	r0x101F
_00146_DS_:
	BANKSEL	r0x101D
	MOVF	r0x101D,W
	ADDLW	0x80
	MOVWF	r0x1020
	BANKSEL	_indiceNumeros
	MOVF	(_indiceNumeros + 1),W
	ADDLW	0x80
	BANKSEL	r0x1020
	SUBWF	r0x1020,W
	BTFSS	STATUS,2
	GOTO	_00162_DS_
	BANKSEL	_indiceNumeros
	MOVF	_indiceNumeros,W
	BANKSEL	r0x101C
	SUBWF	r0x101C,W
_00162_DS_:
	BTFSC	STATUS,0
	GOTO	_00144_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	49; "bingo.c"	if (numerosGenerados[i] == numero) {
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
	GOTO	_00147_DS_
	MOVF	r0x101A,W
	XORWF	r0x1023,W
	BTFSS	STATUS,2
	GOTO	_00147_DS_
;	.line	50; "bingo.c"	return 1;
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	GOTO	_00148_DS_
_00147_DS_:
;	.line	48; "bingo.c"	for (int i = 0; i < indiceNumeros; i++) {
	MOVLW	0x02
	BANKSEL	r0x101E
	ADDWF	r0x101E,F
	BTFSC	STATUS,0
	INCF	r0x101F,F
	INCF	r0x101C,F
	BTFSC	STATUS,2
	INCF	r0x101D,F
	GOTO	_00146_DS_
_00144_DS_:
;	.line	53; "bingo.c"	return 0;
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x00
_00148_DS_:
;	.line	54; "bingo.c"	}
	RETURN	
; exit point of _numeroYaGenerado

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;4 compiler assigned registers:
;   r0x101A
;   STK00
;   r0x101B
;   r0x101C
;; Starting pCode block
S_bingo__mostrarNumeroBCD	code
_mostrarNumeroBCD:
; 2 exit points
;	.line	28; "bingo.c"	void mostrarNumeroBCD(int numeroBCD) {
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
;	.line	32; "bingo.c"	GPIO &= 0xF0; // Mantener GP0, GP1, GP2 y GP4 en bajo (0)
	MOVLW	0xf0
	BANKSEL	_GPIO
	ANDWF	_GPIO,F
;;signed compare: left < lit(0x0=0), size=2, mask=ffff
;	.line	34; "bingo.c"	if (numeroBCD >= 0 && numeroBCD <= 9) {
	BSF	STATUS,0
	BANKSEL	r0x101A
	BTFSS	r0x101A,7
	BCF	STATUS,0
	BTFSC	STATUS,0
	GOTO	_00118_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;;swapping arguments (AOP_TYPEs 1/2)
;;signed compare: left >= lit(0xA=10), size=2, mask=ffff
	MOVF	r0x101A,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00132_DS_
	MOVLW	0x0a
	SUBWF	r0x101B,W
_00132_DS_:
	BTFSC	STATUS,0
	GOTO	_00118_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	36; "bingo.c"	GPIO |= (numeroBCD & 0x07); 
	BANKSEL	r0x101B
	MOVF	r0x101B,W
	MOVWF	r0x101C
	MOVLW	0x07
	ANDWF	r0x101C,F
	MOVF	r0x101C,W
	BANKSEL	_GPIO
	IORWF	_GPIO,F
;;signed compare: left < lit(0x8=8), size=2, mask=ffff
;	.line	39; "bingo.c"	if (numeroBCD >= 8) {
	BANKSEL	r0x101A
	MOVF	r0x101A,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00133_DS_
	MOVLW	0x08
	SUBWF	r0x101B,W
_00133_DS_:
	BTFSS	STATUS,0
	GOTO	_00118_DS_
;;genSkipc:3307: created from rifx:00000000047A5780
;	.line	40; "bingo.c"	GPIO |= (1 << GP4);
	BANKSEL	r0x101B
	CLRF	r0x101B
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,4
	GOTO	_00002_DS_
	BANKSEL	r0x101B
	INCF	r0x101B,F
_00002_DS_:
	BANKSEL	r0x101B
	MOVF	r0x101B,W
	MOVWF	r0x101A
	MOVLW	0x01
	MOVWF	r0x101B
	MOVF	r0x101A,W
	BTFSC	r0x101A,7
	GOTO	_00137_DS_
	SUBLW	0x00
	BTFSC	STATUS,2
	GOTO	_00135_DS_
_00134_DS_:
	BANKSEL	r0x101B
	RLF	r0x101B,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00134_DS_
	GOTO	_00135_DS_
_00137_DS_:
	BCF	STATUS,0
	BANKSEL	r0x101B
	BTFSC	r0x101B,7
	BSF	STATUS,0
	RRF	r0x101B,F
	ADDLW	0x01
	BTFSS	STATUS,0
	GOTO	_00137_DS_
_00135_DS_:
	BANKSEL	_GPIO
	MOVF	_GPIO,W
	BANKSEL	r0x101A
	MOVWF	r0x101A
	IORWF	r0x101B,W
	BANKSEL	_GPIO
	MOVWF	_GPIO
_00118_DS_:
;	.line	43; "bingo.c"	}
	RETURN	
; exit point of _mostrarNumeroBCD

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __mulint
;   __moduint
;   __mulint
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
;	.line	21; "bingo.c"	seed = seed + 1;  // Incrementa la semilla
	BANKSEL	_seed
	INCF	_seed,F
	BTFSC	STATUS,2
	INCF	(_seed + 1),F
;	.line	22; "bingo.c"	return (seed * 32719 + 3) % 10;  // Genera un número entre 0 y 9
	MOVF	_seed,W
	MOVWF	STK02
	MOVF	(_seed + 1),W
	MOVWF	STK01
	MOVLW	0xcf
	MOVWF	STK00
	MOVLW	0x7f
	PAGESEL	__mulint
	CALL	__mulint
	PAGESEL	$
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
	MOVLW	0x03
	ADDWF	r0x101B,F
	BTFSC	STATUS,0
	INCF	r0x101A,F
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101B,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVF	STK00,W
	MOVWF	r0x101B
	MOVWF	STK00
	MOVF	r0x101A,W
;	.line	23; "bingo.c"	}
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
;	.line	15; "bingo.c"	ANSEL = 0x00;
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	16; "bingo.c"	TRISIO = 0x20;
	MOVLW	0x20
	MOVWF	_TRISIO
;	.line	17; "bingo.c"	GPIO = 0x00;
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	18; "bingo.c"	}
	RETURN	
; exit point of _initPIC


;	code size estimation:
;	  438+  130 =   568 instructions ( 1396 byte)

	end
