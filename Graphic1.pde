  
  
  //LinealTrajectory2D tr1, tr2, tr3, tr4;
  //CompTrajectory ctr1, ctr2;
  //Trajectory[] trs1, trs2;
  //CircularTrajectory cctr1, cctr2, cctr3;
  
  //PolygonTrajectory ptr;
  //Trajectory[] trs;
  FlowerTrajectory ft;
  EightTrajectory et;
  
  // Hacer la clase FlowerTrajectory
  // Estoy hallando la longitud.
  // Tipos básicos de función básica.
  
  float x1, x2, y1, y2;
  float wx, wy, dxr, dyr, dxs, dys;
  
  float ax = 800;
  float ay = 900;
  float bx = 800;
  float by = 800;
  float cx = 800+200;
  float cy = 700;
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
    */
    /*
    cctr1 = new CircularTrajectory (ax, ay, bx-ax, by-ay, cx, cy, 0.01, false);
    
    wx = (ax+cx)/2;
    wy = (ay+cy)/2;
    
    dxr = ay-cy;
    dyr = cx-ax;
    
    dxs = ay-by;
    dys = bx-ax;
    */
    //ptr = new PolygonTrajectory (8, ax, ay, 500, 0, 1.5, 0.0005, false);
    //ctr1 = ptr.GetTrajectory ();
    //trs = ctr1.GetTrajectories ();
    ft = new FlowerTrajectory (2, 1, ax, ay, 300, 0, 0.01, false);
    //et = new EightTrajectory (ax, ay, 200, 0, PI, 2*PI, 0.005, false);
    //background (0);
  }
  
  void draw () {
    ft.OnDraw ();
    //et.OnDraw ();
    //cctr1.OnDraw ();
    //trs [0].OnDraw ();
    background (0);
    //et.Preview ();
    fill (0, 200, 0);
    //ellipse (ax, ay, 25, 25);
    //text ("A", ax, ay-30);
    /*
    for (int i = 0; i < trs.length; i++) {
      ellipse (trs [i].GetInitPoint ()[0], trs [i].GetInitPoint ()[1], 20, 20);
      if (i % 2 == 1) ellipse (trs [i].GetCenter ()[0], trs [i].GetCenter ()[1], 20, 20);
    }
    */
    //ellipse (cx, cy, 25, 25);
    //text ("C", cx, cy-30);
    //ellipse (ex, ey, 25, 25);
    //ellipse (cax, cay, 25, 25);
    //ellipse (et.coord ()[0], et.coord ()[1], 25, 25);
    fill (0, 0, 200);
    /*
    for (int i = 0; i < trs.length; i++) {
      ellipse (trs [i].GetInitPoint ()[0], trs [i].GetInitPoint ()[1], 10, 10);
      if (i % 2 == 0) line (trs [i].GetInitPoint ()[0], trs [i].GetInitPoint ()[1],
      trs [i].GetEndPoint ()[0], trs [i].GetEndPoint ()[1]);
    }
    */
    //ellipse (bx, by, 25, 25);
    //text ("B", bx, by-30);
    //ellipse (dx, dy, 25, 25);
    //ellipse (cbx, cby, 25, 25);
    //ellipse (cctr1.GetEndPoint ()[0], cctr1.GetEndPoint ()[1], 25, 25);
    
    fill (200, 0, 0);
    ellipse (ft.coord ()[0], ft.coord ()[1], 25, 25);
    //ellipse (trs [0].coord ()[0], trs [0].coord ()[1], 25, 25);
    //ellipse (cctr3.cx1, cctr3.cy1, 15, 15);
    /*
    ellipse (cctr1.coord ()[0], cctr1.coord ()[1], 20, 20);
    
    ellipse (wx, wy, 15, 15);
    text ("W", wx, wy-30);
    stroke (0, 200, 0);
    line (wx, wy, wx+dxr, wy+dyr);
    stroke (0, 0, 200);
    strokeWeight (10);
    line (ax, ay, ax+dxs, ay+dys);
    strokeWeight (2);
    //ellipse (tr2.coord ()[0], tr2.coord ()[1], 25, 25);
    */
    fill (150);
    ellipse (ft.GetCenter ()[0], ft.GetCenter ()[1], 20, 20);
    //ellipse (cctr3.GetCenter ()[0], cctr3.GetCenter ()[1], 20, 20);
    
    for (int i = 1; i < 10; i++) 
    if (ft.NumberTripsChange (2*i)) {
      //ft.SetAngle (et.GetAngle ()+PI/4);
      //background (0);
      ft.SetNumerator (ft.GetNumerator ()+1);
    }
    
    
    stroke (200);
    textSize (30);
    /*
    text (ft.GetFunction (), 400, 1300);
    text (ft.GetNumberPetals (), 400, 1350);
    */
    
    //text ("RadI: " + cctr1.GetRadI (), 400, 1300);
    //text ("RadF: " + cctr1.GetRadF (), 400, 1350);
    //text ("Orientation: " + cctr1.GetOrientation (), 400, 1400);
    //text ("Curv: " + cctr1.GetCurv (), 400, 1450);
    //text ("cx: " + cctr1.GetCenter ()[0], 400, 1500);
    //text ("cy: " + cctr1.GetCenter ()[1], 400, 1550);
    //text ("Length: " + et.GetLength (), 400, 1600);
    text ("m: " + ft.GetParameter (), 400, 1650);
  }
 