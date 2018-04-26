class Bezier {
  float[][] points;
  float[][] lines;
  int grade; 
  float dt;
  
  Bezier(float[][] ps, int g){
    dt = 1.0 / (16 - 1);    
    points = ps;
    grade = g;
  }
  
  void compute (){
    System.out.println("Compute");
    if (grade == 3){
      lines = new float[16][3];
      for (int i = 0; i < 16; i++){
        lines[i] = PointOnCubicBezier(points, i * dt);
        if (i > 0){
          System.out.println(lines[i - 1][0] + ", "  + lines[i - 1][1]+ ", "  + lines[i - 1][2]+ ", "  + lines[i][0]+ ", "  + lines[i][1]+ ", "  + lines[i][2]);
          stroke(0, 0, 254);
          line(lines[i - 1][0], lines[i - 1][1], lines[i - 1][2], lines[i][0], lines[i][1], lines[i][2]);
        }
      }
    }
  }
  
  float[] PointOnCubicBezier(float[][] points, float t){
    float ax, bx, cx;
    float ay, by, cy;
    float az, bz, cz;
    
    cx = 3 * points[1][0] - points[0][0];
    bx = 3 * (points[2][0] - points[1][0]) - cx;
    ax = points[3][0] - points[0][0] - cx - bx;
    
    cy = 3 * points[1][1] - points[0][1];
    by = 3 * (points[2][1] - points[1][1]) - cy;
    ay = points[3][1] - points[0][1] - cy - by;
    
    cz = 3 * points[1][2] - points[0][2];
    bz = 3 * (points[2][2] - points[1][2]) - cz;
    az = points[3][2] - points[0][2] - cz - bz;    
    
    float t2 = t * t;
    float t3 = t2 * t;
    
    float[] array = new float[3];
    array[0] = (ax * t3) + (bx * t2) + (cx * t) + points[0][0];
    array[1] = (ay * t3) + (by * t2) + (cy * t) + points[0][1];
    array[2] = (az * t3) + (bz * t2) + (cz * t) + points[0][2];
    
    return array;
  }
  
  void curve(){
    compute();
  }
}
