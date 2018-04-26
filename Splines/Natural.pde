class Natural {
  float[][] points;
  float x1, x2, x3, x4, y1, y2, y3, y4, z1, z2, z3, z4;
  Natural(float[][] ps) {
    points = ps;
    for (int i = 0; i < ps.length; i++){
      for (int j = 0; j < 3; j++){
        
      }
      if (i == 0){
        x1 = points[i][0];
        y1 = points[i][1];
        z1 = points[i][2];
      } else if (i == ps.length - 1){
        x3 = points[i][0];
        y3 = points[i][1];
        z3 = points[i][2];
      } else if (i == ps.length - 2){
        x4 = points[i][0];
        y4 = points[i][1];
        z4 = points[i][2];
      } else if (i == ps.length / 2){
        x2 = points[i][0];
        y2 = points[i][1];
        z2 = points[i][2];
      }
    }
  }
  
  private float[] solve(int k) {
    float[] a = new float[points.length];
    float[] b = new float[points.length];
    float[] c = new float[points.length];
    float[] d = new float[points.length];
    
    // Setup matrices
    d[0] = 3 * (points[1][k] - points[0][k]);
    b[0]= 2;
    c[0]= 1;

    b[points.length - 1] = 2;
    a[points.length - 1] = 1;
    d[points.length-1] = 3*(points[points.length-1][k]-points[points.length-2][k]);

    for (int i = 1; i<points.length-1; i++) {
      d[i] = 3*(points[i+1][k]-points[i-1][k]);
      a[i] = 1;
      b[i] = 4;
      c[i] = 1;
    }
    
    // Elimination
    c[0] = c[0] / b[0];
    d[0] = d[0] / b[0];

    for (int ix = 1; ix < points.length; ix++) {
      float m = 1. / (b[ix] - a[ix] * c[ix - 1]);
      c[ix] = c[ix] * m;
      d[ix] = (d[ix] - a[ix] * d[ix - 1]) * m;
    }
    
    for (int ix = points.length - 2; ix>=0; ix--)
      d[ix] -= c[ix] * d[ix + 1];

    return d;
  }
  
  
  public void makeDraw (){
    stroke(255, 102, 0);
    //bezier(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4);
    
    float[][] d= new float[3][];
    
    for (int i = 0; i < 3; i++) {
      d[i]=this.solve(i);
    }

    for (int i = 0; i < points.length - 1; i++) {
      float[] ax = new float[3];
      float[] bx = new float[3];
      float[] cx = new float[3];
      float[] dx = new float[3];
      
      for (int k = 0; k < 3; k++) {
          ax[k] = points[i][k];
          bx[k] = d[k][i];
          cx[k] = 3 * (points[i+1][k]-points[i][k])-2*d[k][i]-d[k][i+1];
          dx[k] = 2 * (points[i][k]-points[i+1][k])+d[k][i]+d[k][i+1];
      }

      float[] prev = new float[]{points[i][0], points[i][1], points[i][2]};
      float[] p = new float[3];
      int subdivisions = 10;
      
      for (float s = 0; s <= subdivisions; s+=1) {
        float u = s*1 / subdivisions;
        for (int k = 0; k<3; k++)
          p[k] = (u*u*u*dx[k]+cx[k]*u*u+bx[k]*u+ax[k]);
        line(prev[0], prev[1], prev[2], p[0], p[1], p[2]);
        prev[0] = p[0];
        prev[1] = p[1];
        prev[2] = p[2];
      }
    }
  }
  
  void curve() {
    makeDraw();
  }
}   