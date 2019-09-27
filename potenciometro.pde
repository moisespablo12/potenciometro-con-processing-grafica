import processing.serial.*;
Serial Puerto;    // El puerto serial
int xPos = 1;     // Posicion horizontal del grafico
float inByte = 0; // Variable de almacenamiento para la lectura del potenciometro 

void setup () {
  size(400, 300);         // Tamano de la pantalla:
  println(Serial.list()); // Muestra el puerto conectado
  Puerto = new Serial(this, Serial.list()[0], 9600); // En el lugar de [0], debe ir el puerto
  // al que esta conectado el Arduino
  Puerto.bufferUntil('\n'); // Lee el puerto serial hasta encontrar un LF (Line feed)
  background(100);          // Fondo de pantalla
}

void draw () {
  stroke(36,182,237); // Color de la linea, 
  line(xPos, height, xPos, height - inByte); // Dibuja la linea
  if (xPos >= width) { // Verifica que hemos llegado al limite de pantalla
    xPos = 0;          // Reseteo de la posicion a la posicion inicial
    background(100);   // Fondo de pantalla
  } else { 
    xPos++;
  } // Nos movemos en la posicion horizontal
}

void serialEvent (Serial Puerto) {
  String inString = Puerto.readStringUntil('\n'); // Lee la cadena hasta encontrar un enter

  if (inString != null) {
    inString = trim(inString); // Se quita los espacios en blanco:
    inByte = float(inString);  // Convierte en flotante el String leido
    println(inByte);           // Muestra el dato convertido
    inByte = map(inByte, 0, 1023, 0, height); // Convierte el dato en la altura de salida
  }
}
