#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// Estados de la FSM
enum Estado { ESPERA, CONFIGURADO, CONTANDO, PAUSADO, FINALIZADO, SEGUNDO_TEMPORIZADOR, SEGUNDO_PAUSADO, TERCER_TEMPORIZADOR, TERCER_PAUSADO, CUARTO_TEMPORIZADOR, CUARTO_PAUSADO };


// Variable global para rastrear el estado del temporizador
volatile enum Estado estadoActual = ESPERA;
// Variables globales para mantener los contadores
volatile uint8_t contador = 0;
volatile uint8_t contadorSegundo = 0;
volatile uint8_t contadorTercero = 0;
volatile uint8_t contadorCuarto = 0;
volatile uint8_t tiempoSeleccionado = 0;
volatile uint8_t tiempoSeleccionadoSegundo = 0;
volatile uint8_t tiempoSeleccionadoTercero = 0;
volatile uint8_t tiempoSeleccionadoCuarto = 0;
// Pin PB0 que nos dará paso a accionar el motor
const uint8_t pinMotor = PB0;
// Define los pines para los LEDs
const uint8_t pinLED = PD1;//Suministro de agua
const uint8_t pinLED2 = PD3;//Lavar
const uint8_t pinLED3 = PD4;//Enjuagar
const uint8_t pinLED4 = PD5;//Centrifugar



void setup() {
    // Configurar el pin del botón como entrada con pull-up
    DDRD &= ~(1 << PD2); // Configura PD2 como entrada
    PORTD |= (1 << PD2); // Habilita la resistencia pull-up en PD2
    DDRB &= ~((1 << PB5) | (1 << PB6) | (1 << PB7)); // Configura PB5, PB6 y PB7 como entradas
    PORTB |= ((1 << PB5) | (1 << PB6) | (1 << PB7)); // Habilita las resistencias pull-up

     // Configura el pin para  como salida y asegura que esté en bajo al inicio
    DDRB |= (1 << pinMotor);
    PORTB &= ~(1 << pinMotor);

     // Configura los pines de los LEDs como salida
    DDRD |= (1 << pinLED);
    PORTD &= ~(1 << pinLED);// Asegura de que el LED esté apagado al inicio
    DDRD |= (1 << pinLED2);
    PORTD &= ~(1 << pinLED2); // Asegura de que el LED esté apagado al inicio
    DDRD |= (1 << pinLED3);
    PORTD &= ~(1 << pinLED3);// Asegura de que el LED esté apagado al inicio
    DDRD |= (1 << pinLED4);
    PORTD &= ~(1 << pinLED4);// Asegura de que el LED esté apagado al inicio
    


    // Configurar pines PB1 a PB4 para salida BCD como salida
    DDRB |= 0x1E; // Configura PB1, PB2, PB3 y PB4 como salidas

    // Configurar INT0 para interrumpir en el flanco de bajada
    MCUCR |= (1 << ISC01);
    GIMSK |= (1 << INT0);
    sei(); // Habilita interrupciones globales
}

// ISR para la interrupción externa INT0, con el fin de poder realizar la acción de pausa 
ISR(INT0_vect) {
    // Debouncing
    _delay_ms(20);
    // Cambiar estado entre PAUSADO y CONTANDO
    if (estadoActual == CONTANDO) {
        estadoActual = PAUSADO;
    } else if (estadoActual == PAUSADO || estadoActual == ESPERA) {
        estadoActual = CONTANDO;
    }

    if (estadoActual == SEGUNDO_TEMPORIZADOR) {
        estadoActual = SEGUNDO_PAUSADO; 
    } else if (estadoActual == SEGUNDO_PAUSADO) {
        estadoActual = SEGUNDO_TEMPORIZADOR;
    }

    if (estadoActual == TERCER_TEMPORIZADOR) {
        estadoActual = TERCER_PAUSADO; 
    } else if (estadoActual == TERCER_PAUSADO) {
        estadoActual = TERCER_TEMPORIZADOR;
    }

    if (estadoActual == CUARTO_TEMPORIZADOR) {
        estadoActual = CUARTO_PAUSADO; 
    } else if (estadoActual == CUARTO_PAUSADO) {
        estadoActual = CUARTO_TEMPORIZADOR;
    }
    
     
    
}
//Funcion para detectar el modo en el que operará la lavadora
void leerBotonesTiempo() {
    if (!(PINB & (1 << PB5))) { _delay_ms(20); tiempoSeleccionado = 1; tiempoSeleccionadoSegundo = 3; tiempoSeleccionadoTercero = 2; tiempoSeleccionadoCuarto = 3;}
    else if (!(PINB & (1 << PB6))) { _delay_ms(20); tiempoSeleccionado = 2; tiempoSeleccionadoSegundo = 5; tiempoSeleccionadoTercero = 4; tiempoSeleccionadoCuarto = 5;}
    else if (!(PINB & (1 << PB7))) { _delay_ms(20); tiempoSeleccionado = 3; tiempoSeleccionadoSegundo = 7; tiempoSeleccionadoTercero = 5; tiempoSeleccionadoCuarto = 6;}
}

// Función para actualizar la salida BCD
void actualizarBCD(uint8_t valor) {
    PORTB = (PORTB & 0xE1) | (valor << 1);
}


int main(void) {
    setup();
    
    while (1) {
        // Solo leer botones si estamos esperando configuración
        if (estadoActual == ESPERA || estadoActual == CONFIGURADO) {
            leerBotonesTiempo();
        }
        
        switch (estadoActual) {
            case ESPERA:
                // Esperar aquí hasta que se seleccione un tiempo
                break;
                
            case CONFIGURADO:
                actualizarBCD(0);
                // Si se ha configurado un tiempo, esperar a que se presione el botón de inicio/pausa
                 
                break;

            case CONTANDO:
                // El primer temporizador está activo y no debe activar el pin del motor.
                if (contador < tiempoSeleccionado) {
                    PORTD |= (1 << pinLED); //Encender el led de suministro de agua
                    _delay_ms(1000); // Espera 1 segundo
                    contador++;
                    actualizarBCD(contador);
                } else {
                    _delay_ms(1000);// Este delay es para que el ultimo segundo se muestre y no pase directamente al siguiente timer 
                    PORTD &= ~(1 << pinLED);
                    estadoActual = SEGUNDO_TEMPORIZADOR;
                    contadorSegundo = 0; // Reinicia el contador del segundo temporizador 
                    actualizarBCD(0);
                    
                }
                break;

            case PAUSADO:
                // El primer temporizador está pausado y el led debe apagarse.
                PORTD &= ~(1 << pinLED);
                break;

             case SEGUNDO_TEMPORIZADOR:
                            
                PORTB |= (1 << pinMotor); // Activa el pin del motor solo cuando el segundo temporizador está contando
                if (contadorSegundo < tiempoSeleccionadoSegundo) {
                    PORTB |= (1 << pinMotor); // Activa el pin del motor solo cuando el segundo temporizador está contando
                    PORTD |= (1 << pinLED2);//Encender el LED correspondiente 
                    _delay_ms(1000); // Espera 1 segundo
                    contadorSegundo++;
                    actualizarBCD(contadorSegundo);
                } else {
                    _delay_ms(1000); // Espera 1 segundo
                    PORTB &= ~(1 << pinMotor); // Detiene el motor
                    PORTD &= ~(1 << pinLED2);//Se apaga el LED
                    PORTB &= ~(1 << pinMotor); // Detiene el motor cuando el segundo temporizador finalice 
                    actualizarBCD(0);

                    estadoActual = TERCER_TEMPORIZADOR;
                }
                break;

            case SEGUNDO_PAUSADO:
                PORTD &= ~(1 << pinLED2);
                PORTB &= ~(1 << pinMotor); // Detiene el "1" lógico si el segundo temporizador está pausado
                break;

            case TERCER_TEMPORIZADOR:
                if (contadorTercero < tiempoSeleccionadoTercero) {
                    PORTB |= (1 << pinMotor); // Activa el motor solo cuando el temporizador está contando
                    PORTD |= (1 << pinLED3);//Encender el LED correspondiente
                    _delay_ms(1000); // Espera 1 segundo
                    contadorTercero++;
                    actualizarBCD(contadorTercero);
                } else {
                    _delay_ms(1000); // Espera 1 segundo
                    PORTD &= ~(1 << pinLED3);//Se apaga el LED
                    PORTB &= ~(1 << pinMotor); // Detiene el motor cuando el temporizador finalice
                    actualizarBCD(0);
                    estadoActual = CUARTO_TEMPORIZADOR;

                }
                break;

            case TERCER_PAUSADO:
                PORTD &= ~(1 << pinLED3);
                PORTB &= ~(1 << pinMotor); // Detiene el motor si se pausa durante el tercer temporizador 
                break;
            
            case CUARTO_TEMPORIZADOR:
                if (contadorCuarto < tiempoSeleccionadoCuarto) {
                    PORTB |= (1 << pinMotor); // Activa el motor mientras el temporizador esté activo
                    PORTD |= (1 << pinLED4);//Encender el LED correspondiente
                    _delay_ms(1000); // Espera 1 segundo
                    contadorCuarto++;
                    actualizarBCD(contadorCuarto);
                } else {
                    _delay_ms(1000); // Espera 1 segundo
                    PORTD &= ~(1 << pinLED4);//Se apaga el LED
                    PORTB &= ~(1 << pinMotor); // Detiene el "1" lógico cuando el segundo temporizador finalice
                    actualizarBCD(0);
                    estadoActual = FINALIZADO;

                }
                break;

            case CUARTO_PAUSADO:
                PORTD &= ~(1 << pinLED4);//Se apaga el LED
                PORTB &= ~(1 << pinMotor); // Detiene el "1" lógico si el segundo temporizador está pausado
                break;



            case FINALIZADO:
                _delay_ms(1000);
                contador = 0;
                contadorSegundo = 0;
                contadorTercero = 0;
                contadorCuarto = 0;


                actualizarBCD(0); // Reinicia el display a 0 cuando ambos temporizadores han terminado
                // Aquí puedes manejar lo que sucede después de que ambos temporizadores hayan terminado
                estadoActual = ESPERA;
                break;
        }
        
        
    }
    return 0;
}

