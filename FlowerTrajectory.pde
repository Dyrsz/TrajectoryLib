
class FlowerTrajectory extends Trajectory {
   
   private int n, d;
   private float cx, cy, r, angle, radI = 0, radF = 2*PI;
   private float m, offset, tp;
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, 0, 2*PI, 0, velt, roundTript, 1);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript, int typet) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, 0, 2*PI, 0, velt, roundTript, typet);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, radIt, radFt, 0, velt, roundTript, 1);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, radIt, radFt, 0, velt, roundTript, typet);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, 0, 2*PI, 0, velt, roundTript, 1);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float velt, boolean roundTript, int typet) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, 0, 2*PI, 0, velt, roundTript, typet);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, radIt, radFt, 0, velt, roundTript, 1);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float velt, boolean roundTript, int typet) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, radIt, radFt, 0, velt, roundTript, typet);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float ost, float velt, boolean roundTript) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, 0, 2*PI, ost, velt, roundTript, 1);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float ost, float velt, boolean roundTript, int typet) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, 0, 2*PI, ost, velt, roundTript, typet);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float ost, float velt, boolean roundTript) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, radIt, radFt, ost, velt, roundTript, 1);
   }
   
   FlowerTrajectory (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float ost, float velt, boolean roundTript, int typet) {
     FlowerConstructor (nt, dt, cxt, cyt, rt, anglet, radIt, radFt, ost, velt, roundTript, typet);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float ost, float velt, boolean roundTript) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, 0, 2*PI, ost, velt, roundTript, 1);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float ost, float velt, boolean roundTript, int typet) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, 0, 2*PI, ost, velt, roundTript, typet);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float ost, float velt, boolean roundTript) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, radIt, radFt, ost, velt, roundTript, 1);
   }
   
   FlowerTrajectory (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float ost, float velt, boolean roundTript, int typet) {
     FlowerConstructor (mt, cxt, cyt, rt, anglet, radIt, radFt, ost, velt, roundTript, typet);
   }
   
   private void FlowerConstructor (int nt, int dt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float ost, float velt, boolean roundTript, int typet) {
     n = nt;
     d = dt;
     if (d == 0) d = 1;
     m = float (n)/float (d);
     offset = ost;
     cx = cxt;
     cy = cyt;
     r = rt;
     angle = anglet;
     radI = radIt;
     radF = radFt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
     ActualizeBasics (2000);
   }
   
   private void FlowerConstructor (float mt, float cxt, float cyt, float rt, float anglet, float radIt, float radFt, float ost, float velt, boolean roundTript, int typet) {
     m = mt;
     AdjustParameter (m);
     if (d == 0) d = 1;
     offset = ost;
     cx = cxt;
     cy = cyt;
     r = rt;
     angle = anglet;
     radI = radIt;
     radF = radFt;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
     ActualizeBasics (2000);
   }
   
   private void AdjustParameter (float tm) {
     tm = 1000*tm;
     int num = abs (int (tm));
     int den = 1000;
     for (int i = 2; i <= sqrt (den); i++) {
       if (num%i == 0 && den%i == 0) {
         num = num/i;
         den = den/i;
         i = 1;
       }
     }
     n = num;
     d = den;
   }
   
   public void ActualizeBasics () {
     println ("Bad call. Use FlowerTrajectory.ActualizeBasics (int) instead.");
   }
   
   public float CalcMaxCenterDistance () {
     println ("Max. center distance too complex to be calculated by this metod. Use FlowerTrajectory.CalcMaxCenterDistance (int) instead.");
     return CalcMaxCenterDistance (2000);
   }
   
   public float CalcMinCenterDistance () {
     println ("Min. center distance too complex to be calculated by this metod. Use FlowerTrajectory.CalcMinCenterDistance (int) instead.");
     return CalcMinCenterDistance (2000);
   }
   
   // I could put r = (r1, r2),
   // offset = (os1, os2), or even
   // m = (m1, m2). The curve will be
   // continuous.
   // (
   // ret [0] = r1*...
   // ret [1] = r2*...
   // )
   public float[] coord () {
     float[] ret = new float [2];
     float phi1, phi2;
     tp = GetFunction ();
     phi1 = tp*(radF-radI) + radI;
     phi2 = -tp*(radF-radI) + radF;
     if (GetSense()) {
       ret[0] = (-r*cos (m*phi1 + angle)-offset)* sin (phi1) +cx;
       ret[1] = (-r*cos (m*phi1 + angle)-offset)* cos (phi1) +cy;
     } else {
       ret[0] = (-r*cos (m*phi2 + angle)-offset)* sin (phi2) +cx;
       ret[1] = (-r*cos (m*phi2 + angle)-offset)* cos (phi2) +cy;
     }
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret = new float [2];
     float phi1, phi2;
     phi1 = tt*(radF-radI) + radI;
     phi2 = -tt*(radF-radI) + radF;
     if (GetSense()) {
       ret[0] = (-r*cos (m*phi1 + angle)-offset)* sin (phi1) +cx;
       ret[1] = (-r*cos (m*phi1 + angle)-offset)* cos (phi1) +cy;
     } else {
       ret[0] = (-r*cos (m*phi2 + angle)-offset)* sin (phi2) +cx;
       ret[1] = (-r*cos (m*phi2 + angle)-offset)* cos (phi2) +cy;
     }
     return ret;
   }
   
   public float[] coord (float tt, boolean senset) {
     float[] ret = new float [2];
     float phi1, phi2;
     phi1 = tt*(radF-radI) + radI;
     phi2 = -tt*(radF-radI) + radF;
     if (senset) {
       ret[0] = (-r*cos (m*phi1 + angle)-offset)* sin (phi1) +cx;
       ret[1] = (-r*cos (m*phi1 + angle)-offset)* cos (phi1) +cy;
     } else {
       ret[0] = (-r*cos (m*phi2 + angle)-offset)* sin (phi2) +cx;
       ret[1] = (-r*cos (m*phi2 + angle)-offset)* cos (phi2) +cy;
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
   
   public float GetLength () {
     println ("Bad call on FlowerTrajectory.GetLength ().");
     return 0;
   }
   
   public int GetNumerator() {
     return n;
   }
   
   public float GetOffSet () {
     return offset;
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
   
   public String GetTrajectoryType () {
     return "Flower";
   }
   
   public void Preview () {
     println ("Preview too complex to be calculated by this metod. Use FlowerTrajectory.Preview (int) instead.");
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
     ActualizeBasics (2000);
   }
   
   public void SetNumerator (int nt) {
     n = nt;
     m = float (n)/float (d);
     ActualizeBasics (2000);
   }
   
   public void SetOffSet (float ost) {
     offset = ost;
     ActualizeBasics (2000);
   }
   
   public void SetParameter (float mt) {
     m = mt;
     AdjustParameter (m);
     ActualizeBasics (2000);
   }
   
   public void SetRadF (float radFt) {
     radF = radFt;
     ActualizeBasics (2000);
   }
   
   public void SetRadI (float radIt) {
     radI = radIt;
     ActualizeBasics (2000);
   }
   
   public void SetRadius (float rt) {
     r = rt;
     ActualizeBasics (2000);
   }
 }