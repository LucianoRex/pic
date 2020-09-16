#define BTNCORTINA PORTB.RB0
#define BTNEXAUSTOR PORTC.RC0
#define BTNLAMPADA PORTA.RA4

#define CORTINA PORTA.RA3
#define CORTINA2 PORTB.RB3
#define FAN PORTC.RC2
#define LAMPADA PORTB.RB2
#define BUZZER PORTC.RC1

// LCD module connections
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
// End LCD module connections

char i; // Loop variable

void Move_Delay() { // Function used for text moving
  Delay_ms(500); // You can change the moving speed here
}

void main() {
  CMCON = 7; //desabilita comparadores   registrador cmcon
  TRISC = 0x01; //PORTC.RC0 entrada
  TRISE = 0x00;
  TRISB = 0x01; //PORTB.RB0 entrada
  TRISA = 0b00010000; //PORTB.RB0 entrada
  PORTB = 0x00;
  PORTE = 0x00; // nivel baixo
  PORTC = 0X00;
  PORTA = 0X00;
  ADCON1 = 0x0F; // analogico digital
  //INTCON2=0x7F;
  // OUT1=0;
  FAN = 0;
  LAMPADA = 0;
  CORTINA = 0;
  CORTINA2 = 0;
  BUZZER = 0;
  Lcd_Init(); // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR); // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off

  Lcd_Out(1, 1, "B1-CORT.");
  Lcd_Out(1, 9, "B2-EXAUST.");
  Lcd_Out(2, 1, "B3-LAMPADA");

  while (1) {
    if (BTNCORTINA) {
      Lcd_Cmd(_LCD_CLEAR);

      CORTINA = ~CORTINA;
      CORTINA2 = ~CORTINA2;
      BUZZER = ~BUZZER;
      Lcd_Out(1, 1, "CORTINA D'AGUA");
      Lcd_Out(2, 1, CORTINA ? "LIGADA" : "DESLIGADA");
      delay_ms(200);
    }

    if (BTNEXAUSTOR) {
      FAN = ~FAN;
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1, 1, "EXAUSTOR");
      Lcd_Out(2, 1, FAN ? "LIGADO" : "DESLIGADO");
      delay_ms(200);

    }

    if (BTNLAMPADA) {
                Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1, 1, "LAMPADA");
      Lcd_Out(2, 1, LAMPADA ? "LIGADA" : "DESLIGADA");
      delay_ms(200);
       LAMPADA = ~LAMPADA;



      //  LAMPADA=~LAMPADA;
      //                     delay_ms(200);

    }

  }

}