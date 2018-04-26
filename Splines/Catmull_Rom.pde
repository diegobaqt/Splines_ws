class CatmullRom {
  float[][] points;
  
  CatmullRom(float[][] ps) {
    points = ps;
  }
  
  float euclideanDistance(float q, float p){
    return sqrt((float)Math.pow((p-q),2));
  }
  
  float computeX(float x, int i){
    if(i == 0){  //create fictional previous point for first control point
      float xp;
      if(points[0][0] > width / 2)
        xp = points[0][0] - 2 * euclideanDistance(points[1][0], points[0][0]);
      else
        xp = points[0][0] + 2 * euclideanDistance(points[1][0], points[0][0]);
        
      return 0.5 * ((2 * points[i][0]) + ((-xp + points[i + 1][0]) * x)
         +(x*x*(2*xp - 5 * points[i][0] + 4 * points[i + 1][0] - points[i + 2][0]))
         +(x*x*x*(-xp + 3 * points[i][0] - 3 * points[i + 1][0] + points[i + 2][0])));
    } else if(i == 6){ 
       //create fictional next 2 points for las control point
       float  xp2;
       if(points[0][0] > width/2){
         xp2 = points[7][0] - 2 * euclideanDistance(points[7][0], points[6][0]);
           
         return 0.5 * ((2*points[i][0]) + ((-points[i - 1][0] + points[i + 1][0])*x)
         +(x*x*(2*points[i - 1][0] - 5*points[i][0] + 4*points[i + 1][0] - xp2))
         +(x*x*x*(-points[i - 1][0] + 3*points[i][0] - 3*points[i + 1][0] + xp2)));
     } else {
       xp2 =   points[7][0] + 2*euclideanDistance(points[7][0],points[6][0]);
       
       return 0.5*((2*points[i][0]) + ((-points[i - 1][0] + points[i + 1][0])*x)
         +(x*x*(2*points[i - 1][0] - 5*points[i][0] + 4*points[i + 1][0] - xp2))
         +(x*x*x*(-points[i - 1][0] + 3*points[i][0] - 3*points[i + 1][0] + xp2)));
     }
   } else {
       return 0.5*((2*points[i][0]) + ((-points[i - 1][0] + points[i + 1][0])*x)
         +(x*x*(2*points[i - 1][0] - 5*points[i][0] + 4*points[i + 1][0] - points[i + 2][0]))
         +(x*x*x*(-points[i - 1][0] + 3*points[i][0] - 3*points[i + 1][0] + points[i + 2][0])));
   }
  }
  
  float computeY(float x, int i){
       if(i == 0){ //create fictional previous point for first control point
         float yp;
         if(points[0][1] > height/2)
             yp = points[0][1] + 2*euclideanDistance(points[1][1],points[0][1]);
         else
             yp = points[0][1] - 2*euclideanDistance(points[1][1],points[0][1]);
             
         return 0.5*(2*points[i][1]+((-yp + points[i + 1][1])*x)
         +(x*x*(2*yp - 5*points[i][1] + 4*points[i + 1][1] - points[i + 2][1]))
         +(x*x*x*(-yp + 3*points[i][1] - 3*points[i + 1][1] + points[i + 2][1])));
       }
       else if(i == 6){ //create fictional next  point for last control point
         float yp1, yp2;
         if(points[0][1] > height/2){
           yp2 =   points[7][1] - 2*euclideanDistance(points[7][1],points[6][1]);
           
            return 0.5*(2*points[i][1]+((-points[i - 1][1] + points[i + 1][1])*x)
           +(x*x*(2*points[i - 1][1] - 5*points[i][1] + 4*points[i + 1][1] - yp2))
           +(x*x*x*(-points[i - 1][1] + 3*points[i][1] - 3*points[i + 1][1] + yp2)));
         }  
         else{
           yp2 =   points[7][1] + 2*euclideanDistance(points[7][1],points[6][1]);
           
           return 0.5*(2*points[i][1]+((-points[i - 1][1] + points[i + 1][1])*x)
           +(x*x*(2*points[i - 1][1] - 5*points[i][1] + 4*points[i + 1][1] - yp2))
           +(x*x*x*(-points[i - 1][1] + 3*points[i][1] - 3*points[i + 1][1] + yp2)));
         }
         
       }
       else
         return 0.5*(2*points[i][1]+((-points[i - 1][1] + points[i + 1][1])*x)
         +(x*x*(2*points[i - 1][1] - 5*points[i][1] + 4*points[i + 1][1] - points[i + 2][1]))
         +(x*x*x*(-points[i - 1][1] + 3*points[i][1] - 3*points[i + 1][1] + points[i + 2][1])));
       
  }
  
  float computeZ(float x, int i){
       if(i == 0){ //create fictional previous point for first control point
         float zp;
         if(points[0][2] > height/2)
             zp = points[0][2] + 2*euclideanDistance(points[1][2],points[0][2]);
         else
             zp = points[0][2] - 2*euclideanDistance(points[1][2],points[0][2]);
             
         return 0.5*(2*points[i][2]+((-zp + points[i + 1][2])*x)
         +(x*x*(2*zp - 5*points[i][2] + 4*points[i + 1][2] - points[i + 2][2]))
         +(x*x*x*(-zp + 3*points[i][2] - 3*points[i + 1][2] + points[i + 2][2])));
       }
       else if(i == 6){ //create fictional next  point for last control point
         float zp1, zp2;
         if(points[0][2] > height/2){
           zp2 =   points[7][2] - 2*euclideanDistance(points[7][2],points[6][2]);
           
            return 0.5*(2*points[i][2]+((-points[i - 1][2] + points[i + 1][2])*x)
           +(x*x*(2*points[i - 1][2] - 5*points[i][2] + 4*points[i + 1][2] - zp2))
           +(x*x*x*(-points[i - 1][2] + 3*points[i][2] - 3*points[i + 1][2] + zp2)));
         }  
         else{
           zp2 =   points[7][2] + 2*euclideanDistance(points[7][2],points[6][2]);
           
           return 0.5*(2*points[i][2]+((-points[i - 1][2] + points[i + 1][2])*x)
           +(x*x*(2*points[i - 1][2] - 5*points[i][2] + 4*points[i + 1][2] - zp2))
           +(x*x*x*(-points[i - 1][2] + 3*points[i][2] - 3*points[i + 1][2] + zp2)));
         }
         
       }
       else
         return 0.5*(2*points[i][2]+((-points[i - 1][2] + points[i + 1][2])*x)
         +(x*x*(2*points[i - 1][2] - 5*points[i][2] + 4*points[i + 1][2] - points[i + 2][2]))
         +(x*x*x*(-points[i - 1][2] + 3*points[i][2] - 3*points[i + 1][2] + points[i + 2][2])));
       
  }
  
  void makeCurve(){
  //special treatment for first and last control points
  stroke(0, 255, 0);
  for(int i = 0; i < points.length - 1; i++){
    for(float j = 0; j <= 1; j += 0.001){
      line(computeX(j, i), computeY(j, i), computeZ(j, i), computeX(j + 0.001, i), computeY(j + 0.001, i), computeZ(j + 0.001, i));
    }
  }
}  
  

  void compute(){
    makeCurve();   
  }
   
  void curve(){
    compute();
  }
}
