#include <avr/io.h>
#include <util/delay.h>

// Estados de la FSM
enum Estado { ESPERA, CONTANDO, FINALIZADO };

// Configuración inicial de los pines
void setup() {
    // Configurar el pin del botón como entrada con pull-up
    DDRB &= ~(1 << PB0); // Configura PB0 como entrada
    PORTB |= (1 << PB0); // Habilita la resistencia pull-up en PB0

    // Configurar pines PB1 a PB4 para salida BCD como salida
    DDRB |= 0x1E; // Configura PB1, PB2, PB3 y PB4 como salidas
}

// Función para actualizar la salida BCD
void actualizarBCD(uint8_t valor) {
    PORTB = (PORTB & 0xE1) | (valor << 1);
}

int main(void) {
    setup();
    Estado estadoActual = ESPERA;
    uint8_t contador = 0;

    while (1) {
        switch (estadoActual) {
            case ESPERA:
                if (!(PINB & (1 << PB0))) { // Botón presionado
                    _delay_ms(20); // Debouncing
                    while(!(PINB & (1 << PB0))); // Espera a que se suelte el botón
                    estadoActual = CONTANDO;
                    contador = 0;
                }
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

            case FINALIZADO:
                // Aquí puedes expandir el comportamiento posterior
                break;
        }
    }
    return 0;
}
