#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// Estados de la FSM
enum Estado { ESPERA, CONTANDO, PAUSADO, FINALIZADO };

// Variable global para rastrear el estado del temporizador
volatile Estado estadoActual = ESPERA;
// Variable global para mantener el contador
volatile uint8_t contador = 0;

// Configuración inicial de los pines
void setup() {
    // Configurar el pin del botón como entrada con pull-up
    DDRD &= ~(1 << PD2); // Configura PD2 como entrada
    PORTD |= (1 << PD2); // Habilita la resistencia pull-up en PD2

    // Configurar pines PB1 a PB4 para salida BCD como salida
    DDRB |= 0x1E; // Configura PB1, PB2, PB3 y PB4 como salidas

    // Configurar INT0 para interrumpir en cualquier cambio de estado
    MCUCR |= (1 << ISC00);
    GIMSK |= (1 << INT0);
    sei(); // Habilita interrupciones globales
}

// ISR para la interrupción externa INT0
ISR(INT0_vect) {
    _delay_ms(20); // Debouncing
    // Evitar que el ISR reaccione a más de un evento por presión de botón
    if ((PINB & (1 << PD2)) == 0) { // Verifica si el botón está realmente presionado
        // Cambiar estado entre PAUSADO y CONTANDO
        if (estadoActual == ESPERA) {
            estadoActual = CONTANDO;
        } else if (estadoActual == CONTANDO) {
            estadoActual = PAUSADO;
        } else if (estadoActual == PAUSADO) {
            estadoActual = CONTANDO;
        }
    }
}

// Función para actualizar la salida BCD
void actualizarBCD(uint8_t valor) {
    PORTB = (PORTB & 0xE1) | (valor << 1);
}


int main(void) {
    setup();
    
    while (1) {
        switch (estadoActual) {
            case ESPERA:
                // El estado inicial es ESPERA y el cambio a CONTANDO se manejará en la ISR
                break;

            case CONTANDO:
                if (contador < 7) {
                    _delay_ms(1000); // Espera 1 segundo
                    contador++;
                    actualizarBCD(contador);
                } else {
                    estadoActual = FINALIZADO;
                }
                break;

            case PAUSADO:
                // No hacer nada mientras el temporizador esté pausado
                break;

            case FINALIZADO:
                // Aquí puedes expandir el comportamiento posterior
                break;
        }
    }
    return 0;
}