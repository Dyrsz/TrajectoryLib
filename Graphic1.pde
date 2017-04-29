  
  
  //LinealTrajectory2D tr1, tr2, tr3, tr4;
  CompTrajectory ctr1, ctr2;
  //Trajectory[] trs1, trs2;
  //CircularTrajectory cctr1, cctr2, cctr3;
  
  PolygonTrajectory ptr;
  Trajectory[] trs;
  
  
  // Hacer la clase FlowerTrajectory
  
  float x1, x2, y1, y2;
  
  float ax = 800;
  float ay = 900;
  float bx = 800-200;
  float by = 900;
  float cx = 800+200;
  float cy = 900;
  float dx = 800+400;
  float dy = 900-300;
  float ex = 100;
  float ey = 300;
  
  float cax = 600;
  float cay = 1100;
  float cbx = 600;
  float cby = 300;
  float ccurv = 50;
  
  void setup() {
    //size (1080, 1920, P3D);
    /*
    tr1 = new LinealTrajectory2D (ax, ay, bx, by, 0.01, true);
    cctr1 = new CircularTrajectory (true, bx, by, bx-ax, by-ay, cx, cy, dx-cx, dy-cy, 0.01, true);
    tr3 = new LinealTrajectory2D (cx, cy, dx, dy, 0.01, true);
    cctr2 = new CircularTrajectory (true, dx, dy, ex, ey, 100, 0.01, true);  
    //cctr1.SetOrientation (true);
    Trajectory [] trs1 = {tr1, cctr1, tr3, cctr2};
    //LinealTrajectory2D [] trs2 = {tr3, tr4};
    ctr1 = new CompTrajectory (trs1, 0.01, true);
    //ctr2 = new CompLinTrajectory2D (trs2, 0.01, true);
    //print ("L" + cctr2.GetLength ());
    //cctr3 = new CircularTrajectory (bx, by, bx-ax, by-ay, cx, cy, cx-dx, cy-dy, 0.01, true);
    //cctr1 = new CircularTrajectory (500, 1500, 200, 0.3, 1.5, 0.01, false);
    */
    ptr = new PolygonTrajectory (5, ax, ay, 500, 0, 0.5, 0.005, false);
    ctr1 = ptr.GetTrajectory ();
    trs = ctr1.GetTrajectories ();
  }
  
  void draw () {
    ptr.OnDraw ();
    //cctr1.OnDraw ();
    //trs [0].OnDraw ();
    background (0);
    
    fill (0, 200, 0);
    ellipse (ax, ay, 25, 25);
    for (int i = 0; i < trs.length; i++) {
      ellipse (trs [i].GetInitPoint ()[0], trs [i].GetInitPoint ()[1], 20, 20);
      if (i % 2 == 1) ellipse (trs [i].GetCenter ()[0], trs [i].GetCenter ()[1], 20, 20);
    }
    //ellipse (cx, cy, 25, 25);
    //ellipse (ex, ey, 25, 25);
    //ellipse (cax, cay, 25, 25);
    //ellipse (cctr1.GetInitPoint ()[0], cctr1.GetInitPoint ()[1], 25, 25);
    fill (0, 0, 200);
    for (int i = 0; i < trs.length; i++) {
      ellipse (trs [i].GetInitPoint ()[0], trs [i].GetInitPoint ()[1], 10, 10);
      if (i % 2 == 0) line (trs [i].GetInitPoint ()[0], trs [i].GetInitPoint ()[1],
      trs [i].GetEndPoint ()[0], trs [i].GetEndPoint ()[1]);
    }
    //ellipse (bx, by, 25, 25);
    //ellipse (dx, dy, 25, 25);
    //ellipse (cbx, cby, 25, 25);
    //ellipse (cctr1.GetEndPoint ()[0], cctr1.GetEndPoint ()[1], 25, 25);
   
    fill (200, 0, 0);
    ellipse (ptr.coord ()[0], ptr.coord ()[1], 25, 25);
    //ellipse (trs [0].coord ()[0], trs [0].coord ()[1], 25, 25);
    //ellipse (cctr3.cx1, cctr3.cy1, 15, 15);
    //ellipse (tr1.coord ()[0], tr1.coord ()[1], 20, 20);
   
    //ellipse (tr2.coord ()[0], tr2.coord ()[1], 25, 25);
    /*
    fill (150);
    //ellipse (cctr1.GetCenter ()[0], cctr1.GetCenter ()[1], 20, 20);
    //ellipse (cctr3.GetCenter ()[0], cctr3.GetCenter ()[1], 20, 20);
    if (ctr1.NumberTripsChange (2)) {
      //cctr1.SetOrientation (true);
      ctr1.CloseTrajectory ();
      ctr1.SetRoundTrip (false);
    }
    */
    /*
    stroke (200);
    textSize (30);
    text ("RadI: " + cctr1.GetRadI (), 400, 1300);
    text ("RadF: " + cctr1.GetRadF (), 400, 1350);
    text ("Orientation: " + cctr1.GetOrientation (), 400, 1400);
    text ("Curv: " + cctr1.GetCurv (), 400, 1450);
    text ("cx: " + cctr1.GetCenter ()[0], 400, 1500);
    text ("cy: " + cctr1.GetCenter ()[1], 400, 1550);
    text ("Length: " + cctr1.GetLength (), 400, 1600);
    */
  }
  
  