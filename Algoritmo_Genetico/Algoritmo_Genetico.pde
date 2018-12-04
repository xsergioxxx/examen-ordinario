PFont f;
int poblacionMax;
float rangoMutacion;
String MiFrase;
Poblacion Poblacion;
 
void setup() {
  MiFrase = "1591158/1545550";
  poblacionMax= 100;
  rangoMutacion = 0.001;
   Poblacion = new Poblacion(MiFrase, rangoMutacion, poblacionMax);
}
 
void draw() {

  Poblacion.naturalSelection();

  Poblacion.generate();

  Poblacion.calcFitness();
  Informacion();

  if (Poblacion.finished()) {
    noLoop();
  }
}
 
void Informacion() {
  String respuesta = Poblacion.getBest();
   println("matriculas ", respuesta);
}
