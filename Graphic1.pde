  CircularTrajectory tr;
  
  // Hacer la clase Trajectory y que hereden las otras.
  // Mejorar CircularTrajectory. 
  
  float x1, x2, y1, y2;
  
  void setup() {
    //size (1080, 1920, P3D);
    tr = new CircularTrajectory (width/2, height/2, 300, 0.01, false);
    tr.OnSetup ();
  }
  
  void draw () {
    tr.OnDraw ();
    background (0);
    fill (200, 0, 0);
    ellipse (tr.coord ()[0], tr.coord ()[1], 25, 25);
  }