#line 1 "C:/Users/Luciano Rex/Documents/apostilapic/LCDcomMenu/codigo/LCDcomMenu.c"






sbit LCD_RS at RE0_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISE0_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
#line 24 "C:/Users/Luciano Rex/Documents/apostilapic/LCDcomMenu/codigo/LCDcomMenu.c"
typedef struct MenuItem Item;
static void LcdWriteFromROM(const char * texto);

void DefinirSaidas(char);
void AlternarSaidas(char);
void LigarDesligar(char);
void Granalha(char);
void Elevador(char);
void Esteira(char);
void Exaustor(char);
struct MenuItem {
 const Item ** mItem;
 char Texto[16];
 void( * Tarefa)(char);
 char Parms;
};
#line 44 "C:/Users/Luciano Rex/Documents/apostilapic/LCDcomMenu/codigo/LCDcomMenu.c"
static char selecao = 0;
static
const Item ** MenuAtual;
static
const Item ** * MenuAnterior;
static unsigned Stack[16];

unsigned int temp_res;
int voltage;
char voltageTxt[15];
#line 60 "C:/Users/Luciano Rex/Documents/apostilapic/LCDcomMenu/codigo/LCDcomMenu.c"
const Item Menu30 = {
  0 ,
 "PORTD = 32",
 &
 DefinirSaidas,
 32
};

const Item * Screen3[] = {
 &
 Menu30,

 0
};



const Item Menu10 = {
 Screen3,
 "Outra Funcao",
 0,
 0
};
const Item Menu11[] = {
  0 ,
 "JATO",
 &
 Granalha,
 0
};
const Item Menu14[] = {
  0 ,
 "ELEVADOR",
 &
 Elevador,
 0
};
const Item Menu15[] = {
  0 ,
 "EXAUSTOR",
 &
 Exaustor,
 0
};
const Item Menu16[] = {
  0 ,
 "ESTEIRA",
 &
 Esteira,
 0
};
const Item Menu12 = {
  0 ,
 "Alternar Saidas",
 &
 AlternarSaidas,
 0
};
const Item Menu13 = {
  0 ,
 "Desligar Saidas",
 &
 DefinirSaidas,
 0
};

const Item * Screen1[] = {
 &
 Menu11,
 &
 Menu14,
 &
 Menu15,
 &
 Menu16,
 0
};

const Item Menu20 = {
  0 ,
 "Ligar/desligar",
 &
 LigarDesligar,
 1
};
const Item Menu21 = {
  0 ,
 "PORTC = 2",
 &
 DefinirSaidas,
 2
};
const Item Menu22 = {
  0 ,
 "PORTC = 4",
 &
 DefinirSaidas,
 4
};
const Item Menu23 = {
  0 ,
 "PORTC = 8",
 &
 DefinirSaidas,
 8
};
const Item * Screen2[] = {
 &
 Menu20,
 &
 Menu21,
 &
 Menu22,
 &
 Menu23,
 0
};


const Item Menu01 = {
 Screen1,
 "TEMPOS ",
  0 ,
 0
};
const Item Menu02 = {
 Screen2,
 "FUNCAO 2",
  0 ,
 0
};
const Item * TelaInicial[] = {
 &
 Menu01,
 &
 Menu02,
 0
};
#line 202 "C:/Users/Luciano Rex/Documents/apostilapic/LCDcomMenu/codigo/LCDcomMenu.c"
static char MostrarItens(const Item * menu[], char sel) {
 char index = 0, row = 1;

 Lcd_Cmd(_LCD_CLEAR);

 if (menu == 0)
 return 0;

 while (menu[index]) {
 if (index < sel) {
 index++;
 continue;
 }
 if (index == sel) Lcd_Chr(row, 1, '>');
 else Lcd_Chr(row, 1, ' ');
 row++;
 LcdWriteFromROM(menu[index++] -> Texto);
 }

 if (index <= sel)
 return 1;
 return 0;
}

static void LcdWriteFromROM(const char * texto) {
 while ( * texto) {
 Lcd_Chr_CP( * texto++);
 }
}

void main() {

 char flags = 0;

 CMCON = 0x07;
 ADCON0 = 0x00;
 ADCON1 = 0x0E;
 ADCON2 = 0xA9;

 TRISA = 0xFF;
 TRISC = 1;
 TRISB = 1;
 PORTB = 0;
 TRISE = 0x00;
 PORTC = 0;
 EEPROM_Write(0x02,123);
 EEPROM_Write(0x03,124);
 EEPROM_Write(0x04,125);
 EEPROM_Write(0x05,126);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);

 MenuAtual = TelaInicial;
 MenuAnterior = & Stack;

 MostrarItens(MenuAtual, selecao);


 while (1) {

 if ( PORTB.RB0 ) flags.B0 = 1;
 else if ( PORTC.RC0 ) flags.B1 = 1;
 else if ( PORTA.RC4 ) flags.B2 = 1;


 if (! PORTB.RB0  && flags.B0) {
 ++selecao;



 if (MostrarItens(MenuAtual, selecao).B0) {
 selecao = 0;
 MostrarItens(MenuAtual, selecao);
 }
 flags.B0 = 0;
 }


 if (! PORTC.RC0  && flags.B1) {

 void( * Func)(char) = MenuAtual[selecao] -> Tarefa;


 if (Func !=  0 ) {

 Func(MenuAtual[selecao] -> Parms);
 }


 if (MenuAtual[selecao] -> mItem !=  0 ) {

 * MenuAnterior++ = MenuAtual;

 MenuAtual = MenuAtual[selecao] -> mItem;

 selecao = 0;
 MostrarItens(MenuAtual, selecao);
 }

 flags.B1 = 0;
 }


 if (! PORTA.RC4  && flags.B2) {
 selecao = 0;

 if (((unsigned * ) & MenuAnterior)[0] > (unsigned) & Stack) {

 MenuAtual = * --MenuAnterior;
 MostrarItens(MenuAtual, selecao);
 }
 flags.B2 = 0;
 }
 }

}



void DefinirSaidas(char valor) {
 PORTB.RC1 = valor;
}

void AlternarSaidas(char valor) {
 PORTB.RC1 = ~PORTB.RC1;
}
void LigarDesligar(char valor) {
 PORTB.RC1 = ~PORTB.RC1;
}
void Granalha(char valor) {
 * MenuAnterior++ = MenuAtual;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Dados na EEPROM");
 Lcd_Out(2,1,EEPROM_Read(0x02));
 Delay_ms(500);

 while (! PORTA.RC4 ) {
 temp_res = ADC_Read(0);
 voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);
 Lcd_Out(2, 3, "s");

 }


}

void Elevador(char valor) {
 * MenuAnterior++ = MenuAtual;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Dados na EEPROM");
 Lcd_Out(2,1,EEPROM_Read(0x03));
 Delay_ms(500);

 while (! PORTA.RC4 ) {
 temp_res = ADC_Read(0);
 voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);

 Lcd_Out(2, 3, "s");

 }



}

void Esteira(char valor) {
 * MenuAnterior++ = MenuAtual;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Dados na EEPROM");
 Lcd_Out(2,1,EEPROM_Read(0x04));
 Delay_ms(500);

 while (! PORTA.RC4 ) {
 temp_res = ADC_Read(0);
 voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);

 Lcd_Out(2, 3, "s");

 }


}

void Exaustor(char valor) {
 * MenuAnterior++ = MenuAtual;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Dados na EEPROM");
 Lcd_Out(2,1,EEPROM_Read(0x05));
 Delay_ms(500);

 while (! PORTA.RC4 ) {
 temp_res = ADC_Read(0);
 voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);

 Lcd_Out(2, 3, "s");

 }


}
