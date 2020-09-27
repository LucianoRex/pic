#define NULL 0
#define btnProximo    PORTB.RB0
#define btnEnter PORTC.RC0
#define btnVoltar PORTA.RC4

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

               /*
       PROTOTIPOS
*/
typedef struct MenuItem Item;
static void LcdWriteFromROM( const char* texto );
//Suas Funcoes
void DefinirSaidas( char );
void AlternarSaidas( char );
void LigarDesligar( char);
void Granalha(char);


                           struct MenuItem
{
        const Item** mItem;     //submenu
        char Texto[16];         //texto
        void(*Tarefa)(char);    //Funcao a ser executada
        char Parms;             //valor do parametro da funcao
};

                /*
       VARIAVEIS GLOBAIS
*/
static char selecao = 0;        //posicao do item selecionado
static const Item** MenuAtual;  //Menu Atual
static const Item*** MenuAnterior; //Pilha de Menus
static unsigned Stack[16];      //Aloca memoria para a pilha





/*
       MENU
*/

//Terceiro Nivel
const Item Menu30 = { NULL, "PORTD = 32", &DefinirSaidas, 32 };
const Item GranalhaMenu2 = { NULL, "Tempo Granalha", &Granalha, 32 };
const Item* Screen3[] = { &Menu30, 0 }; //Terminar sempre com o valor 0(NULO)
const Item* GranalhaMenu[] = { &GranalhaMenu2, 0 }; //Terminar sempre com o valor 0(NULO)

//Segundo Nivel
const  Item Menu10 = { Screen3, "Outra Funcao", 0, 0 };
const  Item Menu11 = { NULL, "GRANALHA",&Granalha,0 };
const  Item Menu12 = { NULL, "Alternar Saidas", &AlternarSaidas, 0 };
const  Item Menu13 = { NULL, "Desligar Saidas", &DefinirSaidas, 0 };
const Item* Screen1[] = { &Menu10, &Menu11, &Menu12, &Menu13, 0 };  //Terminar sempre com o valor 0(NULO)

const  Item Menu20 = { NULL, "Ligar/desligar", &LigarDesligar, 1 };
const  Item Menu21 = { NULL, "PORTC = 2", &DefinirSaidas, 2 };
const  Item Menu22 = { NULL, "PORTC = 4", &DefinirSaidas, 4 };
const  Item Menu23 = { NULL, "PORTC = 8", &DefinirSaidas, 8 };
const Item* Screen2[] = { &Menu20, &Menu21, &Menu22, &Menu23, 0 }; //Terminar sempre com o valor 0(NULO)

//Primeiro Nivel
const  Item Menu01 = { Screen1, "DEFINIR TEMPOS", NULL, 0 };
const  Item Menu02 = { Screen2, "FUNCAO 2", NULL, 0 };
const Item* TelaInicial[] = { &Menu01, &Menu02, 0 }; //Terminar sempre com o valor 0(NULO)




/*
      Exibe os items do menu atual no display LCD
*/
static char MostrarItens( const Item* menu[], char sel )
{
char index = 0, row = 1;

     Lcd_Cmd( _LCD_CLEAR );

     if( menu == 0 )
         return 0;

     while( menu[index] )
     {
             if( index < sel ) { index++; continue; }
             if( index == sel ) Lcd_Chr( row, 1, '>' );
             else Lcd_Chr( row, 1, ' ' );
             row++;
             LcdWriteFromROM( menu[index++]->Texto );
     }

     if( index <= sel )
         return 1;
     return 0;
}

static void LcdWriteFromROM( const char* texto )
{
    while( *texto )
    {
           Lcd_Chr_CP( *texto++ );
    }
}



void main()
{
char flags = 0; //flags dos botoes

    CMCON = 7;
    ADCON1 = 15;

    TRISA = 0xFF; // PORTA is input
    TRISC = 1;    // PORTC is output
    TRISB = 1;    // PORTB is output
    PORTB = 0;
    TRISE = 0x00;
    PORTC = 0;

    Lcd_Init();
    Lcd_Cmd( _LCD_CURSOR_OFF );

    MenuAtual = TelaInicial; //A tela atual = tela inicial
    MenuAnterior = &Stack;   //Aponta para a pilha

    MostrarItens( MenuAtual, selecao ); //Exibe os itens

    while( 1 )
    {
         if( btnProximo ) flags.B0 = 1;
         else if( btnEnter ) flags.B1 = 1;
         else if( btnVoltar ) flags.B2 = 1;

         //Botao Proximo foi pressionado
         if( !btnProximo && flags.B0 )
         {
             ++selecao; //seleciona o proximo item
             //Exibe os itens da tela selecionada e
             //se o indice do item estourar
             //retorna para o primeiro item
             if( MostrarItens( MenuAtual, selecao ).B0 )
             {
                  selecao = 0;
                  MostrarItens( MenuAtual, selecao );
             }
             flags.B0 = 0;
         }

         //Botao Enter foi pressionado
         if( !btnEnter && flags.B1 )
         {
             //Recebe o ponteiro da funcao a ser executada
             void(*Func)(char) = MenuAtual[selecao]->Tarefa;


             //Caso exista uma funcao a ser executada...
             if( Func != NULL )
             {
                 //Executa a fun��o
                 Func( MenuAtual[selecao]->Parms );
             }

             //Se existir um submenu
             if( MenuAtual[selecao]->mItem != NULL )
             {
                 //Salva o menu atual no MenuAnteror
                 *MenuAnterior++ = MenuAtual;
                 //atualiza o menu atual com o proximo menu
                 MenuAtual = MenuAtual[selecao]->mItem;
                 //Exibe os itens deste proximo menu
                 selecao = 0;
                 MostrarItens( MenuAtual, selecao );
             }

             flags.B1 = 0;
         }

         //Botao Voltar foi pressionado
         if( !btnVoltar && flags.B2 )
         {
              selecao = 0;
              //Se n�o for o primeiro menu( Tela Inicial )
              if( ((unsigned*)&MenuAnterior)[0] > (unsigned)&Stack )
              {
                 //MenuAtual recebe o menu salvo no MenuAnterior
                 MenuAtual = *--MenuAnterior;
                 MostrarItens( MenuAtual, selecao );
              }
              flags.B2 = 0;
         }
    }

}

//Suas Funcoes

void DefinirSaidas( char valor )
{
    PORTB.RC1 = valor;
}

void AlternarSaidas( char valor )
{
     PORTB.RC1 = ~PORTB.RC1;
}
void LigarDesligar( char valor )
{
     PORTB.RC1 = ~PORTB.RC1;
}
void Granalha( char valor)
{
Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,6,"df");                 // Write text in first row

      PORTC.RC2 = ~PORTC.RC2;
}
