
_main:

;codigo.c,19 :: 		void main()
;codigo.c,21 :: 		CMCON = 0x07;
	MOVLW       7
	MOVWF       CMCON+0 
;codigo.c,22 :: 		ADCON0 = 0x01;
	MOVLW       1
	MOVWF       ADCON0+0 
;codigo.c,23 :: 		ADCON1 = 0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;codigo.c,24 :: 		ADCON2 = 0xA6;
	MOVLW       166
	MOVWF       ADCON2+0 
;codigo.c,25 :: 		TRISA = 0xFF; // PORTA is input
	MOVLW       255
	MOVWF       TRISA+0 
;codigo.c,26 :: 		TRISC = 0;    // PORTC is output
	CLRF        TRISC+0 
;codigo.c,27 :: 		TRISB = 1;    // PORTB is output
	MOVLW       1
	MOVWF       TRISB+0 
;codigo.c,28 :: 		PORTB = 0;
	CLRF        PORTB+0 
;codigo.c,29 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;codigo.c,30 :: 		PORTC = 0;
	CLRF        PORTC+0 
;codigo.c,31 :: 		Lcd_Init();               // Initialize LCD
	CALL        _Lcd_Init+0, 0
;codigo.c,32 :: 		Lcd_Cmd(_LCD_CLEAR);      // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;codigo.c,33 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;codigo.c,35 :: 		Lcd_Out(1, 1, "TEMPO (s):");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,37 :: 		do
L_main0:
;codigo.c,39 :: 		temp_res = ADC_Read(0); // Get 10-bit results of AD conversion
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp_res+0 
	MOVF        R1, 0 
	MOVWF       _temp_res+1 
;codigo.c,40 :: 		voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
;codigo.c,41 :: 		FloatToStr(voltage, voltageTxt);
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;codigo.c,42 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;codigo.c,43 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,44 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,45 :: 		if (BTN)
	BTFSS       PORTB+0, 0 
	GOTO        L_main3
;codigo.c,47 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;codigo.c,48 :: 		Lcd_Out(1, 1, "CONTAGEM:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,49 :: 		FloatToStr(voltage, voltageTxt);
	MOVF        _voltage+0, 0 
	MOVWF       R0 
	MOVF        _voltage+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;codigo.c,50 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;codigo.c,51 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,52 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,53 :: 		while (voltage >= 0)
L_main4:
	MOVLW       128
	XORWF       _voltage+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVLW       0
	SUBWF       _voltage+0, 0 
L__main10:
	BTFSS       STATUS+0, 0 
	GOTO        L_main5
;codigo.c,55 :: 		voltage -= 1;
	MOVLW       1
	SUBWF       _voltage+0, 1 
	MOVLW       0
	SUBWFB      _voltage+1, 1 
;codigo.c,56 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;codigo.c,58 :: 		if (voltage <= 0)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _voltage+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main11
	MOVF        _voltage+0, 0 
	SUBLW       0
L__main11:
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;codigo.c,60 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;codigo.c,61 :: 		Lcd_Out(1, 1, "Aviso");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,62 :: 		Lcd_Out(2, 1, "Pronto");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,64 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;codigo.c,65 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
;codigo.c,66 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;codigo.c,67 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;codigo.c,68 :: 		PORTC.RC2 = 0;
	BCF         PORTC+0, 2 
;codigo.c,69 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;codigo.c,70 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,71 :: 		}
L_main7:
;codigo.c,72 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;codigo.c,73 :: 		Lcd_Out(1, 1, "CONTAGEM:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,75 :: 		FloatToStr(voltage, voltageTxt);
	MOVF        _voltage+0, 0 
	MOVWF       R0 
	MOVF        _voltage+1, 0 
	MOVWF       R1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;codigo.c,76 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;codigo.c,77 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,78 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_codigo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_codigo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;codigo.c,79 :: 		}
	GOTO        L_main4
L_main5:
;codigo.c,80 :: 		}
L_main3:
;codigo.c,81 :: 		} while (1);
	GOTO        L_main0
;codigo.c,82 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
