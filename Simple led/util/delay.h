#ifndef _UTIL_DELAY_H_
#define _UTIL_DELAY_H_

#include <avr/io.h>

#define F_CPU 16000000UL  // Frecuencia del reloj del sistema (16 MHz)

// Función para retardo en milisegundos
void _delay_ms(double __ms) {
    uint16_t __ticks;
    double __tmp = ((F_CPU) / 4e3) * __ms;
    __ticks = (uint16_t)__tmp;
    while (__ticks--) {
        _NOP();  // Instrucción de no operación
    }
}

// Función para retardo en microsegundos
void _delay_us(double __us) {
    uint16_t __ticks;
    double __tmp = ((F_CPU) / 4e6) * __us;
    __ticks = (uint16_t)__tmp;
    while (__ticks--) {
        _NOP();  // Instrucción de no operación
    }
}

#endif
