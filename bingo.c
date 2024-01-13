#include <pic14/pic12f683.h>

// Configuración de pines
#define BOTON GP5          // Botón conectado al pin GP5
#define SALIDA_BCD GP0_GP4 // Pines de salida BCD conectados a GP0 a GP3

// Variables globales
int numerosGenerados[10];
int indiceNumeros = 0;
unsigned int contador = 0;
int contador9 = 0;
unsigned int seed = 0;  // Semilla para la generación de números pseudoaleatorios

void initPIC() {
    ANSEL = 0x00;
    TRISIO = 0x20;
    GPIO = 0x00;
}

int generarNumeroAleatorio() {
    seed = seed + 1;  // Incrementa la semilla
    return (seed * 32719 + 3) % 10;  // Genera un número entre 0 y 9
}




void mostrarNumeroBCD(int numeroBCD) {
    // Asumiendo que GP0, GP1, GP2 y GP4 están conectados para representar el BCD de 4 bits (bits 0, 1, 2 y 4).

    // Apagar todos los pines inicialmente
    GPIO &= 0xF0; // Mantener GP0, GP1, GP2 y GP4 en bajo (0)

    if (numeroBCD >= 0 && numeroBCD <= 9) {
        // Asignar los 3 bits menos significativos de BCD a GP0, GP1 y GP2
        GPIO |= (numeroBCD & 0x07); 

        // Asignar el bit más significativo de BCD a GP4
        if (numeroBCD >= 8) {
            GPIO |= (1 << GP4);
        }
    }
}



int numeroYaGenerado(int numero) {
    for (int i = 0; i < indiceNumeros; i++) {
        if (numerosGenerados[i] == numero) {
            return 1;
        }
    }
    return 0;
}

void delay_ms(unsigned int milliseconds) {
    unsigned int i, j;
    for (i = 0; i < milliseconds; i++) {
        for (j = 0; j < 200; j++) { }
    }
}

void reiniciarNumerosGenerados() {
    for (int i = 0; i < 10; i++) {
        numerosGenerados[i] = -1;
    }
    indiceNumeros = 0;
    contador9 = 0;
}

void generarYMostrarNumeros() {
    int numero = generarNumeroAleatorio();
    while (numeroYaGenerado(numero)) {
        numero = generarNumeroAleatorio();
    }
    numerosGenerados[indiceNumeros++] = numero;
    mostrarNumeroBCD(numero);
    delay_ms(1000);
}

void parpadearNumero9() {
    mostrarNumeroBCD(9);
    delay_ms(1000); // Encendido durante 500 ms
    GPIO &= 0xF0;  // Apagar GP0-GP3
    delay_ms(500); // Apagado durante 500 ms
}

void main() {
    initPIC();
    reiniciarNumerosGenerados();

    while(1) {
        if (BOTON == 1) { // Verificar si el botón es presionado
            if (indiceNumeros < 10) {
                int numero;
                do {
                    numero = generarNumeroAleatorio();
                } while (numeroYaGenerado(numero));

                numerosGenerados[indiceNumeros++] = numero;
                mostrarNumeroBCD(numero);
                delay_ms(2000); // Mostrar el número durante 2 segundos
            }
        }

        // Iniciar el parpadeo del 9 una vez que se han mostrado 10 números
        if (indiceNumeros >= 10 && contador9 < 3) {
            parpadearNumero9();
            contador9++;
            if (contador9 >= 3) {
                delay_ms(1000); // Esperar un poco antes de reiniciar
                reiniciarNumerosGenerados();
            }
        }
    }
}
