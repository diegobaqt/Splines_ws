/**
 * Splines.
 *
 * Here we use the interpolator.keyFrames() nodes
 * as control points to render different splines.
 *
 * Press ' ' to change the spline mode.
 * Press 'g' to toggle grid drawing.
 * Press 'c' to toggle the interpolator path drawing.
 */

import frames.input.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

// Global variables
// modes: 
// 0 natural cubic spline; 
// 1 Hermite;
// 2 (degree 7) Bezier; 
// 3 Cubic Bezier
// 4 Catmull Rom

int mode;

Scene scene;
Interpolator interpolator;
OrbitNode eye;
boolean drawGrid = true, drawCtrl = false;


//Choose P3D for a 3D scene, or P2D or JAVA2D for a 2D scene
String renderer = P3D;

void setup() {
  size(800, 800, renderer);
  scene = new Scene(this);
  eye = new OrbitNode(scene);
  eye.setDamping(0);
  scene.setEye(eye);
  scene.setFieldOfView(PI / 3);
  //interactivity defaults to the eye
  scene.setDefaultGrabber(eye);
  scene.setRadius(150);
  scene.fitBallInterpolation();
  interpolator = new Interpolator(scene, new Frame());
  // framesjs next version, simply go:
  //interpolator = new Interpolator(scene);

  // Using OrbitNodes makes path editable
  for (int i = 0; i < 8; i++) {
    Node ctrlPoint = new OrbitNode(scene);
    ctrlPoint.randomize();
    interpolator.addKeyFrame(ctrlPoint);
  }
}

void draw() {
  background(175);
  if (drawGrid) {
    stroke(255, 255, 0);
    scene.drawGrid(200, 50);
  }
  if (drawCtrl) {
    fill(255, 0, 0);
    stroke(255, 0, 255);
    for (Frame frame : interpolator.keyFrames()){
      scene.drawPickingTarget((Node)frame);
    }
      
  } else {
    fill(255, 0, 0);
    stroke(255, 0, 255);
    scene.drawPath(interpolator);
  }
  
  float[][] points = new float[interpolator.keyFrames().size()][3];
  
  for (int i = 0; i < interpolator.keyFrames().size(); i++) {
    Frame f = interpolator.keyFrames().get(i);
    points[i][0] = f.position().x();
    points[i][1] = f.position().y();
    points[i][2] = f.position().z();
  }
  
  if(mode == 0){
    System.out.println("Natural");
    Natural natural = new Natural(points);
    natural.curve();
  } else if(mode == 1){
    System.out.println("Hermite");
    Hermite hermite = new Hermite(points);
    hermite.curve();
  }  else if(mode == 2){
    System.out.println("Bezier 7");
    //Bezier bezier = new Bezier(points, 7);
    //bezier.curve();
  } else if(mode == 3){
    System.out.println("Bezier 3");
    //Bezier bezier = new Bezier(points, 3);
    //bezier.curve();
  } else if(mode == 4){
    System.out.println("Catmull Rom");
    CatmullRom catmull = new CatmullRom(points);
    catmull.curve();
  }
}

void keyPressed() {
  if (key == ' ')
    mode = mode < 5 ? mode+1 : 0;
  if (key == 'g')
    drawGrid = !drawGrid;
  if (key == 'c')
    drawCtrl = !drawCtrl;
}
