
LCDcomMenu_MostrarItens:

;LCDcomMenu.c,86 :: 		static char MostrarItens( const Item* menu[], char sel )
;LCDcomMenu.c,88 :: 		char index = 0, row = 1;
	CLRF        LCDcomMenu_MostrarItens_index_L0+0 
	MOVLW       1
	MOVWF       LCDcomMenu_MostrarItens_row_L0+0 
;LCDcomMenu.c,90 :: 		Lcd_Cmd( _LCD_CLEAR );
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,92 :: 		if( menu == 0 )
	MOVLW       0
	XORWF       FARG_LCDcomMenu_MostrarItens_menu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDcomMenu_MostrarItens33
	MOVLW       0
	XORWF       FARG_LCDcomMenu_MostrarItens_menu+0, 0 
L_LCDcomMenu_MostrarItens33:
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDcomMenu_MostrarItens0
;LCDcomMenu.c,93 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_MostrarItens
L_LCDcomMenu_MostrarItens0:
;LCDcomMenu.c,95 :: 		while( menu[index] )
L_LCDcomMenu_MostrarItens1:
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        LCDcomMenu_MostrarItens_index_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_LCDcomMenu_MostrarItens_menu+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LCDcomMenu_MostrarItens_menu+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	IORWF       POSTINC0+0, 0 
	IORWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDcomMenu_MostrarItens2
;LCDcomMenu.c,97 :: 		if( index < sel ) { index++; continue; }
	MOVF        FARG_LCDcomMenu_MostrarItens_sel+0, 0 
	SUBWF       LCDcomMenu_MostrarItens_index_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCDcomMenu_MostrarItens3
	INCF        LCDcomMenu_MostrarItens_index_L0+0, 1 
	GOTO        L_LCDcomMenu_MostrarItens1
L_LCDcomMenu_MostrarItens3:
;LCDcomMenu.c,98 :: 		if( index == sel ) Lcd_Chr( row, 1, '>' );
	MOVF        LCDcomMenu_MostrarItens_index_L0+0, 0 
	XORWF       FARG_LCDcomMenu_MostrarItens_sel+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDcomMenu_MostrarItens4
	MOVF        LCDcomMenu_MostrarItens_row_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	GOTO        L_LCDcomMenu_MostrarItens5
L_LCDcomMenu_MostrarItens4:
;LCDcomMenu.c,99 :: 		else Lcd_Chr( row, 1, ' ' );
	MOVF        LCDcomMenu_MostrarItens_row_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_LCDcomMenu_MostrarItens5:
;LCDcomMenu.c,100 :: 		row++;
	INCF        LCDcomMenu_MostrarItens_row_L0+0, 1 
;LCDcomMenu.c,101 :: 		LcdWriteFromROM( menu[index++]->Texto );
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        LCDcomMenu_MostrarItens_index_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_LCDcomMenu_MostrarItens_menu+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LCDcomMenu_MostrarItens_menu+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       2
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_LCDcomMenu_LcdWriteFromROM_texto+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       FARG_LCDcomMenu_LcdWriteFromROM_texto+1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       FARG_LCDcomMenu_LcdWriteFromROM_texto+2 
	CALL        LCDcomMenu_LcdWriteFromROM+0, 0
	INCF        LCDcomMenu_MostrarItens_index_L0+0, 1 
;LCDcomMenu.c,102 :: 		}
	GOTO        L_LCDcomMenu_MostrarItens1
L_LCDcomMenu_MostrarItens2:
;LCDcomMenu.c,104 :: 		if( index <= sel )
	MOVF        LCDcomMenu_MostrarItens_index_L0+0, 0 
	SUBWF       FARG_LCDcomMenu_MostrarItens_sel+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_LCDcomMenu_MostrarItens6
;LCDcomMenu.c,105 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_MostrarItens
L_LCDcomMenu_MostrarItens6:
;LCDcomMenu.c,106 :: 		return 0;
	CLRF        R0 
;LCDcomMenu.c,107 :: 		}
L_end_MostrarItens:
	RETURN      0
; end of LCDcomMenu_MostrarItens

LCDcomMenu_LcdWriteFromROM:

;LCDcomMenu.c,109 :: 		static void LcdWriteFromROM( const char* texto )
;LCDcomMenu.c,111 :: 		while( *texto )
L_LCDcomMenu_LcdWriteFromROM7:
	MOVF        FARG_LCDcomMenu_LcdWriteFromROM_texto+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_LCDcomMenu_LcdWriteFromROM_texto+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_LCDcomMenu_LcdWriteFromROM_texto+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDcomMenu_LcdWriteFromROM8
;LCDcomMenu.c,113 :: 		Lcd_Chr_CP( *texto++ );
	MOVF        FARG_LCDcomMenu_LcdWriteFromROM_texto+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_LCDcomMenu_LcdWriteFromROM_texto+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_LCDcomMenu_LcdWriteFromROM_texto+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	MOVLW       1
	ADDWF       FARG_LCDcomMenu_LcdWriteFromROM_texto+0, 1 
	MOVLW       0
	ADDWFC      FARG_LCDcomMenu_LcdWriteFromROM_texto+1, 1 
	ADDWFC      FARG_LCDcomMenu_LcdWriteFromROM_texto+2, 1 
;LCDcomMenu.c,114 :: 		}
	GOTO        L_LCDcomMenu_LcdWriteFromROM7
L_LCDcomMenu_LcdWriteFromROM8:
;LCDcomMenu.c,115 :: 		}
L_end_LcdWriteFromROM:
	RETURN      0
; end of LCDcomMenu_LcdWriteFromROM

_main:

;LCDcomMenu.c,119 :: 		void main()
;LCDcomMenu.c,121 :: 		char flags = 0; //flags dos botoes
	CLRF        main_flags_L0+0 
;LCDcomMenu.c,123 :: 		CMCON = 7;
	MOVLW       7
	MOVWF       CMCON+0 
;LCDcomMenu.c,124 :: 		ADCON1 = 15;
	MOVLW       15
	MOVWF       ADCON1+0 
;LCDcomMenu.c,126 :: 		TRISA = 0xFF; // PORTA is input
	MOVLW       255
	MOVWF       TRISA+0 
;LCDcomMenu.c,127 :: 		TRISC = 1;    // PORTC is output
	MOVLW       1
	MOVWF       TRISC+0 
;LCDcomMenu.c,128 :: 		TRISB = 1;    // PORTB is output
	MOVLW       1
	MOVWF       TRISB+0 
;LCDcomMenu.c,129 :: 		PORTB = 0;
	CLRF        PORTB+0 
;LCDcomMenu.c,130 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;LCDcomMenu.c,131 :: 		PORTC = 0;
	CLRF        PORTC+0 
;LCDcomMenu.c,133 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;LCDcomMenu.c,134 :: 		Lcd_Cmd( _LCD_CURSOR_OFF );
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,136 :: 		MenuAtual = TelaInicial; //A tela atual = tela inicial
	MOVLW       _TelaInicial+0
	MOVWF       LCDcomMenu_MenuAtual+0 
	MOVLW       hi_addr(_TelaInicial+0)
	MOVWF       LCDcomMenu_MenuAtual+1 
;LCDcomMenu.c,137 :: 		MenuAnterior = &Stack;   //Aponta para a pilha
	MOVLW       LCDcomMenu_Stack+0
	MOVWF       LCDcomMenu_MenuAnterior+0 
	MOVLW       hi_addr(LCDcomMenu_Stack+0)
	MOVWF       LCDcomMenu_MenuAnterior+1 
;LCDcomMenu.c,139 :: 		MostrarItens( MenuAtual, selecao ); //Exibe os itens
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,141 :: 		while( 1 )
L_main9:
;LCDcomMenu.c,143 :: 		if( btnProximo ) flags.B0 = 1;
	BTFSS       PORTB+0, 0 
	GOTO        L_main11
	BSF         main_flags_L0+0, 0 
	GOTO        L_main12
L_main11:
;LCDcomMenu.c,144 :: 		else if( btnEnter ) flags.B1 = 1;
	BTFSS       PORTC+0, 0 
	GOTO        L_main13
	BSF         main_flags_L0+0, 1 
	GOTO        L_main14
L_main13:
;LCDcomMenu.c,145 :: 		else if( btnVoltar ) flags.B2 = 1;
	BTFSS       PORTA+0, 4 
	GOTO        L_main15
	BSF         main_flags_L0+0, 2 
L_main15:
L_main14:
L_main12:
;LCDcomMenu.c,148 :: 		if( !btnProximo && flags.B0 )
	BTFSC       PORTB+0, 0 
	GOTO        L_main18
	BTFSS       main_flags_L0+0, 0 
	GOTO        L_main18
L__main31:
;LCDcomMenu.c,150 :: 		++selecao; //seleciona o proximo item
	INCF        LCDcomMenu_selecao+0, 1 
;LCDcomMenu.c,154 :: 		if( MostrarItens( MenuAtual, selecao ).B0 )
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
	BTFSS       R0, 0 
	GOTO        L_main19
;LCDcomMenu.c,156 :: 		selecao = 0;
	CLRF        LCDcomMenu_selecao+0 
;LCDcomMenu.c,157 :: 		MostrarItens( MenuAtual, selecao );
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	CLRF        FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,158 :: 		}
L_main19:
;LCDcomMenu.c,159 :: 		flags.B0 = 0;
	BCF         main_flags_L0+0, 0 
;LCDcomMenu.c,160 :: 		}
L_main18:
;LCDcomMenu.c,163 :: 		if( !btnEnter && flags.B1 )
	BTFSC       PORTC+0, 0 
	GOTO        L_main22
	BTFSS       main_flags_L0+0, 1 
	GOTO        L_main22
L__main30:
;LCDcomMenu.c,166 :: 		void(*Func)(char) = MenuAtual[selecao]->Tarefa;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       18
	ADDWF       POSTINC0+0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	TBLRD*+
	MOVFF       TABLAT+0, R2
	TBLRD*+
	MOVFF       TABLAT+0, R3
	TBLRD*+
	MOVFF       TABLAT+0, R4
	MOVF        R1, 0 
	MOVWF       main_Func_L2+0 
	MOVF        R2, 0 
	MOVWF       main_Func_L2+1 
	MOVF        R3, 0 
	MOVWF       main_Func_L2+2 
	MOVF        R4, 0 
	MOVWF       main_Func_L2+3 
;LCDcomMenu.c,170 :: 		if( Func != NULL )
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVF        R1, 0 
	XORLW       0
L__main36:
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;LCDcomMenu.c,173 :: 		Func( MenuAtual[selecao]->Parms );
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       22
	ADDWF       POSTINC0+0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       TBLPTR+2 
	MOVF        main_Func_L2+2, 0 
	MOVWF       FSR1+0 
	MOVF        main_Func_L2+3, 0 
	MOVWF       FSR1+1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        main_Func_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Func_L2+1, 0 
	MOVWF       R1 
	CALL        _____DoIFC+0, 0
;LCDcomMenu.c,174 :: 		}
L_main23:
;LCDcomMenu.c,177 :: 		if( MenuAtual[selecao]->mItem != NULL )
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        R1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        R2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	TBLRD*+
	MOVFF       TABLAT+0, R4
	MOVLW       0
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       0
	XORWF       R3, 0 
L__main37:
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;LCDcomMenu.c,180 :: 		*MenuAnterior++ = MenuAtual;
	MOVFF       LCDcomMenu_MenuAnterior+0, FSR1L+0
	MOVFF       LCDcomMenu_MenuAnterior+1, FSR1H+0
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       2
	ADDWF       LCDcomMenu_MenuAnterior+0, 1 
	MOVLW       0
	ADDWFC      LCDcomMenu_MenuAnterior+1, 1 
;LCDcomMenu.c,182 :: 		MenuAtual = MenuAtual[selecao]->mItem;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        R1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        R2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R0, 0 
	MOVWF       LCDcomMenu_MenuAtual+0 
	MOVF        R1, 0 
	MOVWF       LCDcomMenu_MenuAtual+1 
;LCDcomMenu.c,184 :: 		selecao = 0;
	CLRF        LCDcomMenu_selecao+0 
;LCDcomMenu.c,185 :: 		MostrarItens( MenuAtual, selecao );
	MOVF        R0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        R1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	CLRF        FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,186 :: 		}
L_main24:
;LCDcomMenu.c,188 :: 		flags.B1 = 0;
	BCF         main_flags_L0+0, 1 
;LCDcomMenu.c,189 :: 		}
L_main22:
;LCDcomMenu.c,192 :: 		if( !btnVoltar && flags.B2 )
	BTFSC       PORTA+0, 4 
	GOTO        L_main27
	BTFSS       main_flags_L0+0, 2 
	GOTO        L_main27
L__main29:
;LCDcomMenu.c,194 :: 		selecao = 0;
	CLRF        LCDcomMenu_selecao+0 
;LCDcomMenu.c,196 :: 		if( ((unsigned*)&MenuAnterior)[0] > (unsigned)&Stack )
	MOVLW       LCDcomMenu_Stack+0
	MOVWF       R1 
	MOVLW       hi_addr(LCDcomMenu_Stack+0)
	MOVWF       R2 
	MOVF        LCDcomMenu_MenuAnterior+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        LCDcomMenu_MenuAnterior+0, 0 
	SUBWF       R1, 0 
L__main38:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
;LCDcomMenu.c,199 :: 		MenuAtual = *--MenuAnterior;
	MOVLW       2
	SUBWF       LCDcomMenu_MenuAnterior+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      LCDcomMenu_MenuAnterior+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       LCDcomMenu_MenuAnterior+0 
	MOVF        R1, 0 
	MOVWF       LCDcomMenu_MenuAnterior+1 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       LCDcomMenu_MenuAtual+0 
	MOVF        R1, 0 
	MOVWF       LCDcomMenu_MenuAtual+1 
;LCDcomMenu.c,200 :: 		MostrarItens( MenuAtual, selecao );
	MOVF        R0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        R1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,201 :: 		}
L_main28:
;LCDcomMenu.c,202 :: 		flags.B2 = 0;
	BCF         main_flags_L0+0, 2 
;LCDcomMenu.c,203 :: 		}
L_main27:
;LCDcomMenu.c,204 :: 		}
	GOTO        L_main9
;LCDcomMenu.c,206 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_DefinirSaidas:

;LCDcomMenu.c,210 :: 		void DefinirSaidas( char valor )
;LCDcomMenu.c,212 :: 		PORTB.RC1 = valor;
	BTFSC       FARG_DefinirSaidas_valor+0, 0 
	GOTO        L__DefinirSaidas40
	BCF         PORTB+0, 1 
	GOTO        L__DefinirSaidas41
L__DefinirSaidas40:
	BSF         PORTB+0, 1 
L__DefinirSaidas41:
;LCDcomMenu.c,213 :: 		}
L_end_DefinirSaidas:
	RETURN      0
; end of _DefinirSaidas

_AlternarSaidas:

;LCDcomMenu.c,215 :: 		void AlternarSaidas( char valor )
;LCDcomMenu.c,217 :: 		PORTB.RC1 = ~PORTB.RC1;
	BTG         PORTB+0, 1 
;LCDcomMenu.c,218 :: 		}
L_end_AlternarSaidas:
	RETURN      0
; end of _AlternarSaidas

_LigarDesligar:

;LCDcomMenu.c,219 :: 		void LigarDesligar( char valor )
;LCDcomMenu.c,221 :: 		PORTB.RC1 = ~PORTB.RC1;
	BTG         PORTB+0, 1 
;LCDcomMenu.c,222 :: 		}
L_end_LigarDesligar:
	RETURN      0
; end of _LigarDesligar

_Granalha:

;LCDcomMenu.c,223 :: 		void Granalha( char valor)
;LCDcomMenu.c,225 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,226 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,227 :: 		Lcd_Out(1,6,"df");                 // Write text in first row
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,229 :: 		PORTC.RC2 = ~PORTC.RC2;
	BTG         PORTC+0, 2 
;LCDcomMenu.c,230 :: 		}
L_end_Granalha:
	RETURN      0
; end of _Granalha
