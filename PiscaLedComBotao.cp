#line 1 "C:/Users/Luciano Rex/Documents/apostilapic/PiscaLedComBotao.c"
#line 12 "C:/Users/Luciano Rex/Documents/apostilapic/PiscaLedComBotao.c"
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


char i;

void Move_Delay() {
 Delay_ms(500);
}

void main() {
 CMCON = 7;
 TRISC = 0x01;
 TRISE = 0x00;
 TRISB = 0x01;
 TRISA = 0b00010000;
 PORTB = 0x00;
 PORTE = 0x00;
 PORTC = 0X00;
 PORTA = 0X00;
 ADCON1 = 0x0F;


  PORTC.RC2  = 0;
  PORTB.RB2  = 0;
  PORTA.RA3  = 0;
  PORTB.RB3  = 0;
  PORTC.RC1  = 0;
 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1, 1, "B1-CORT.");
 Lcd_Out(1, 9, "B2-EXAUST.");
 Lcd_Out(2, 1, "B3-LAMPADA");

 while (1) {
 if ( PORTB.RB0 ) {
 Lcd_Cmd(_LCD_CLEAR);

  PORTA.RA3  = ~ PORTA.RA3 ;
  PORTB.RB3  = ~ PORTB.RB3 ;
  PORTC.RC1  = ~ PORTC.RC1 ;
 Lcd_Out(1, 1, "CORTINA D'AGUA");
 Lcd_Out(2, 1,  PORTA.RA3  ? "LIGADA" : "DESLIGADA");
 delay_ms(200);
 }

 if ( PORTC.RC0 ) {
  PORTC.RC2  = ~ PORTC.RC2 ;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "EXAUSTOR");
 Lcd_Out(2, 1,  PORTC.RC2  ? "LIGADO" : "DESLIGADO");
 delay_ms(200);

 }

 if ( PORTA.RA4 ) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "LAMPADA");
 Lcd_Out(2, 1,  PORTB.RB2  ? "LIGADA" : "DESLIGADA");
 delay_ms(200);
  PORTB.RB2  = ~ PORTB.RB2 ;






 }

 }

}
