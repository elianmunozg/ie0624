#include <pic14/pic12f683.h>


// Configuración del microcontrolador
__CONFIG(FOSC_INTRCIO & WDTE_OFF & PWRTE_OFF & MCLRE_OFF & CP_OFF & CPD_OFF & BOREN_OFF & IESO_OFF & FCMEN_OFF);

// Prototipos de funciones
void delay(unsigned int tiempo);
void mostrarNumero(unsigned char numero);

// Variables globales
unsigned char numeros[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F}; // Códigos de los números para el display de 7 segmentos
unsigned char contador = 0; // Contador para la generación del número aleatorio

void main(void) {
    unsigned char numeroAleatorio;
    
    TRISIO = 0x00; // Configura todos los pines como salidas
    GPIO = 0x00;   // Pone todos los pines en bajo
    
    while(1) {
        if(GP3) { // Suponiendo que GP3 está conectado al botón
            numeroAleatorio = contador % 100; // Genera un número entre 0 y 99
            mostrarNumero(numeroAleatorio);   // Muestra el número en el display
            contador = 0; // Resetea el contador
        } else {
            contador++; // Incrementa el contador mientras el botón no se presiona
            if(contador == 255) {
                contador = 0; // Evita desbordamiento del contador
            }
        }
        delay(100); // Un pequeño retardo para la estabilidad
    }
}

void mostrarNumero(unsigned char numero) {
    unsigned char decenas = numero / 10;
    unsigned char unidades = numero % 10;
    
   
    GPIO = numeros[decenas]; //  los segmentos están conectados a los pines GPIO<0:6>
    
}

void delay(unsigned int tiempo) {
    unsigned int i;
    for(i = 0; i < tiempo; i++);
}


