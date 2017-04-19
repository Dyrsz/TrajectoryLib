  LinealTrajectory2D tr1, tr2, tr3, tr4;
  CompTrajectory ctr1, ctr2;
  Trajectory[] trs1, trs2;
  CircularTrajectory cctr1;
  
  // CompTrajectory2D;
  // Hacer la clase PolygonTrajectory
  // Probar la construcción circ. tg 
  
  float x1, x2, y1, y2;
  
  float ax = 500;
  float ay = 400;
  float bx = 1000;
  float by = 900;
  float cx = 600;
  float cy = 900;
  float dx = 300;
  float dy = 800;
  float ex = 100;
  float ey = 300;
  
  void setup() {
    //size (1080, 1920, P3D);
    tr1 = new LinealTrajectory2D (ax, ay, bx, by, 0.01, true);
    cctr1 = new CircularTrajectory (true, bx, by, bx-ax, by-ay, cx, cy, dx-cx, dy-cy, 0.01, true);
    tr3 = new LinealTrajectory2D (cx, cy, dx, dy, 0.01, true);
    tr4 = new LinealTrajectory2D (dx, dy, ex, ey, 0.01, true);  
    
    Trajectory [] trs1 = {tr1, cctr1, tr3, tr4};
    //LinealTrajectory2D [] trs2 = {tr3, tr4};
    ctr1 = new CompTrajectory (trs1, 0.01, true);
    //ctr2 = new CompLinTrajectory2D (trs2, 0.01, true);
  }
  
  void draw () {
    ctr1.OnDraw ();
    background (0);
    
    fill (0, 200, 0);
    ellipse (ax, ay, 25, 25);
    ellipse (cx, cy, 25, 25);
    ellipse (ex, ey, 25, 25);
    fill (0, 0, 200);
    ellipse (bx, by, 25, 25);
    ellipse (dx, dy, 25, 25);
    fill (200, 0, 0);
    ellipse (ctr1.coord ()[0], ctr1.coord ()[1], 25, 25);
    //ellipse (tr2.coord ()[0], tr2.coord ()[1], 25, 25);
    //stroke (200);
    //textSize (30);
    
    //text (ctr.GetNumberTrips (), 100, 100);
    fill (150);
    ellipse (cctr1.GetCenter ()[0], cctr1.GetCenter ()[1], 20, 20);
    if (ctr1.NumberTripsChange (2)) {
      ctr1.CloseTrajectory ();
      ctr1.SetRoundTrip (false);
    }
  }
  
  