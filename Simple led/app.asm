; Configuración del PIC16F84A
    list p=16F84A       ; Especifica el microcontrolador
    #include <p16f84a.inc>

    __CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON

; Declaración de variables
    cblock 0x20         ; Definir el bloque de memoria de registros de uso general
    DelayCounter1       ; Contador para el retardo
    DelayCounter2       ; Segundo contador para el retardo
    endc

; Programa principal
    org 0x00            ; Dirección de inicio del programa
    goto Start

Start:
    ; Configuración del puerto B como salida
    bsf STATUS, RP0     ; Selecciona el banco 1
    clrf TRISB          ; Configura todos los pines del puerto B como salidas
    bcf STATUS, RP0     ; Regresa al banco 0

Loop:
    ; Cambia el estado del LED
    btfss PORTB, 0      ; Comprueba si RB0 está apagado (0)
    goto TurnOff        ; Si RB0 está encendido, apágalo
    goto TurnOn         ; Si RB0 está apagado, enciéndelo

TurnOn:
    bsf PORTB, 0        ; Enciende el LED (RB0 = 1)
    call Delay1Second   ; Llama al retardo de 1 segundo
    goto Loop           ; Repite el ciclo

TurnOff:
    bcf PORTB, 0        ; Apaga el LED (RB0 = 0)
    call Delay1Second   ; Llama al retardo de 1 segundo
    goto Loop           ; Repite el ciclo

; Subrutina de retardo de 1 segundo (aproximado)
Delay1Second:
    movlw d'250'        ; Cargar el valor 250 en W
    movwf DelayCounter1 ; Cargar el primer contador con 250

DelayLoop1:
    movlw d'250'        ; Cargar el valor 250 en W
    movwf DelayCounter2 ; Cargar el segundo contador con 250

DelayLoop2:
    nop                 ; No operación (retardo pequeño)
    nop                 ; No operación (retardo pequeño)
    decfsz DelayCounter2, f ; Decrementa DelayCounter2, salta si es 0
    goto DelayLoop2     ; Repite el segundo bucle

    decfsz DelayCounter1, f ; Decrementa DelayCounter1, salta si es 0
    goto DelayLoop1     ; Repite el primer bucle

    return              ; Regresa de la subrutina de retardo

    end                 ; Fin del programa
