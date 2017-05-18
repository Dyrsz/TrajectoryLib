
class EightTrajectory extends Trajectory {
   
   private float cx, cy, r, angle, radI, radF;
   private float tp;
   
   // radI and radF have to be k*(PI/2) for some integer k.
   
   EightTrajectory (float cxt, float cyt, float rt, float velt, boolean roundTript) {
     EightConstructor (cxt, cyt, rt, 0, 0, 2*PI, velt, roundTript, 1);
   }
   
   EightTrajectory (float cxt, float cyt, float rt, float velt, boolean roundTript, int typet) {
     EightConstructor (cxt, cyt, rt, 0, 0, 2*PI, velt, roundTript, typet);
   }
   
   EightTrajectory (float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript) {
     EightConstructor (cxt, cyt, rt, anglet, 0, 2*PI, velt, roundTript, 1);
   }
   
   EightTrajectory (float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript, int typet) {
     EightConstructor (cxt, cyt, rt, anglet, 0, 2*PI, velt, roundTript, typet);
   }
   
   EightTrajectory (float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript) {
     EightConstructor (cxt, cyt, rt, anglet, radIt, radFt, velt, roundTript, 1);
   }
   
   EightTrajectory (float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     EightConstructor (cxt, cyt, rt, anglet, radIt, radFt, velt, roundTript, typet);
   }
   
   private void EightConstructor (float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     cx = cxt;
     cy = cyt;
     r = rt;
     angle = anglet;
     radI = radIt - radIt% (PI/2);
     radF = radFt - radFt% (PI/2);
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
   }
   
   public float[] coord () {
     float[] ret0 = new float [2];
     float[] ret = new float [2];
     tp = GetFunction ();
     if (GetSense()) {
       ret0[0] = -r*sin (tp*2*(radF-radI) + radI) +cx;
       ret0[1] = -r*sin (tp*(radF-radI) + radI) +cy;
     } else {
       ret0[0] = -r*sin (-tp*2*(radF-radI) + radF) +cx;
       ret0[1] = -r*sin (-tp*(radF-radI) + radF) +cy;
     }
     if (angle != 0 && angle != 2*PI) {
       ret = gyre (ret0 [0], ret0 [1], cx, cy, angle);
     } else {
       ret = ret0;
     }
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret0 = new float [2];
     float[] ret = new float [2];
     if (GetSense()) {
       ret0[0] = -r*sin (tt*2*(radF-radI) + radI) +cx;
       ret0[1] = -r*sin (tt*(radF-radI) + radI) +cy;
     } else {
       ret0[0] = -r*sin (-tt*2*(radF-radI) + radF) +cx;
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
       ret0[0] = -r*sin (tt*2*(radF-radI) + radI) +cx;
       ret0[1] = -r*sin (tt*(radF-radI) + radI) +cy;
     } else {
       ret0[0] = -r*sin (-tt*2*(radF-radI) + radF) +cx;
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
   
   public float GetLength () {
     int k1 = int (radF/(PI/2));
     int k2 = int (radI/(PI/2));
     return r*(k1-k2)*4.7147;
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
   
   public void SetRadF (float radFt) {
     radF = radFt;
   }
   
   public void SetRadI (float radIt) {
     radI = radIt;
   }
   
   public void SetRadius (float rt) {
     r = rt;
   }
   
 }