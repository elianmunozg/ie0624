#include <avr/io.h>
#include <util/delay.h>

enum Estado { ESPERA, CONTANDO, PAUSADO, FINALIZADO };
uint8_t tiempoSeleccionado = 0, contador = 0;
bool temporizadorActivo = false;

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

void verificarBotonInicio(Estado &estadoActual) {
    if (!(PINB & (1 << PB0))) {
        _delay_ms(20); // Debouncing
        while(!(PINB & (1 << PB0))); // Espera a que se suelte el botón

        if (estadoActual == CONTANDO) {
            estadoActual = PAUSADO;
        } else if (estadoActual == PAUSADO || (estadoActual == ESPERA && tiempoSeleccionado > 0)) {
            estadoActual = CONTANDO;
            temporizadorActivo = true;
        }
    }
}

int main(void) {
    setup();
    Estado estadoActual = ESPERA;

    while (1) {
        leerBotonesTiempo();
        verificarBotonInicio(estadoActual);

        switch (estadoActual) {
            case CONTANDO:
                if (contador < tiempoSeleccionado) {
                    _delay_ms(1000); // Espera 1 segundo
                    contador++;
                    actualizarBCD(contador);
                } else {
                    estadoActual = FINALIZADO;
                }
                break;

            case PAUSADO:
                // El temporizador está pausado, no hacer nada
                break;

            case FINALIZADO:
                // Aquí puedes expandir el comportamiento posterior
                temporizadorActivo = false;
                break;
        }
    }
    return 0;
}
