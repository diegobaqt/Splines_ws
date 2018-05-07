// Este algoritmo fue adaptado de 
// https://en.wikipedia.org/wiki/Cubic_Hermite_spline y 
// https://people.sc.fsu.edu/~jburkardt/cpp_src/hermite_cubic/hermite_cubic.html

class Natural {
  float[][] points;
  float x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4;
  int size;
  
  Natural(float[][] ps) {
    points = ps;
    size = points.length;
  }
  
  public void makeDraw (){
    stroke(255, 102, 0);
    
    float[][] d = new float[3][8];
    
    for (int i = 0; i < 3; i++) {
      d[i] = calculateSystem(i);
    }

    for (int i = 0; i < size - 1; i++) {
      
      float[] ax = new float[3];
      float[] bx = new float[3];
      float[] cx = new float[3];
      float[] dx = new float[3];
      
      for (int k = 0; k < 3; k++) {
          ax[k] = points[i][k];
          bx[k] = d[k][i];
          cx[k] = 3  *  (points[i+1][k] - points[i][k]) - 2 * d[k][i] - d[k][i+1];
          dx[k] = 2  *  (points[i][k] - points[i+1][k]) + d[k][i] + d[k][i+1];
      }

      float[] prev = new float[]{ points[i][0], points[i][1], points[i][2] };
      float[] p = new float[3];
      int subdivisions = 10;
      
      for (float s = 0; s <= subdivisions; s+=1) {
        float u = s * 1 / subdivisions;
        for (int k = 0; k<3; k++)
          p[k] = (u * u * u * dx[k]+cx[k] * u * u+bx[k] * u+ax[k]);
        line(prev[0], prev[1], prev[2], p[0], p[1], p[2]);
        prev[0] = p[0];
        prev[1] = p[1];
        prev[2] = p[2];
      }
    }
  }
  
  
  float[] calculateSystem (int n) {
    
    float[] a = new float[size];
    float[] b = new float[size];
    float[] c = new float[size];
    float[] d = new float[size];
    
    d[0] = 3  *  (points[1][n]  -  points[0][n]);
    b[0]= 2;
    c[0]= 1;

    b[size - 1] = 2;
    a[size - 1] = 1;
    d[size - 1] = 3 * (points[size - 1][n] - points[size - 2][n]);

    for (int i = 1; i < size - 1; i ++) {
      d[i] = 3  *  (points[i+1][n]  -  points[i - 1][n]);
      a[i] = 1;
      b[i] = 4;
      c[i] = 1;
    }
    
    c[0] = c[0] / b[0];
    d[0] = d[0] / b[0];

    for (int ix = 1; ix < size; ix++) {
      float m = 1. / (b[ix]  -  a[ix]  *  c[ix  -  1]);
      c[ix] = c[ix]  *  m;
      d[ix] = (d[ix]  -  a[ix]  *  d[ix  -  1])  *  m;
    }
    
    for (int ix = size - 2; ix >= 0; ix--)
      d[ix] -= c[ix] * d[ix + 1];

    return d;
  }
  
  void curve() {
    makeDraw();
  }
}   
