#include <avr/io.h>
#include <util/delay.h>

#define BUTTON_PIN 2          // Pin al que está conectado el pulsador
#define OUTPUT_PORT PORTD     // Puerto para enviar la representación binaria
#define OUTPUT_DDR DDRD       // Registro de dirección para el puerto de salida

void setup() {
    // Configura el pin del pulsador como entrada
    DDRD &= ~(1 << BUTTON_PIN); // Configura el pin como entrada
    PORTD |= (1 << BUTTON_PIN); // Habilita la resistencia pull-up

    // Configura el puerto D como salida
    OUTPUT_DDR = 0xFF; // Configura todos los pines del puerto D como salida
}

void loop() {
    // Lee el estado del pulsador
    if (!(PIND & (1 << BUTTON_PIN))) { // El pulsador está presionado (resistencia pull-up)
        // Convertir la letra 'a' a binario
        uint8_t value = 'a'; // La letra 'a' tiene el valor ASCII 97, que es 01100001 en binario

        // Enviar la representación binaria a través del puerto D
        OUTPUT_PORT = value;

        _delay_ms(500); // Espera 500 ms
    } else {
        // Apagar el puerto D si el pulsador no está presionado
        OUTPUT_PORT = 0x00;
    }

    _delay_ms(100); // Pequeño retardo para evitar rebotes
}
