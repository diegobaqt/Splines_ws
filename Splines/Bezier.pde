class Bezier {
  float[][] points;
  float[][] lines; 
  float[][] merge;
  int grade; 
  float dt;
  int step = 32;
  
  Bezier(float[][] ps, int g){
    dt = 1.0 / (step - 1);    
    points = ps;
    grade = g;
  }
  
  void compute (){
    //System.out.println("Compute");
    if (grade == 3){
      
      stroke(255, 0, 0);
      System.out.println("Bezier Cubica");
      merge = new float[3][3];
      lines = new float[step][3];
      for (int i = 0; i < step; i++){
        lines[i] = PointOnCubicBezier(points, i * dt,4);
        if (i==step-2){
          merge[0] = lines[i];
        }else if (i== step-1){
          break;
        }
        if (i > 0){
          line(lines[i - 1][0], lines[i - 1][1], lines[i - 1][2], lines[i][0], lines[i][1], lines[i][2]);
        }
      }      
      
      merge[1] = points[3];
      lines = new float[step][3];
      for (int i = 0; i < step; i++){
        lines[i] = PointOnCubicBezier(points, i * dt,7);
        if (i > 1){
          line(lines[i - 1][0], lines[i - 1][1], lines[i - 1][2], lines[i][0], lines[i][1], lines[i][2]);
        }else if (i==1){
           merge[2] = lines[i];
        }
      }
      
      //merge      
      merge(); //Bezie 3
      
    }
    else if(grade == 7){
      stroke(255, 0, 255);
      System.out.println("Bezier Grado 7");
      Bezier7(7,points);
    }
  }
  
   void merge(){
   float puntoX = 0, puntoY = 0,puntoZ = 0;      
      float[] previous = new float[3];
      double avance = 1 / ((double) 8);
      for (float t = 0; t <= 1; t += avance) {              
              puntoX = ((1-t)*(1-t)*merge[0][0]) + (2*t*(1-t)*merge[1][0])+(t*t*merge[2][0]);
              puntoY = ((1-t)*(1-t)*merge[0][1]) + (2*t*(1-t)*merge[1][1])+(t*t*merge[2][1]);
              puntoZ = ((1-t)*(1-t)*merge[0][2]) + (2*t*(1-t)*merge[1][2])+(t*t*merge[2][2]);            
          if (t > 0){            
              System.out.println("print x "+puntoX+"y"+puntoY+"z"+puntoZ +" "+ previous[0]+"|"+ previous[1]+"|"+previous[2]);
              line(previous[0], previous[1],previous[2], puntoX,puntoY,puntoZ);
          }
          previous[0] = puntoX; previous[1] = puntoY; previous[2] = puntoZ;           
          puntoX = puntoY = puntoZ =  0;
      }
    }
  
   double calcularB(double u, int n, int k) {//(factorial(n) / (factorial(k) * factorial(n - k)))
        return d(n,k) * Math.pow(u, k) * Math.pow(1 - u, n - k);
    }
    
    double d(int n, int k) {
      int k_p = 1;
      int n_p = 1;
      int n_k = 1;
      for (int i = 2; i <= n; i++) {
          n_p*=i;
          if (i==k) k_p=n_p;
          if (i==(n-k)) n_k=n_p;
      }
      return (n_p)/(k_p*n_k);
    }
    
  void Bezier7(int size, float[][] npoints){
      System.out.println("Bezier Grado "+size);
      float puntoX = 0, puntoY = 0,puntoZ = 0;      
        float[] previous = new float[3];
        double avance = 1 / ((double) step);
        for (double u = 0; u <= 1; u += avance) {   
            for (int k = 0; k < size; k++) {              
                System.out.println("k "+k);
                double b = calcularB(u, size - 1, k);
                puntoX += npoints[k][0] * b;
                puntoY += npoints[k][1] * b;
                puntoZ += npoints[k][2] * b;     
                System.out.println("print x "+puntoX+"y"+puntoY+"z"+puntoZ+" b"+b);
            }            
            if (u > 0){            
                System.out.println("print x "+puntoX+"y"+puntoY+"z"+puntoZ +" "+ previous[0]+"|"+ previous[1]+"|"+previous[2]);
                line(previous[0], previous[1],previous[2], puntoX,puntoY,puntoZ);
            }
            previous[0] = puntoX; previous[1] = puntoY; previous[2] = puntoZ;           
            puntoX = puntoY = puntoZ =  0;
        }        
    }
  
  float[] PointOnCubicBezier(float[][] points, float t, int p){
    float ax, bx, cx;
    float ay, by, cy;
    float az, bz, cz;
    
    cx = 3 * points[p-3][0] - points[p-4][0];
    bx = 3 * (points[p-2][0] - points[p-3][0]) - cx;
    ax = points[p-1][0] - points[p-4][0] - cx - bx;
    
    cy = 3 * points[p-3][1] - points[p-4][1];
    by = 3 * (points[p-2][1] - points[p-3][1]) - cy;
    ay = points[p-1][1] - points[p-4][1] - cy - by;
    
    cz = 3 * points[p-3][2] - points[p-4][2];
    bz = 3 * (points[p-2][2] - points[p-3][2]) - cz;
    az = points[p-1][2] - points[p-4][2] - cz - bz;    
    
    float t2 = t * t;
    float t3 = t2 * t;
    
    float[] array = new float[3];
    array[0] = (ax * t3) + (bx * t2) + (cx * t) + points[p-4][0];
    array[1] = (ay * t3) + (by * t2) + (cy * t) + points[p-4][1];
    array[2] = (az * t3) + (bz * t2) + (cz * t) + points[p-4][2];
    
    return array;
  }
  
  void curve(){
    compute();
  }
}
