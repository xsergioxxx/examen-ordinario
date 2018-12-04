class Poblacion{
 float rangoMutacion;           
  DNA[] Poblacion;            
  ArrayList<DNA> matingPool;    
  String MiFrase;                
  int generaciones;              
  boolean finished;             
int perfectScore;
 
  Poblacion(String p, float m, int num) {
    MiFrase = p;
    rangoMutacion = m;
    Poblacion = new DNA[num];
    for (int i = 0; i < Poblacion.length; i++) {
      Poblacion[i] = new DNA(MiFrase.length());
    }
    calcFitness();
    matingPool = new ArrayList<DNA>();
    finished = false;
    generaciones = 0;
 
    perfectScore = 1;
  }
 

  void calcFitness() {
    for (int i = 0; i < Poblacion.length; i++) {
      Poblacion[i].fitness(MiFrase);
    }
  }
 

  void naturalSelection() {
    // Clear the ArrayList
    matingPool.clear();
 
    float maxFitness = 0;
    for (int i = 0; i < Poblacion.length; i++) {
      if (Poblacion[i].fitness > maxFitness) {
        maxFitness = Poblacion[i].fitness;
      }
    }
 

    for (int i = 0; i < Poblacion.length; i++) {
 
      float fitness = map(Poblacion[i].fitness,0,maxFitness,0,1);
      int n = int(fitness * 100);  
      for (int j = 0; j < n; j++) {             
        matingPool.add(Poblacion[i]);
      }
    }
  }
 

  void generate() {

    for (int i = 0; i < Poblacion.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      DNA partnerA = matingPool.get(a);
      DNA partnerB = matingPool.get(b);
      DNA child = partnerA.crossover(partnerB);
      child.mutate(rangoMutacion);
      Poblacion[i] = child;
    }
    generaciones++;
  }
 

  String getBest() {
    float worldrecord = 0.0f;
    int index = 0;
    for (int i = 0; i < Poblacion.length; i++) {
      if (Poblacion[i].fitness > worldrecord) {
        index = i;
        worldrecord = Poblacion[i].fitness;
      }
    }
 
    if (worldrecord == perfectScore ) finished = true;
    return Poblacion[index].getPhrase();
  }
 
  boolean finished() {
    return finished;
  }
 
  int getGenerations() {
    return generaciones;
  }

  float getAverageFitness() {
    float total = 0;
    for (int i = 0; i < Poblacion.length; i++) {
      total += Poblacion[i].fitness;
    }
    return total / (Poblacion.length);
  }
 
  String allPhrases() {
    String everything = "";
 
    int displayLimit = min(Poblacion.length,50);
 
 
    for (int i = 0; i < displayLimit; i++) {
      everything += Poblacion[i].getPhrase() + "\n";
    }
    return everything;
  }
}
