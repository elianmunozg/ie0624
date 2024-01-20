# Configuración del compilador y opciones
FAMILY=-mpic14
MCU=-p12f683
CC=sdcc
CFLAGS=-I. -I"C:\Program Files\SDCC\non-free\include" --use-non-free

# Nombre del archivo fuente y del objetivo
SRCS=bingo.c
TARGET=bingo

# Regla 'all' para compilar el código
all:
	@echo "Compilando $(SRCS)..."
	$(CC) $(FAMILY) $(MCU) $(CFLAGS) -o $(TARGET).hex $(SRCS)
	@echo "Compilación completada."

# Regla 'clean' para limpiar archivos generados
clean:
	@echo "Limpiando archivos generados..."
	del /Q *.c~ *.h~ *.o *.elf *.hex *.asm *.lst *.cod
	@echo "Limpieza completada."