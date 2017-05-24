  
  
  FlowerTrajectory ft;
  
  // ¿Meterme con las curvas de Bezier?
  
  float x1, x2, y1, y2;
  float wx, wy, dxr, dyr, dxs, dys;
  
  float ax = 800;
  float ay = 900;
  
  void setup() {
    //size (1080, 1920, P3D);
    ft = new FlowerTrajectory (0.333, ax, ay, 300, 0, 0, 4*PI, 0.005, false);
    //et = new EightTrajectory (ax, ay, 200, 0, PI, 2*PI, 0.005, false);
    //background (0);
  }
  
  void draw () {
    ft.OnDraw ();
    //et.OnDraw ();
    //cctr1.OnDraw ();
    //trs [0].OnDraw ();
    background (0);
    ft.Preview (1000);
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
      ft.SetOffSet (ft.GetOffSet ()+50);
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
    text ("n: " + ft.GetNumerator (), 400, 1700);
    text ("d: " + ft.GetDenominator (), 400, 1750);
  }
 