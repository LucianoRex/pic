
_Move_Delay:

;PiscaLedComBotao.c,29 :: 		void Move_Delay() { // Function used for text moving
;PiscaLedComBotao.c,30 :: 		Delay_ms(500); // You can change the moving speed here
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Move_Delay0:
	DECFSZ      R13, 1, 1
	BRA         L_Move_Delay0
	DECFSZ      R12, 1, 1
	BRA         L_Move_Delay0
	DECFSZ      R11, 1, 1
	BRA         L_Move_Delay0
	NOP
	NOP
;PiscaLedComBotao.c,31 :: 		}
L_end_Move_Delay:
	RETURN      0
; end of _Move_Delay

_main:

;PiscaLedComBotao.c,33 :: 		void main() {
;PiscaLedComBotao.c,34 :: 		CMCON = 7; //desabilita comparadores   registrador cmcon
	MOVLW       7
	MOVWF       CMCON+0 
;PiscaLedComBotao.c,35 :: 		TRISC = 0x01; //PORTC.RC0 entrada
	MOVLW       1
	MOVWF       TRISC+0 
;PiscaLedComBotao.c,36 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;PiscaLedComBotao.c,37 :: 		TRISB = 0x01; //PORTB.RB0 entrada
	MOVLW       1
	MOVWF       TRISB+0 
;PiscaLedComBotao.c,38 :: 		TRISA = 0b00010000; //PORTB.RB0 entrada
	MOVLW       16
	MOVWF       TRISA+0 
;PiscaLedComBotao.c,39 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;PiscaLedComBotao.c,40 :: 		PORTE = 0x00; // nivel baixo
	CLRF        PORTE+0 
;PiscaLedComBotao.c,41 :: 		PORTC = 0X00;
	CLRF        PORTC+0 
;PiscaLedComBotao.c,42 :: 		PORTA = 0X00;
	CLRF        PORTA+0 
;PiscaLedComBotao.c,43 :: 		ADCON1 = 0x0F; // analogico digital
	MOVLW       15
	MOVWF       ADCON1+0 
;PiscaLedComBotao.c,46 :: 		FAN = 0;
	BCF         PORTC+0, 2 
;PiscaLedComBotao.c,47 :: 		LAMPADA = 0;
	BCF         PORTB+0, 2 
;PiscaLedComBotao.c,48 :: 		CORTINA = 0;
	BCF         PORTA+0, 3 
;PiscaLedComBotao.c,49 :: 		CORTINA2 = 0;
	BCF         PORTB+0, 3 
;PiscaLedComBotao.c,50 :: 		BUZZER = 0;
	BCF         PORTC+0, 1 
;PiscaLedComBotao.c,51 :: 		Lcd_Init(); // Initialize LCD
	CALL        _Lcd_Init+0, 0
;PiscaLedComBotao.c,53 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PiscaLedComBotao.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PiscaLedComBotao.c,56 :: 		Lcd_Out(1, 1, "B1-CORT.");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_PiscaLedComBotao+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_PiscaLedComBotao+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,57 :: 		Lcd_Out(1, 9, "B2-EXAUST.");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_PiscaLedComBotao+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_PiscaLedComBotao+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,58 :: 		Lcd_Out(2, 1, "B3-LAMPADA");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_PiscaLedComBotao+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_PiscaLedComBotao+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,60 :: 		while (1) {
L_main1:
;PiscaLedComBotao.c,61 :: 		if (BTNCORTINA) {
	BTFSS       PORTB+0, 0 
	GOTO        L_main3
;PiscaLedComBotao.c,62 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PiscaLedComBotao.c,64 :: 		CORTINA = ~CORTINA;
	BTG         PORTA+0, 3 
;PiscaLedComBotao.c,65 :: 		CORTINA2 = ~CORTINA2;
	BTG         PORTB+0, 3 
;PiscaLedComBotao.c,66 :: 		BUZZER = ~BUZZER;
	BTG         PORTC+0, 1 
;PiscaLedComBotao.c,67 :: 		Lcd_Out(1, 1, "CORTINA D'AGUA");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_PiscaLedComBotao+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_PiscaLedComBotao+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,68 :: 		Lcd_Out(2, 1, CORTINA ? "LIGADA" : "DESLIGADA");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	BTFSS       PORTA+0, 3 
	GOTO        L_main4
	MOVLW       ?lstr5_PiscaLedComBotao+0
	MOVWF       ?FLOC___mainT29+0 
	MOVLW       hi_addr(?lstr5_PiscaLedComBotao+0)
	MOVWF       ?FLOC___mainT29+1 
	GOTO        L_main5
L_main4:
	MOVLW       ?lstr6_PiscaLedComBotao+0
	MOVWF       ?FLOC___mainT29+0 
	MOVLW       hi_addr(?lstr6_PiscaLedComBotao+0)
	MOVWF       ?FLOC___mainT29+1 
L_main5:
	MOVF        ?FLOC___mainT29+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        ?FLOC___mainT29+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,69 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
;PiscaLedComBotao.c,70 :: 		}
L_main3:
;PiscaLedComBotao.c,72 :: 		if (BTNEXAUSTOR) {
	BTFSS       PORTC+0, 0 
	GOTO        L_main7
;PiscaLedComBotao.c,73 :: 		FAN = ~FAN;
	BTG         PORTC+0, 2 
;PiscaLedComBotao.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PiscaLedComBotao.c,75 :: 		Lcd_Out(1, 1, "EXAUSTOR");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_PiscaLedComBotao+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_PiscaLedComBotao+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,76 :: 		Lcd_Out(2, 1, FAN ? "LIGADO" : "DESLIGADO");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	BTFSS       PORTC+0, 2 
	GOTO        L_main8
	MOVLW       ?lstr8_PiscaLedComBotao+0
	MOVWF       ?FLOC___mainT39+0 
	MOVLW       hi_addr(?lstr8_PiscaLedComBotao+0)
	MOVWF       ?FLOC___mainT39+1 
	GOTO        L_main9
L_main8:
	MOVLW       ?lstr9_PiscaLedComBotao+0
	MOVWF       ?FLOC___mainT39+0 
	MOVLW       hi_addr(?lstr9_PiscaLedComBotao+0)
	MOVWF       ?FLOC___mainT39+1 
L_main9:
	MOVF        ?FLOC___mainT39+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        ?FLOC___mainT39+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,77 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
	DECFSZ      R12, 1, 1
	BRA         L_main10
	DECFSZ      R11, 1, 1
	BRA         L_main10
;PiscaLedComBotao.c,79 :: 		}
L_main7:
;PiscaLedComBotao.c,81 :: 		if (BTNLAMPADA) {
	BTFSS       PORTA+0, 4 
	GOTO        L_main11
;PiscaLedComBotao.c,82 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PiscaLedComBotao.c,83 :: 		Lcd_Out(1, 1, "LAMPADA");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_PiscaLedComBotao+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_PiscaLedComBotao+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,84 :: 		Lcd_Out(2, 1, LAMPADA ? "LIGADA" : "DESLIGADA");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	BTFSS       PORTB+0, 2 
	GOTO        L_main12
	MOVLW       ?lstr11_PiscaLedComBotao+0
	MOVWF       ?FLOC___mainT45+0 
	MOVLW       hi_addr(?lstr11_PiscaLedComBotao+0)
	MOVWF       ?FLOC___mainT45+1 
	GOTO        L_main13
L_main12:
	MOVLW       ?lstr12_PiscaLedComBotao+0
	MOVWF       ?FLOC___mainT45+0 
	MOVLW       hi_addr(?lstr12_PiscaLedComBotao+0)
	MOVWF       ?FLOC___mainT45+1 
L_main13:
	MOVF        ?FLOC___mainT45+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        ?FLOC___mainT45+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PiscaLedComBotao.c,85 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
;PiscaLedComBotao.c,86 :: 		LAMPADA = ~LAMPADA;
	BTG         PORTB+0, 2 
;PiscaLedComBotao.c,93 :: 		}
L_main11:
;PiscaLedComBotao.c,95 :: 		}
	GOTO        L_main1
;PiscaLedComBotao.c,97 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
