#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // Configuración del pin 0 del puerto B (PB0) como salida
    DDRB |= (1 << PB0);  // Configura PB0 como salida

    while (1) {
        // Encender el LED
        PORTB |= (1 << PB0);
        _delay_ms(1000);  // Retardo de 1 segundo

        // Apagar el LED
        PORTB &= ~(1 << PB0);
        _delay_ms(1000);  // Retardo de 1 segundo
    }

    return 0;
}
