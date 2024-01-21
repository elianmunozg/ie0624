#include <avr/io.h>
#include <util/delay.h>

enum Estado { ESPERA, CONTANDO, FINALIZADO };
uint8_t tiempoSeleccionado = 0;

void setup() {
    // Configurar los pines de los botones como entrada con pull-up
    DDRB &= ~((1 << PB0) | (1 << PB5) | (1 << PB6) | (1 << PB7));
    PORTB |= (1 << PB0) | (1 << PB5) | (1 << PB6) | (1 << PB7);
    

    // Configurar pines para salida BCD como salida
    DDRB |= 0x1E;
}

void actualizarBCD(uint8_t valor) {
    PORTB = (PORTB & 0xE1) | (valor << 1);
}

void leerBotonesTiempo() {
    if (!(PINB & (1 << PB5))) { tiempoSeleccionado = 3; _delay_ms(20); }
    if (!(PINB & (1 << PB6))) { tiempoSeleccionado = 5; _delay_ms(20); }
    if (!(PINB & (1 << PB7))) { tiempoSeleccionado = 7; _delay_ms(20); }
}

int main(void) {
    setup();
    Estado estadoActual = ESPERA;
    uint8_t contador = 0;

    while (1) {
        leerBotonesTiempo(); // Lee los botones para el tiempo

        switch (estadoActual) {
            case ESPERA:
                if (!(PINB & (1 << PB0)) && tiempoSeleccionado > 0) {
                    while(!(PINB & (1 << PB0))); // Espera a que se suelte el botón
                    estadoActual = CONTANDO;
                    contador = 0;
                }
                break;

            case CONTANDO:
                if (contador < tiempoSeleccionado) {
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
