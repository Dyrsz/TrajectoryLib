  
  
  BezierTrajectory btr;
  Trajectory [] trss;
  // - Trayectorias cónicas.
  /*
   - Fórmulas de aproximación lineales a 
   la longitud. Esto lo arreglo cuando
   arregle esta librería en C# en Unity.
   (los métodos internos los tengo, en
   esta versión, muy mal).
   - Constructores de factoría estáticos.
  */
  
  float x1, x2, y1, y2;
  float wx, wy, dxr, dyr, dxs, dys;
  
  float ax = 600;
  float ay = 900;
  
  float bx = 700;
  float by = 800;
  
  float cx = 900;
  float cy = 700;
  
  float dx = 700;
  float dy = 1100;
  
  float ex = 500;
  float ey = 1400;
  
  float [] pts = {ax, ay, bx, by, cx, cy, dx, dy, ex, ey};
    
  void setup() {
    //pts = {ax, ay, bx, by, cx, cy, dx, dy, ex, ey};
    btr = new BezierTrajectory (pts, 0.01, true, 1);
    //trss = btr.GetTrajectories();
    background (0);
  }
  
  void draw () {
    btr.OnDraw ();
    //background (0);
    //btr.Preview (1000);
    //ft2.Preview (true, 1000, color(0,150,0));
    /*
    fill (0, 200, 0);
    ellipse (ax, ay, 25, 25);
    text ("A", ax, ay-30);
    ellipse (bx, by, 25, 25);
    text ("B", bx, by-30);
    ellipse (cx, cy, 25, 25);
    text ("C", cx, cy-30);
    ellipse (dx, dy, 25, 25);
    text ("D", dx, dy-30);
    ellipse (ex, ey, 25, 25);
    text ("E", ex, ey-30);
    */
    //ellipse (ft2.coord (ft1.GetFunction ())[0], ft2.coord (ft1.GetFunction())[1], 25, 25);
    //fill (200, 0, 0);
    /*
    for (int i = 0; i < btr.GetNumberTrajectories (); i++) {
      trss [i].OnDraw ();
      ellipse (trss [i].coord ()[0], trss [i].coord ()[1], 15, 15);
      text (i, trss [i].coord ()[0], trss [i].coord ()[1]-30);
    }
    */
    fill (0,0,0);
    stroke (200);
    ellipse (btr.coord ()[0], btr.coord ()[1], 15, 15);
    //btr.PreviewFull ();
    
    for (int i = 1; i < 10; i++) 
    if (btr.NumberTripsChange (4*i)) {
      //ft.SetAngle (et.GetAngle ()+PI/4);
      //background (0);
      //ft.SetOffSet (ft.GetOffSet ()+50);
      cx -= 100;
      cy += 50;
      pts [4] = cx;
      pts [5] = cy;
      btr.SetPoints (pts);
    }
    
    /*
    stroke (200);
    textSize (30);
    */
  }
 