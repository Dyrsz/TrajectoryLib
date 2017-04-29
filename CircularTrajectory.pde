class CircularTrajectory extends Trajectory {
   
   private float cx, cy, r, radI, radF;
   private float xi, yi, xf, yf, curv;
   private boolean orientation;
   private float tp;
   /*
   Three constructive modes:
    - Circle: Center (cx, cy), radius and inner angle.
    - Arc: Two points in a 2D space joined by a circle's arc.
      curv: distance between arc's extremes and circle's center.
    - Tangent to two points with one direction asociated for each one.
      (if possible)
   */
   
   CircularTrajectory (float cxt, float cyt, float rt, float velt, boolean roundTript) {
     radI = 0;
     radF = 2*PI;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     CircleToArc (cxt, cyt, rt);
   }
   
   CircularTrajectory (float cxt, float cyt, float rt, float velt, boolean roundTript, int ttype) {
     radI = 0;
     radF = 2*PI;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
     CircleToArc (cxt, cyt, rt);
   }
   
   CircularTrajectory (float cxt, float cyt, float rt, float radIt, float radFt, float velt, boolean roundTript) {
     radI = radIt;
     radF = radFt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     CircleToArc (cxt, cyt, rt);
   }
   
  CircularTrajectory (float cxt, float cyt, float rt, float radIt, float radFt, float velt, boolean roundTript, int ttype) {
     radI = radIt;
     radF = radFt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
     CircleToArc (cxt, cyt, rt);
   }
   
   // Arcs constructors
   CircularTrajectory (boolean torient, float xit, float yit, float xft, float yft, float curvt, float velt, boolean roundTript) {
     curv = curvt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     orientation = torient;
     ArcToCircle (xit, yit, xft, yft, curv);
   }
   
   CircularTrajectory (boolean torient, float xit, float yit, float xft, float yft, float curvt, float velt, boolean roundTript, int ttype) {
     curv = curvt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
     orientation = torient;
     ArcToCircle (xit, yit, xft, yft, curv);
   }
   
   // Tangents constructors:
   CircularTrajectory (boolean torient, float xit, float yit, float dxit, float dyit, float xft, float yft, float dxft, float dyft, float velt, boolean roundTript) {
     orientation = torient;
     if (dyft*dxit != dxft*dyit) {
       AdjustTgCurv (xit, yit, dxit, dyit, xft, yft, dxft, dyft);
     } else {
       ArcToCircle (xit, yit, xft, yft, 0);
       print ("Bad call: no tangent circle possible. Code A.");
     }
     SetVelocity (velt);
     SetRoundTrip (roundTript);
   }
   
   CircularTrajectory (boolean torient, float xit, float yit, float dxit, float dyit, float xft, float yft, float dxft, float dyft, float velt, boolean roundTript, int ttype) {
     orientation = torient;
     if (dyft*dxit != dxft*dyit) {
       AdjustTgCurv (xit, yit, dxit, dyit, xft, yft, dxft, dyft);
     } else {
       ArcToCircle (xit, yit, xft, yft, 0);
       print ("Bad call: no tangent circle possible. Code B.");
     }
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
   }
   
   private void AdjustTgCurv (float xit, float yit, float dxit, float dyit, float xft, float yft, float dxft, float dyft) {
     xi = xit;
     yi = yit;
     xf = xft;
     yf = yft;
     // normalizo esto.
     float ditn = sqrt (dxit*dxit+dyit*dyit);
     dxit = dxit/ditn;
     dyit = dyit/ditn;
     float dftn = sqrt (dxft*dxft+dyft*dyft);
     dxft = dxft/dftn;
     dyft = dyft/dftn;
     
     float den = dyft*dxit - dxft*dyit;
     cx = (dyft*dxit*xi + dyft*dyit*yi - dxft*dyit*xf - dyft*dyit*yf)/den;
     cy = (dxft*dxit*xf + dyft*dxit*yf - dxft*dxit*xi - dxft*dyit*yf)/den;
     // Radius.
     float IC_x = cx-xi;
     float IC_y = cy-yi;
     float FC_x = cx-xf;
     float FC_y = cy-yf;
     float r2 = sqrt (FC_x*FC_x+FC_y*FC_y);
     r = sqrt (IC_x*IC_x+IC_y*IC_y);
     if (abs (r-r2) <= 2) {
       // Angles
       float CC0_x = 0;
       float CC0_y = -r;
       float CCI_x = xi-cx;
       float CCI_y = yi-cy;
       float CCF_x = xf-cx;
       float CCF_y = yf-cy;
       radI = -angle_between (CC0_x, CC0_y, CCI_x, CCI_y);
       radF = -angle_between (CC0_x, CC0_y, CCF_x, CCF_y);
       if (orientation) {
         while (radF < radI) radF+=2*PI;
         //while (radF > radI+2*PI) radF-=2*PI;
       } else {
         while (radF > radI) radI+=2*PI;
         //while (radF < radI+2*PI) radI-=2*PI;
       }
       // curv:
       float IF_x = xf-xi;
       float IF_y = yf-yi;
       float cx1 = (xit+xft)/2;
       float cy1 = (yit+yft)/2;
       float dx = cx-cx1;
       float dy = cy-cy1;
       curv = sqrt (dx*dx + dy*dy);
       if (angle_between(IF_x, IF_y, IC_x, IC_y) > PI) curv = -curv;
     } else {
       print ("Bad call: no tangent circle possible. Code C.\n");
       println ("r: " + r + ". r2: " + r2);
       //println ("cx: " + cx + ". cy: " + cy);
       //ArcToCircle (xi, yi, xf, yf, 0);
       radI = 0;
       radF = 2*PI;
     }
   }
   
   private void ArcToCircle (float xit, float yit, float xft, float yft, float curvt) {
     xi = xit;
     yi = yit;
     xf = xft;
     yf = yft;
     float IF_x = xft-xit;
     float IF_y = yft-yit;
     float perpIF_x = -IF_y;
     float perpIF_y = IF_x;
     float perpIF_m = sqrt (IF_x*IF_x + IF_y*IF_y);
     float perpIF_nx = perpIF_x/perpIF_m;
     float perpIF_ny = perpIF_y/perpIF_m;
     cx = (xit+xft)/2 + curvt*perpIF_nx;
     cy = (yit+yft)/2 + curvt*perpIF_ny;
     // Radius.
     float IC_x = cx-xit;
     float IC_y = cy-yit;
     r = sqrt (IC_x*IC_x+IC_y*IC_y);
     // Angles
     float CC0_x = 0;
     float CC0_y = -r;
     float CCI_x = xit-cx;
     float CCI_y = yit-cy;
     float CCF_x = xft-cx;
     float CCF_y = yft-cy;
     radI = -angle_between (CC0_x, CC0_y, CCI_x, CCI_y);
     radF = -angle_between (CC0_x, CC0_y, CCF_x, CCF_y);
     if (orientation) {
       while (radF < radI) radF+=2*PI;
       //while (radF > radI+2*PI) radF-=2*PI;
     } else {
       while (radF > radI) radI+=2*PI;
       //while (radF < radI+2*PI) radI-=2*PI;
     }
   }
   
   private float angle_between(float ax, float ay, float bx, float by) {
     float ap1x = -ay; //ap1: Vector a with a pi/2 gyre.
     float ap1y = ax;
     float ap2x = ay;  //ap2: Vector a with a 3pi/2 gyre.
     float ap2y = -ax;
     float alpha = anglePositive_between(ax, ay, bx, by);
     float beta = anglePositive_between(ap1x, ap1y, bx, by);
     float gamma = anglePositive_between(ap2x, ap2y, bx, by);
     if (beta > PI/2 && gamma < PI/2) alpha = 2*PI-alpha;
     return alpha;
   }
   
   private float anglePositive_between(float ax, float ay, float bx, float by) {
     float am = sqrt (ax*ax+ay*ay);
     float bm = sqrt (bx*bx+by*by);
     float alpha = (ax*bx+ay*by)/(am*bm);
     return acos (alpha);
   }
   
   private void CircleToArc (float cxt, float cyt, float rt) { // curv is unnecesary
     cx = cxt;
     cy = cyt;
     r = rt;
     xi = coord (0)[0];
     yi = coord (0)[1];
     xf = coord (1)[0];
     yf = coord (1)[1];
   }
   
   public float[] coord () {
     float[] ret = new float [2];
     tp = GetFunction ();
     if (GetSense()) {
       ret[0] = -r*sin (tp*(radF-radI) + radI) +cx;
       ret[1] = -r*cos (tp*(radF-radI) + radI) +cy;
     } else {
       ret[0] = -r*sin (-tp*(radF-radI) + radF) +cx;
       ret[1] = -r*cos (-tp*(radF-radI) + radF) +cy;
     }
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret = new float [2];
     if (GetSense()) {
       ret[0] = -r*sin (tt*(radF-radI) + radI) +cx;
       ret[1] = -r*cos (tt*(radF-radI) + radI) +cy;
     } else {
       ret[0] = -r*sin (-tt*(radF-radI) + radF) +cx;
       ret[1] = -r*cos (-tt*(radF-radI) + radF) +cy;
     }
     return ret;
   }
   
   public float[] coord (float tt, boolean senset) {
     float[] ret = new float [2];
     if (senset) {
       ret[0] = -r*sin (tt*(radF-radI) + radI) +cx;
       ret[1] = -r*cos (tt*(radF-radI) + radI) +cy;
     } else {
       ret[0] = -r*sin (-tt*(radF-radI) + radF) +cx;
       ret[1] = -r*cos (-tt*(radF-radI) + radF) +cy;
     }
     return ret;
   }
   
   public float [] GetCenter () {
     float [] ret = {cx, cy};
     return ret;
   }
   
   public float GetCurv () {
     return curv;
   }
   
   public float [] GetEndPoint () {
     float [] ret = {xf, yf};
     return ret;
   }
   
   public float [] GetInitPoint () {
     float [] ret = {xi, yi};
     return ret;
   }
   
   public float GetLength () {
     return abs ((radF-radI)*r);
   }
   
   public boolean GetOrientation () {
     return orientation;
   }
   
   public float GetRadF () {
     return radF;
   }
   
   public float GetRadI () {
     return radI;
   }
   
   public float GetRadius () {
     return r;
   }
   
   public String GetTrajectoryType () {
     return "Circle";
   }
   
   public void SetCurv (float tcurv) {
     curv = tcurv;
     ArcToCircle (xi, yi, xf, yf, tcurv);
   }
   
   public void SetOrientation (boolean torient) {
     orientation = torient;
     ArcToCircle (xi, yi, xf, yf, curv);
   }
 }