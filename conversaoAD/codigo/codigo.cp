#line 1 "C:/Users/Luciano Rex/Documents/apostilapic/conversaoAD/codigo/codigo.c"


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
unsigned int temp_res;
int voltage;
char voltageTxt[15];
void main()
{
 CMCON = 0x07;
 ADCON0 = 0x01;
 ADCON1 = 0x0E;
 ADCON2 = 0xA6;
 TRISA = 0xFF;
 TRISC = 0;
 TRISB = 1;
 PORTB = 0;
 TRISE = 0x00;
 PORTC = 0;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1, 1, "TEMPO (s):");

 do
 {
 temp_res = ADC_Read(0);
 voltage = (((temp_res * 5.00) / 1024) * 60) / 5;
 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);
 Lcd_Out(2, 3, "s");
 if ( PORTB.RB0 )
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "CONTAGEM:");
 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);
 Lcd_Out(2, 3, "s");
 while (voltage >= 0)
 {
 voltage -= 1;
 delay_ms(1000);

 if (voltage <= 0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Aviso");
 Lcd_Out(2, 1, "Pronto");

 PORTC.RC1 = 1;
 PORTC.RC2 = 1;
 delay_ms(1000);
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 1, voltageTxt);
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "CONTAGEM:");

 FloatToStr(voltage, voltageTxt);
 voltageTxt[2] = 0;
 Lcd_Out(2, 1, voltageTxt);
 Lcd_Out(2, 3, "s");
 }
 }
 } while (1);
}
