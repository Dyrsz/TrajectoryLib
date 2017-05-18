
class FlowerTrajectory extends Trajectory {
   
   private int n, d;
   private float cx, cy, r, angle, radI = 0, radF = 2*PI;
   private float m, tp;
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, 0, 2*PI, velt, roundTript, 1);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript, int typet) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, 0, 2*PI, velt, roundTript, typet);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, radIt, radFt, velt, roundTript, 1);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, radIt, radFt, velt, roundTript, typet);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, 0, 2*PI, velt, roundTript, 1);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript, int typet) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, 0, 2*PI, velt, roundTript, typet);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, radIt, radFt, velt, roundTript, 1);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, radIt, radFt, velt, roundTript, typet);
   }
   
   private void FlowerConstructor (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     n = nt;
     d = dt;
     if (d == 0) d = 1;
     m = float (n)/float (d);
     cx = cxt;
     cy = cyt;
     r = rt;
     angle = anglet;
     radI = radIt;
     radF = radFt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
   }
   
   private void FlowerConstructor (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     m = mt;
     // esto.
     //n = nt;
     //d = dt;
     if (d == 0) d = 1;
     m = float (n)/float (d);
     cx = cxt;
     cy = cyt;
     r = rt;
     angle = anglet;
     radI = radIt;
     radF = radFt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
   }
   
   public float[] coord () {
     float[] ret0 = new float [2];
     float[] ret = new float [2];
     float phi1, phi2;
     tp = GetFunction ();
     phi1 = tp*(radF-radI) + radI;
     phi2 = -tp*(radF-radI) + radF;
     if (GetSense()) {
       ret[0] = -r*cos (m*phi1 + angle)* sin (phi1) +cx;
       ret[1] = -r*cos (m*phi1 + angle)* cos (phi1) +cy;
     } else {
       ret[0] = -r*cos (m*phi2 + angle)* sin (phi2) +cx;
       ret[1] = -r*cos (m*phi2 + angle)* cos (phi2) +cy;
     }
     /*
     if (angle != 0 && angle != 2*PI) {
       ret = gyre (ret0 [0], ret0 [1], cx, cy, angle);
     } else {
       ret = {ret0 [0], ret0 [1]};
     }
     */
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret0 = new float [2];
     float[] ret = new float [2];
     if (GetSense()) {
       ret0[0] = -r*sin (tt*n*(radF-radI) + radI) +cx;
       ret0[1] = -r*sin (tt*(radF-radI) + radI) +cy;
     } else {
       ret0[0] = -r*sin (-tt*(radF-radI) + radF) +cx;
       ret0[1] = -r*sin (-tt*(radF-radI) + radF) +cy;
     }
     if (angle != 0 && angle != 2*PI) {
       ret = gyre (ret0 [0], ret0 [1], cx, cy, angle);
     } else {
       ret = ret0;
     }
     return ret;
   }
   
   public float[] coord (float tt, boolean senset) {
     float[] ret0 = new float [2];
     float[] ret = new float [2];
     if (senset) {
       ret0[0] = -r*sin (tt*m*(radF-radI) + radI) +cx;
       ret0[1] = -r*sin (tt*(radF-radI) + radI) +cy;
     } else {
       ret0[0] = -r*sin (-tt*(radF-radI) + radF) +cx;
       ret0[1] = -r*sin (-tt*(radF-radI) + radF) +cy;
     }
     if (angle != 0 && angle != 2*PI) {
       ret = gyre (ret0 [0], ret0 [1], cx, cy, angle);
     } else {
       ret = ret0;
     }
     return ret;
   }
   
   public float GetAngle () {
     return angle;
   }
   
   public float [] GetCenter () {
     float [] ret = {cx, cy};
     return ret;
   }
   
   public int GetDenominator () {
     return d;
   }
   
   public int GetNumerator() {
     return n;
   }
   
   public float GetParameter () {
     return m;
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
   
   public void SetAngle (float anglet) {
     angle = anglet;
   }
   
   public void SetCenter (float [] ct) {
     if (ct.length != 2) {
       println("Bad Input on FlowerTrajectory.SetCenter().");
     } else {
       cx = ct [0];
       cy = ct [1];
     }
   }
   
   public void SetDenominator (int dt) {
     d = dt;
     if (d == 0) d = 1;
     m = float (n)/float (d);
   }
   
   public void SetNumerator (int nt) {
     n = nt;
     m = float (n)/float (d);
   }
   
   public void SetParameter (float mt) {
     m = mt;
   }
   
   public void SetRadF (float radFt) {
     radF = radFt - radFt% (PI/2);
   }
   
   public void SetRadI (float radIt) {
     radI = radIt - radIt% (PI/2);
   }
   
   public void SetRadius (float rt) {
     r = rt;
   }
   
 }