
 float [] gyre (float x, float y, float cx, float cy, float rad) {
   float[] ret = new float [2];
   x = x - cx;
   y = y - cy;
   ret [0] = x*cos(-rad) - y*sin(-rad) + cx;
   ret [1] = x*sin(-rad) + y*cos(-rad) + cy;
   return ret;
 }

 void polygon (int n, float cx, float cy, float r, float angle, color col) {
   float x1, y1, x2, y2;
   x1 = gyre (cx, cy-r, cx, cy, angle)[0];
   y1 = gyre (cx, cy-r, cx, cy, angle)[1];
   for (int i = 0; i < n; i++) {
     noStroke ();
     fill (col);
     ellipse (x1, y1, 5, 5);
     x2 = gyre (x1, y1, cx, cy, 2*PI/n)[0];
     y2 = gyre (x1, y1, cx, cy, 2*PI/n)[1];
     stroke (col);
     strokeWeight(10);
     line (x1,y1,x2,y2);
     x1 = x2;
     y1 = y2;
   }
 }
 
 class PolygonTrajectory extends Trajectory {
   
   private int n;
   private float cx, cy, r, angle, curv;
   private float tp;
   private CompTrajectory cotr;
   
   PolygonTrajectory (int nt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript) {
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     AdjustPolygon (nt, cxt, cyt, rt, anglet, 0);
   }
   
   PolygonTrajectory (int nt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript, int typet) {
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
     AdjustPolygon (nt, cxt, cyt, rt, anglet, 0);
   }
   
   PolygonTrajectory (int nt, float cxt, float cyt, float rt, float anglet, float curvt, float velt, boolean roundTript) {
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     AdjustPolygon (nt, cxt, cyt, rt, anglet, curvt);
   }
   
   PolygonTrajectory (int nt, float cxt, float cyt, float rt, float anglet, float curvt, float velt, boolean roundTript, int typet) {
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
     AdjustPolygon (nt, cxt, cyt, rt, anglet, curvt);
   }
   
   private void AdjustPolygon (int nt, float cxt, float cyt, float rt, float anglet, float curvt) {
     n = nt;
     cx = cxt;
     cy = cyt;
     r = rt;
     angle = anglet;
     curv = curvt;
     Trajectory [] trs;
     if (curv == 0) {
       trs = new Trajectory [n];
     } else if (curv >= 1 || curv < 0) {
       trs = new Trajectory [1];
       trs [0] = new CircularTrajectory (cx, cy, r, angle, angle+2*PI, 0.01, false);
     } else {
       trs = new Trajectory [2*n];
     }
     if (curv < 1 || curv >= 0) {
       float x1, y1, x2, y2, x3, y3;
       float lx1, ly1, lx2, ly2;
       x1 = gyre (cx, cy-r, cx, cy, angle)[0];
       y1 = gyre (cx, cy-r, cx, cy, angle)[1];
       for (int i = 0; i < n; i++) {
         x2 = gyre (x1, y1, cx, cy, 2*PI/n)[0];
         y2 = gyre (x1, y1, cx, cy, 2*PI/n)[1];
         if (curv == 0) {
           trs [i] = new LinealTrajectory2D (x1, y1, x2, y2, 0.01, false);
         } else {
           x3 = gyre (x2, y2, cx, cy, 2*PI/n)[0];
           y3 = gyre (x2, y2, cx, cy, 2*PI/n)[1];
           lx1 = curv*(x2-x1)/2;
           ly1 = curv*(y2-y1)/2;
           lx2 = curv*(x3-x2)/2;
           ly2 = curv*(y3-y2)/2;
           trs [2*i] = new LinealTrajectory2D (x1+lx1, y1+ly1, x2-lx1, y2-ly1, 0.01, false);
           trs [2*i+1] = new CircularTrajectory (true, x2-lx1, y2-ly1, x2-x1, y2-y1, 
           x2+lx2, y2+ly2, 0.01, false);
         }
         x1 = x2;
         y1 = y2;
       }
     }
     cotr = new CompTrajectory (trs, GetVelocity(), IsRoundTrip (), GetType ());
     ActualizeBasics ();
   }
   
   public float [] coord () {
     float [] ret = new float [2];
     tp = GetFunction ();
     ret = cotr.coord (tp, GetSense ());
     return ret;
   }
   
   public float [] coord (float tt) {
     float [] ret = new float [2];
     ret = cotr.coord (tt, GetSense ());
     return ret;
   }
   
   public float [] coord (float tt, boolean senset) {
     float [] ret = new float [2];
     ret = cotr.coord (tt, senset);
     return ret;
   }
   
   public float GetAngle () {
     return angle;
   }
   
   public float [] GetCenter () {
     float [] ret = {cx, cy};
     return ret;
   }
   
   public float GetCurv () {
     return curv;
   }
   
   public float GetLength () {
     return cotr.GetLength ();
   }
   
   public int GetNumberVertex() {
     return n;
   }
   
   public float GetRadius () {
     return r;
   }
   
   public CompTrajectory GetTrajectory () {
     return cotr;
   }
   
   public String GetTrajectoryType () {
     return "Polygon";
   }
   
   public void SetAngle (float anglet) {
     AdjustPolygon (n, cx, cy, r, anglet, curv);
   }
   
   public void SetCenter (float [] ct) {
     if (ct.length != 2) {
       println("Bad Input on PolygonTrajectory.SetCenter().");
     } else {
       AdjustPolygon (n, ct [0], ct [1], r, angle, curv);
     }
   }
   
   public void SetCurv (float curvt) {
     AdjustPolygon (n, cx, cy, r, angle, curvt);
   }
   
   public void SetNumberVertex (int nt) {
     AdjustPolygon (nt, cx, cy, r, angle, curv);
   }
   
   public void SetRadius (float rt) {
     AdjustPolygon (n, cx, cy, rt, angle, curv);
   }
 }
 