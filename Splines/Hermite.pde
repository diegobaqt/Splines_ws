// Este algoritmo fue adaptado de 
// https://en.wikipedia.org/wiki/Cubic_Hermite_spline y 
// https://people.sc.fsu.edu/~jburkardt/cpp_src/hermite_cubic/hermite_cubic.html

class Hermite{
  float[][] points;
  int n = 3000; 
  
  public Hermite (float[][] p){
    points = p;
  }
  
  void makeCurve(){
    stroke(0, 0, 255);
    for (int i = 0; i < points.length - 1; i++) {
      float[] p0 = new float[3];
      float[] p1 = new float[3];
      
      for (int j = 0; j < 3; j++) {
        p0[j] = points[i][j];
        p1[j] = points[i+1][j];
      }
      
      float[] m0 = new float[3];
      float[] m1 = new float[3];
            
      for (int j = 0; j < 3; j++) {
        if (i == 0) {
          m0[j] = points[i+1][j] - points[i][j];
          m1[j] = (points[i+2][j] - points[i][j]) / 2;
        } else if (i == points.length - 2) {
          m0[j] = (points[i+1][j] - points[i-1][j]) / 2;
          m1[j] = (points[i+1][j] - points[i][j]);
        } else {
          m0[j] = (points[i+1][j] - points[i-1][j]) / 2;
          m1[j] = (points[i+2][j] - points[i][j]) / 2;
        }
      }

      float[] prior = calcule(i);
      int step;
      
      for (step = 0; step <= n; step++) {
        float t = (float) step / n;
        float[] p = new float[3];
        
        for (int j = 0; j < 3; j++) {
          p[j] = (2 * t * t * t - 3 * t * t + 1) * p0[j] + (t * t * t - 2 * t * t + t) * m0[j] + (-2 * t * t * t + 3 * t * t) * p1[j] + (t * t * t - t * t) * m1[j];
        }
        
        line(prior[0], prior[1], prior[2], p[0], p[1], p[2]);
        prior = p;
      }
    }
  }
  
  float[] calcule (int i){
    float[] p = new float[3];
    for (int j = 0; j < 3; j++) {
      p[j] = points[i][j];
    }
    return p;
  }
      
  void curve(){
    makeCurve();
  }
}





    
