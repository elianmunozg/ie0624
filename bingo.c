#include <pic14/pic12f683.h>

// Configuración de pines
#define BOTON GP5      // Botón conectado al pin GP5
#define UNIDADES GP0   // Pines de salida para las unidades conectados a GP0
#define DECENAS GP1    // Pines de salida para las decenas conectados a GP1


// Variables globales
int numerosGenerados[10]; // Almacena los 10 números únicos
int indiceNumeros = 0;    // Índice para el arreglo de números generados
int contador99 = 0;       // Contador para las veces que se muestra el 99


// Configuración inicial del PIC
void initPIC() {
    // Configuración de pines y modos
    ANSEL = 0x00; // Todos los pines como digitales
    TRISIO = 0x20; // GP5 como entrada, otros como salida
    GPIO = 0x00; // Todos los pines en bajo

    // Configuración de interrupciones, timers, etc.
    // ... (completar según necesidad)
}

unsigned int contador = 0;

int generarNumeroAleatorio() {
    contador++;  // Incrementar el contador
    return (contador % 100);  // Retornar un número entre 0 y 99
}


void mostrarNumero(int numero) {
    int decenas = numero / 10; // Extraer las decenas
    int unidades = numero % 10; // Extraer las unidades

    // Asumiendo que tienes dos sets de pines para cada dígito
    // Por ejemplo, GP0 para las unidades y GP1 para las decenas
    // Envía el valor BCD a los pines correspondientes
    // Nota: Ajusta los nombres de los pines según tu configuración
    GP0 = unidades; // Enviar unidades al primer display
    GP1 = decenas;  // Enviar decenas al segundo display
}
void main() {
    initPIC(); // Inicializar el PIC

    // Inicializar el arreglo de números generados
    for (int i = 0; i < 10; i++) {
        numerosGenerados[i] = -1; // -1 indica que aún no se ha generado el número
    }

    // Bucle principal
    while(1) {
        if (BOTON == 1) { // Suponiendo que 1 es presionado
            int numero;

            if (indiceNumeros < 10) {
                do {
                    numero = generarNumeroAleatorio();
                } while (numeroYaGenerado(numero)); // Verificar si el número ya fue generado

                numerosGenerados[indiceNumeros++] = numero;
            } else if (contador99 < 3) {
                numero = 99;
                contador99++;
            } else {
                // Reiniciar para una nueva secuencia
                indiceNumeros = 0;
                contador99 = 0;
                for (int i = 0; i < 10; i++) {
                    numerosGenerados[i] = -1;
                }
                continue;
            }

            mostrarNumero(numero);
            __delay_ms(500); // Retardo para evitar rebotes del botón
        }
    }
}

// Función para verificar si un número ya fue generado
int numeroYaGenerado(int numero) {
    for (int i = 0; i < 10; i++) {
        if (numerosGenerados[i] == numero) {
            return 1; // Número ya fue generado
        }
    }
    return 0; // Número no ha sido generado
}