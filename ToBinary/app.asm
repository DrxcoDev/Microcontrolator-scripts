; Configuración para PIC16F84A

    list    p=16F84A        ; Especifica el microcontrolador
    #include <app.asm> ; Incluye el archivo de definición para el PIC16F84A

    org     0x0000         ; Dirección de inicio del programa

; Configuración inicial
    bsf     STATUS, RP0    ; Seleccionar el banco 1
    clrf    TRISB           ; Configura todos los pines del puerto B como salida
    bcf     STATUS, RP0    ; Seleccionar el banco 0
    bsf     TRISB, 0       ; Configura RB0 como entrada (pulsador)
    bsf     PORTB, 0       ; Habilita la resistencia pull-up en RB0

loop:
    btfss   PORTB, 0       ; Verifica si el pulsador está presionado
    goto    send_data      ; Si RB0 es 0 (pulsador presionado), salta a send_data
    goto    loop           ; Si no está presionado, vuelve al inicio del bucle

send_data:
    movlw   b'01100001'    ; Cargar el valor binario de 'a' (ASCII 97) en WREG
    movwf   PORTB          ; Enviar el valor de WREG a PORTB

    call    delay_500ms    ; Esperar 500 ms

    clrf    PORTB          ; Apagar el puerto B

    call    delay_100ms    ; Esperar 100 ms

    goto    loop           ; Repetir el bucle

; Rutinas de retardo
delay_500ms:
    movlw   d'250'         ; Cargar 250 en WREG
    movwf   COUNT1         ; Cargar en el primer contador
delay_500ms_loop1:
    movlw   d'250'         ; Cargar 250 en WREG
    movwf   COUNT2         ; Cargar en el segundo contador
delay_500ms_loop2:
    decfsz  COUNT2, f     ; Decrementar COUNT2 y saltar si es 0
    goto    delay_500ms_loop2
    decfsz  COUNT1, f     ; Decrementar COUNT1 y saltar si es 0
    goto    delay_500ms_loop1
    return

delay_100ms:
    movlw   d'50'          ; Cargar 50 en WREG
    movwf   COUNT1         ; Cargar en el primer contador
delay_100ms_loop1:
    movlw   d'250'         ; Cargar 250 en WREG
    movwf   COUNT2         ; Cargar en el segundo contador
delay_100ms_loop2:
    decfsz  COUNT2, f     ; Decrementar COUNT2 y saltar si es 0
    goto    delay_100ms_loop2
    decfsz  COUNT1, f     ; Decrementar COUNT1 y saltar si es 0
    goto    delay_100ms_loop1
    return

    end
