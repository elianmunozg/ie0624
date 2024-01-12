# Configuración del compilador y opciones
FAMILY=-mpic14
MCU=-p12f683
CC=sdcc
CFLAGS=-I. -I/usr/local/share/sdcc/non-free/include --use-non-free

# Nombre del archivo fuente y del objetivo
SRCS= bingo.c
TARGET=bingo

# Regla 'all' para compilar el código
all:
	$(CC) $(FAMILY) $(MCU) $(CFLAGS) -o $(TARGET).hex $(SRCS)

# Regla 'clean' para limpiar archivos generados
clean:
	rm -f *.c~ *.h~ *.o *.elf *.hex *.asm *.lst *.cod
