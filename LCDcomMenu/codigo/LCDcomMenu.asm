
LCDcomMenu_MostrarItens:

;LCDcomMenu.c,202 :: 		static char MostrarItens(const Item * menu[], char sel) {
;LCDcomMenu.c,203 :: 		char index = 0, row = 1;
	CLRF        LCDcomMenu_MostrarItens_index_L0+0 
	MOVLW       1
	MOVWF       LCDcomMenu_MostrarItens_row_L0+0 
;LCDcomMenu.c,205 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,207 :: 		if (menu == 0)
	MOVLW       0
	XORWF       FARG_LCDcomMenu_MostrarItens_menu+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDcomMenu_MostrarItens45
	MOVLW       0
	XORWF       FARG_LCDcomMenu_MostrarItens_menu+0, 0 
L_LCDcomMenu_MostrarItens45:
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDcomMenu_MostrarItens0
;LCDcomMenu.c,208 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_MostrarItens
L_LCDcomMenu_MostrarItens0:
;LCDcomMenu.c,210 :: 		while (menu[index]) {
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
;LCDcomMenu.c,211 :: 		if (index < sel) {
	MOVF        FARG_LCDcomMenu_MostrarItens_sel+0, 0 
	SUBWF       LCDcomMenu_MostrarItens_index_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCDcomMenu_MostrarItens3
;LCDcomMenu.c,212 :: 		index++;
	INCF        LCDcomMenu_MostrarItens_index_L0+0, 1 
;LCDcomMenu.c,213 :: 		continue;
	GOTO        L_LCDcomMenu_MostrarItens1
;LCDcomMenu.c,214 :: 		}
L_LCDcomMenu_MostrarItens3:
;LCDcomMenu.c,215 :: 		if (index == sel) Lcd_Chr(row, 1, '>');
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
;LCDcomMenu.c,216 :: 		else Lcd_Chr(row, 1, ' ');
	MOVF        LCDcomMenu_MostrarItens_row_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
L_LCDcomMenu_MostrarItens5:
;LCDcomMenu.c,217 :: 		row++;
	INCF        LCDcomMenu_MostrarItens_row_L0+0, 1 
;LCDcomMenu.c,218 :: 		LcdWriteFromROM(menu[index++] -> Texto);
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
;LCDcomMenu.c,219 :: 		}
	GOTO        L_LCDcomMenu_MostrarItens1
L_LCDcomMenu_MostrarItens2:
;LCDcomMenu.c,221 :: 		if (index <= sel)
	MOVF        LCDcomMenu_MostrarItens_index_L0+0, 0 
	SUBWF       FARG_LCDcomMenu_MostrarItens_sel+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_LCDcomMenu_MostrarItens6
;LCDcomMenu.c,222 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_MostrarItens
L_LCDcomMenu_MostrarItens6:
;LCDcomMenu.c,223 :: 		return 0;
	CLRF        R0 
;LCDcomMenu.c,224 :: 		}
L_end_MostrarItens:
	RETURN      0
; end of LCDcomMenu_MostrarItens

LCDcomMenu_LcdWriteFromROM:

;LCDcomMenu.c,226 :: 		static void LcdWriteFromROM(const char * texto) {
;LCDcomMenu.c,227 :: 		while ( * texto) {
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
;LCDcomMenu.c,228 :: 		Lcd_Chr_CP( * texto++);
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
;LCDcomMenu.c,229 :: 		}
	GOTO        L_LCDcomMenu_LcdWriteFromROM7
L_LCDcomMenu_LcdWriteFromROM8:
;LCDcomMenu.c,230 :: 		}
L_end_LcdWriteFromROM:
	RETURN      0
; end of LCDcomMenu_LcdWriteFromROM

_main:

;LCDcomMenu.c,232 :: 		void main() {
;LCDcomMenu.c,234 :: 		char flags = 0; //flags dos botoes
	CLRF        main_flags_L0+0 
;LCDcomMenu.c,236 :: 		CMCON = 0x07;
	MOVLW       7
	MOVWF       CMCON+0 
;LCDcomMenu.c,237 :: 		ADCON0 = 0x00; //choose analog0
	CLRF        ADCON0+0 
;LCDcomMenu.c,238 :: 		ADCON1 = 0x0E; //RA0 is analog and rest are digital
	MOVLW       14
	MOVWF       ADCON1+0 
;LCDcomMenu.c,239 :: 		ADCON2 = 0xA9; //12 TAD Fosc/8           // configure Timer1
	MOVLW       169
	MOVWF       ADCON2+0 
;LCDcomMenu.c,241 :: 		TRISA = 0xFF; // PORTA is input
	MOVLW       255
	MOVWF       TRISA+0 
;LCDcomMenu.c,242 :: 		TRISC = 1; // PORTC is output
	MOVLW       1
	MOVWF       TRISC+0 
;LCDcomMenu.c,243 :: 		TRISB = 1; // PORTB is output
	MOVLW       1
	MOVWF       TRISB+0 
;LCDcomMenu.c,244 :: 		PORTB = 0;
	CLRF        PORTB+0 
;LCDcomMenu.c,245 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;LCDcomMenu.c,246 :: 		PORTC = 0;
	CLRF        PORTC+0 
;LCDcomMenu.c,247 :: 		EEPROM_Write(0x02,123);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       123
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;LCDcomMenu.c,248 :: 		EEPROM_Write(0x03,124);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       124
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;LCDcomMenu.c,249 :: 		EEPROM_Write(0x04,125);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       125
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;LCDcomMenu.c,250 :: 		EEPROM_Write(0x05,126);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       126
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;LCDcomMenu.c,251 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;LCDcomMenu.c,252 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,254 :: 		MenuAtual = TelaInicial; //A tela atual = tela inicial
	MOVLW       _TelaInicial+0
	MOVWF       LCDcomMenu_MenuAtual+0 
	MOVLW       hi_addr(_TelaInicial+0)
	MOVWF       LCDcomMenu_MenuAtual+1 
;LCDcomMenu.c,255 :: 		MenuAnterior = & Stack; //Aponta para a pilha
	MOVLW       LCDcomMenu_Stack+0
	MOVWF       LCDcomMenu_MenuAnterior+0 
	MOVLW       hi_addr(LCDcomMenu_Stack+0)
	MOVWF       LCDcomMenu_MenuAnterior+1 
;LCDcomMenu.c,257 :: 		MostrarItens(MenuAtual, selecao); //Exibe os itens
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,260 :: 		while (1) {
L_main9:
;LCDcomMenu.c,262 :: 		if (btnProximo) flags.B0 = 1;
	BTFSS       PORTB+0, 0 
	GOTO        L_main11
	BSF         main_flags_L0+0, 0 
	GOTO        L_main12
L_main11:
;LCDcomMenu.c,263 :: 		else if (btnEnter) flags.B1 = 1;
	BTFSS       PORTC+0, 0 
	GOTO        L_main13
	BSF         main_flags_L0+0, 1 
	GOTO        L_main14
L_main13:
;LCDcomMenu.c,264 :: 		else if (btnVoltar) flags.B2 = 1;
	BTFSS       PORTA+0, 4 
	GOTO        L_main15
	BSF         main_flags_L0+0, 2 
L_main15:
L_main14:
L_main12:
;LCDcomMenu.c,267 :: 		if (!btnProximo && flags.B0) {
	BTFSC       PORTB+0, 0 
	GOTO        L_main18
	BTFSS       main_flags_L0+0, 0 
	GOTO        L_main18
L__main43:
;LCDcomMenu.c,268 :: 		++selecao; //seleciona o proximo item
	INCF        LCDcomMenu_selecao+0, 1 
;LCDcomMenu.c,272 :: 		if (MostrarItens(MenuAtual, selecao).B0) {
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
	BTFSS       R0, 0 
	GOTO        L_main19
;LCDcomMenu.c,273 :: 		selecao = 0;
	CLRF        LCDcomMenu_selecao+0 
;LCDcomMenu.c,274 :: 		MostrarItens(MenuAtual, selecao);
	MOVF        LCDcomMenu_MenuAtual+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        LCDcomMenu_MenuAtual+1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	CLRF        FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,275 :: 		}
L_main19:
;LCDcomMenu.c,276 :: 		flags.B0 = 0;
	BCF         main_flags_L0+0, 0 
;LCDcomMenu.c,277 :: 		}
L_main18:
;LCDcomMenu.c,280 :: 		if (!btnEnter && flags.B1) {
	BTFSC       PORTC+0, 0 
	GOTO        L_main22
	BTFSS       main_flags_L0+0, 1 
	GOTO        L_main22
L__main42:
;LCDcomMenu.c,282 :: 		void( * Func)(char) = MenuAtual[selecao] -> Tarefa;
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
;LCDcomMenu.c,285 :: 		if (Func != NULL) {
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main48
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main48
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main48
	MOVF        R1, 0 
	XORLW       0
L__main48:
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;LCDcomMenu.c,287 :: 		Func(MenuAtual[selecao] -> Parms);
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
;LCDcomMenu.c,288 :: 		}
L_main23:
;LCDcomMenu.c,291 :: 		if (MenuAtual[selecao] -> mItem != NULL) {
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
	GOTO        L__main49
	MOVLW       0
	XORWF       R3, 0 
L__main49:
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;LCDcomMenu.c,293 :: 		* MenuAnterior++ = MenuAtual;
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
;LCDcomMenu.c,295 :: 		MenuAtual = MenuAtual[selecao] -> mItem;
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
;LCDcomMenu.c,297 :: 		selecao = 0;
	CLRF        LCDcomMenu_selecao+0 
;LCDcomMenu.c,298 :: 		MostrarItens(MenuAtual, selecao);
	MOVF        R0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        R1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	CLRF        FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,299 :: 		}
L_main24:
;LCDcomMenu.c,301 :: 		flags.B1 = 0;
	BCF         main_flags_L0+0, 1 
;LCDcomMenu.c,302 :: 		}
L_main22:
;LCDcomMenu.c,305 :: 		if (!btnVoltar && flags.B2) {
	BTFSC       PORTA+0, 4 
	GOTO        L_main27
	BTFSS       main_flags_L0+0, 2 
	GOTO        L_main27
L__main41:
;LCDcomMenu.c,306 :: 		selecao = 0;
	CLRF        LCDcomMenu_selecao+0 
;LCDcomMenu.c,308 :: 		if (((unsigned * ) & MenuAnterior)[0] > (unsigned) & Stack) {
	MOVLW       LCDcomMenu_Stack+0
	MOVWF       R1 
	MOVLW       hi_addr(LCDcomMenu_Stack+0)
	MOVWF       R2 
	MOVF        LCDcomMenu_MenuAnterior+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVF        LCDcomMenu_MenuAnterior+0, 0 
	SUBWF       R1, 0 
L__main50:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
;LCDcomMenu.c,310 :: 		MenuAtual = * --MenuAnterior;
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
;LCDcomMenu.c,311 :: 		MostrarItens(MenuAtual, selecao);
	MOVF        R0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+0 
	MOVF        R1, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_menu+1 
	MOVF        LCDcomMenu_selecao+0, 0 
	MOVWF       FARG_LCDcomMenu_MostrarItens_sel+0 
	CALL        LCDcomMenu_MostrarItens+0, 0
;LCDcomMenu.c,312 :: 		}
L_main28:
;LCDcomMenu.c,313 :: 		flags.B2 = 0;
	BCF         main_flags_L0+0, 2 
;LCDcomMenu.c,314 :: 		}
L_main27:
;LCDcomMenu.c,315 :: 		}
	GOTO        L_main9
;LCDcomMenu.c,317 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_DefinirSaidas:

;LCDcomMenu.c,321 :: 		void DefinirSaidas(char valor) {
;LCDcomMenu.c,322 :: 		PORTB.RC1 = valor;
	BTFSC       FARG_DefinirSaidas_valor+0, 0 
	GOTO        L__DefinirSaidas52
	BCF         PORTB+0, 1 
	GOTO        L__DefinirSaidas53
L__DefinirSaidas52:
	BSF         PORTB+0, 1 
L__DefinirSaidas53:
;LCDcomMenu.c,323 :: 		}
L_end_DefinirSaidas:
	RETURN      0
; end of _DefinirSaidas

_AlternarSaidas:

;LCDcomMenu.c,325 :: 		void AlternarSaidas(char valor) {
;LCDcomMenu.c,326 :: 		PORTB.RC1 = ~PORTB.RC1;
	BTG         PORTB+0, 1 
;LCDcomMenu.c,327 :: 		}
L_end_AlternarSaidas:
	RETURN      0
; end of _AlternarSaidas

_LigarDesligar:

;LCDcomMenu.c,328 :: 		void LigarDesligar(char valor) {
;LCDcomMenu.c,329 :: 		PORTB.RC1 = ~PORTB.RC1;
	BTG         PORTB+0, 1 
;LCDcomMenu.c,330 :: 		}
L_end_LigarDesligar:
	RETURN      0
; end of _LigarDesligar

_Granalha:

;LCDcomMenu.c,331 :: 		void Granalha(char valor) {
;LCDcomMenu.c,332 :: 		* MenuAnterior++ = MenuAtual;
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
;LCDcomMenu.c,334 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,335 :: 		Lcd_Out(1, 1, "Dados na EEPROM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,336 :: 		Lcd_Out(2,1,EEPROM_Read(0x02));
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,337 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Granalha29:
	DECFSZ      R13, 1, 1
	BRA         L_Granalha29
	DECFSZ      R12, 1, 1
	BRA         L_Granalha29
	DECFSZ      R11, 1, 1
	BRA         L_Granalha29
	NOP
	NOP
;LCDcomMenu.c,339 :: 		while (!btnVoltar) {
L_Granalha30:
	BTFSC       PORTA+0, 4 
	GOTO        L_Granalha31
;LCDcomMenu.c,340 :: 		temp_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp_res+0 
	MOVF        R1, 0 
	MOVWF       _temp_res+1 
;LCDcomMenu.c,341 :: 		voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
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
;LCDcomMenu.c,342 :: 		FloatToStr(voltage, voltageTxt);
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
;LCDcomMenu.c,343 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;LCDcomMenu.c,344 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,345 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,347 :: 		}
	GOTO        L_Granalha30
L_Granalha31:
;LCDcomMenu.c,350 :: 		}
L_end_Granalha:
	RETURN      0
; end of _Granalha

_Elevador:

;LCDcomMenu.c,352 :: 		void Elevador(char valor) {
;LCDcomMenu.c,353 :: 		* MenuAnterior++ = MenuAtual;
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
;LCDcomMenu.c,354 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,355 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,356 :: 		Lcd_Out(1, 1, "Dados na EEPROM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,357 :: 		Lcd_Out(2,1,EEPROM_Read(0x03));
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,358 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Elevador32:
	DECFSZ      R13, 1, 1
	BRA         L_Elevador32
	DECFSZ      R12, 1, 1
	BRA         L_Elevador32
	DECFSZ      R11, 1, 1
	BRA         L_Elevador32
	NOP
	NOP
;LCDcomMenu.c,360 :: 		while (!btnVoltar) {
L_Elevador33:
	BTFSC       PORTA+0, 4 
	GOTO        L_Elevador34
;LCDcomMenu.c,361 :: 		temp_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp_res+0 
	MOVF        R1, 0 
	MOVWF       _temp_res+1 
;LCDcomMenu.c,362 :: 		voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
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
;LCDcomMenu.c,363 :: 		FloatToStr(voltage, voltageTxt);
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
;LCDcomMenu.c,364 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;LCDcomMenu.c,365 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,367 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,369 :: 		}
	GOTO        L_Elevador33
L_Elevador34:
;LCDcomMenu.c,373 :: 		}
L_end_Elevador:
	RETURN      0
; end of _Elevador

_Esteira:

;LCDcomMenu.c,375 :: 		void Esteira(char valor) {
;LCDcomMenu.c,376 :: 		* MenuAnterior++ = MenuAtual;
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
;LCDcomMenu.c,377 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,378 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,379 :: 		Lcd_Out(1, 1, "Dados na EEPROM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,380 :: 		Lcd_Out(2,1,EEPROM_Read(0x04));
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,381 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Esteira35:
	DECFSZ      R13, 1, 1
	BRA         L_Esteira35
	DECFSZ      R12, 1, 1
	BRA         L_Esteira35
	DECFSZ      R11, 1, 1
	BRA         L_Esteira35
	NOP
	NOP
;LCDcomMenu.c,383 :: 		while (!btnVoltar) {
L_Esteira36:
	BTFSC       PORTA+0, 4 
	GOTO        L_Esteira37
;LCDcomMenu.c,384 :: 		temp_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp_res+0 
	MOVF        R1, 0 
	MOVWF       _temp_res+1 
;LCDcomMenu.c,385 :: 		voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
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
;LCDcomMenu.c,386 :: 		FloatToStr(voltage, voltageTxt);
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
;LCDcomMenu.c,387 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;LCDcomMenu.c,388 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,390 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,392 :: 		}
	GOTO        L_Esteira36
L_Esteira37:
;LCDcomMenu.c,395 :: 		}
L_end_Esteira:
	RETURN      0
; end of _Esteira

_Exaustor:

;LCDcomMenu.c,397 :: 		void Exaustor(char valor) {
;LCDcomMenu.c,398 :: 		* MenuAnterior++ = MenuAtual;
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
;LCDcomMenu.c,399 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,400 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDcomMenu.c,401 :: 		Lcd_Out(1, 1, "Dados na EEPROM");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,402 :: 		Lcd_Out(2,1,EEPROM_Read(0x05));
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,403 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Exaustor38:
	DECFSZ      R13, 1, 1
	BRA         L_Exaustor38
	DECFSZ      R12, 1, 1
	BRA         L_Exaustor38
	DECFSZ      R11, 1, 1
	BRA         L_Exaustor38
	NOP
	NOP
;LCDcomMenu.c,405 :: 		while (!btnVoltar) {
L_Exaustor39:
	BTFSC       PORTA+0, 4 
	GOTO        L_Exaustor40
;LCDcomMenu.c,406 :: 		temp_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp_res+0 
	MOVF        R1, 0 
	MOVWF       _temp_res+1 
;LCDcomMenu.c,407 :: 		voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
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
;LCDcomMenu.c,408 :: 		FloatToStr(voltage, voltageTxt);
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
;LCDcomMenu.c,409 :: 		voltageTxt[2] = 0;
	CLRF        _voltageTxt+2 
;LCDcomMenu.c,410 :: 		Lcd_Out(2, 1, voltageTxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageTxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageTxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,412 :: 		Lcd_Out(2, 3, "s");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_LCDcomMenu+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_LCDcomMenu+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDcomMenu.c,414 :: 		}
	GOTO        L_Exaustor39
L_Exaustor40:
;LCDcomMenu.c,417 :: 		}
L_end_Exaustor:
	RETURN      0
; end of _Exaustor
