 class BezierTrajectory extends Trajectory {
   
   private LinealTrajectory2D [] trs;
   private int numberPoints;
   private int numberTrajectories;
   private float [] points; // (p1x, p1y, p2x...)
   private int [] coefficients;
   private float tp;
   
   BezierTrajectory (float [] tpoints, float velt, boolean roundTript) {
     if (BezierConditions (tpoints)) {
       BezierConstructor (tpoints, velt, roundTript, 1);
     } else {
       BezierBadConditions ();
     }
   }
   
   BezierTrajectory (float [] tpoints, float velt, boolean roundTript, int typet) {
     if (BezierConditions (tpoints)) {
       BezierConstructor (tpoints, velt, roundTript, typet);
     } else {
       BezierBadConditions ();
     }
   }
   
   private void BezierBadConditions () {
     println ("Fail on BezierConstructor. Bad points input.");
   }
   
   private boolean BezierConditions (float [] ps) {
     if (ps.length % 2 == 0 && ps.length > 5) {
       return true;
     } else {
       return false;
     }
   }
   
   private void BezierConstructor (float [] tpoints, float velt, boolean roundTript, int typet) {
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
     points = tpoints;
     numberPoints = points.length/2;
     numberTrajectories = Calc_TriangularNumber (numberPoints-1);
     trs = new LinealTrajectory2D [numberTrajectories];
     for (int i = 0; i < numberPoints-1; i++)
       trs [i] = new LinealTrajectory2D (points [2*i], points [2*i+1], points [2*(i+1)], points [2*i+3], velt, roundTript, typet);
     for (int i = numberPoints -1; i < numberTrajectories; i++)
       trs [i] = new LinealTrajectory2D (0, 0, 1, 1, velt, roundTript, typet);
     coefficients = new int [numberPoints];
     for (int i = 0; i < numberPoints; i++)
       coefficients [i] = Calc_CombinatoryNumber (numberPoints-1, i);
   }
   
   // Auxiliar functions:
   private int Calc_CombinatoryNumber (int n, int m) {
     int N = 1;
     for (int i = m+1; i <= n; i++) if (i>1) N*=i;
     for (int i = 2; i <= n-m; i++) N/=i;
     return N;
   }
   
   private float Calc_Elevate (float base, int exp) {
     float N = 1;
     if (exp > 0) for (int i = 1; i <= exp; i++) N*=base;
     return N;
   }
   
   private int Calc_TriangularNumber (int n) {
     int N = 0;
     if (n > 0) for (int i = 1; i <= n; i++) N += i;
     return N;
   }
   
   private void ActualizeTrajectories () {
     float [] j1 = new float [2];
     float [] j2 = new float [2];
     int index1, index2;
     boolean sen = GetSense ();
     tp = GetFunction ();
     for (int i = numberPoints-2; i > 0; i--) {
       index1 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i);
       index2 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i-1) -1;
       for (int j = index1; j <= index2; j++) {
         j1 [0] = trs [j-i-1].coord (tp, sen)[0];
         j1 [1] = trs [j-i-1].coord (tp, sen)[1];
         j2 [0] = trs [j-i].coord (tp, sen)[0];
         j2 [1] = trs [j-i].coord (tp, sen)[1];
         trs [j].SetInitPoint (j1);
         trs [j].SetEndPoint (j2);
       }
     }
   }
   
   private void ActualizeTrajectories (float tt) {
     float [] j1 = new float [2];
     float [] j2 = new float [2];
     int index1, index2;
     boolean sen = GetSense ();
     for (int i = numberPoints-2; i > 0; i--) {
       index1 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i);
       index2 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i-1) -1;
       for (int j = index1; j <= index2; j++) {
         j1 [0] = trs [j-i-1].coord (tt, sen)[0];
         j1 [1] = trs [j-i-1].coord (tt, sen)[1];
         j2 [0] = trs [j-i].coord (tt, sen)[0];
         j2 [1] = trs [j-i].coord (tt, sen)[1];
         trs [j].SetInitPoint (j1);
         trs [j].SetEndPoint (j2);
       }
     }
   }
   
   private void ActualizeTrajectories (float tt, boolean senset) {
     float [] j1 = new float [2];
     float [] j2 = new float [2];
     int index1, index2;
     for (int i = numberPoints-2; i > 0; i--) {
       index1 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i);
       index2 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i-1) -1;
       for (int j = index1; j <= index2; j++) {
         j1 [0] = trs [j-i-1].coord (tt, senset)[0];
         j1 [1] = trs [j-i-1].coord (tt, senset)[1];
         j2 [0] = trs [j-i].coord (tt, senset)[0];
         j2 [1] = trs [j-i].coord (tt, senset)[1];
         trs [j].SetInitPoint (j1);
         trs [j].SetEndPoint (j2);
       }
     }
   }
   
   public void AddPoint (float tpointx, float tpointy) {
     float [] npoints = new float [2*numberPoints + 2];
     for (int i = 0; i < 2*numberPoints; i++)
       npoints [i] = points [i];
     npoints [2*numberPoints] = tpointx;
     npoints [2*numberPoints+1] = tpointy;
     BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
   }
   
   public void AddPoint (float tpointx, float tpointy, int index) {
     float [] npoints = new float [2*numberPoints + 2];
     if (index > 0) for (int i = 0; i < 2*index; i++)
       npoints [i] = points [i];
     npoints [2*index] = tpointx;
     npoints [2*index+1] = tpointy;
     if (index < numberPoints) for (int i = 2*index+2; i < 2*numberPoints+2; i++)
       npoints [i] = points [i-2];
     BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
   }
   
   public void AddPoint (float[] tpoint) {
     if (tpoint.length == 2) {
       float [] npoints = new float [2*numberPoints + 2];
       for (int i = 0; i < 2*numberPoints; i++)
         npoints [i] = points [i];
       npoints [2*numberPoints] = tpoint [0];
       npoints [2*numberPoints+1] = tpoint [1];
       BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
     } else if (tpoint.length > 2) {
       println ("Bad input on BezierTrajectory.AddPoint(): Use BezierTrajectory.AddPoints () instead.");
     } else {
       println ("Bad input on BezierTrajectory.Addpoint()");
     }
   }
   
   public void AddPoint (float[] tpoint, int index) {
     if (tpoint.length == 2) {
       float [] npoints = new float [2*numberPoints + 2];
       if (index > 0) for (int i = 0; i < 2*index; i++)
         npoints [i] = points [i];
       npoints [2*index] = tpoint[0];
       npoints [2*index+1] = tpoint[1];
       if (index < numberPoints) for (int i = 2*index+2; i < 2*numberPoints+2; i++)
         npoints [i] = points [i-2];
       BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
     } else if (tpoint.length > 2) {
       println ("Bad input on BezierTrajectory.AddPoint(): Use BezierTrajectory.AddPoints () instead.");
     } else {
       println ("Bad input on BezierTrajectory.Addpoint()");
     }
   }
   
   public void AddPoints (float[] tpoint) {
     int l = tpoint.length;
     if (l == 2) {
       println ("Bad input on BezierTrajectory.AddPoints(): Use BezierTrajectory.AddPoint () instead.");
     } else if (l > 0 && l % 2 == 0) {
       float [] npoints = new float [2*numberPoints + l];
       for (int i = 0; i < 2*numberPoints; i++)
         npoints [i] = points [i];
       for (int i = 0; i < l; i++)
         npoints [2*numberPoints + i] = tpoint [i];
       BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
     } else {
       println ("Bad input on BezierTrajectory.AddPoints()");
     }
   }
   
   public void AddPoints (float[] tpoint, int index) {
     int l = tpoint.length;
     if (l == 2) {
       println ("Bad input on BezierTrajectory.AddPoints(): Use BezierTrajectory.AddPoint () instead.");
     } else if (l > 0 && l % 2 == 0) {
       float [] npoints = new float [2*numberPoints + l];
       if (index > 0) for (int i = 0; i < 2*index; i++)
         npoints [i] = points [i];
       for (int i = 0; i < l; i++)
       npoints [2*index+i] = tpoint[i];
       if (index < numberPoints) for (int i = 2*index+l; i < 2*numberPoints+l; i++)
         npoints [i] = points [i-l];
       BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
      } else {
       println ("Bad input on BezierTrajectory.AddPoints()");
     }
   }
   
   public void CloseTrajectory () {
     if (IsClose (3)) {
       println ("Bad call on BezierTrajectory.CloseTrajectory (): The curve is already closed.");
     } else {
       AddPoint (points [2*numberPoints-2], points [2*numberPoints-1]);
     }
   }
   
   public float[] coord () {
     float[] ret = new float [2];
     float t1, t2;
     ret [0] = 0;
     ret [1] = 0;
     tp = GetFunction ();
     for (int i = 0; i < numberPoints; i++) {
       if (GetSense ()) {
         t1 = Calc_Elevate (tp, i);
         t2 = Calc_Elevate (1-tp, numberPoints-1-i);
       } else {
         t1 = Calc_Elevate (1-tp, i);
         t2 = Calc_Elevate (tp, numberPoints-1-i);
       }
       ret [0] += coefficients [i]*points [2*i]*t1*t2;
       ret [1] += coefficients [i]*points [2*i+1]*t1*t2;
     }
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret = new float [2];
     float t1, t2;
     ret [0] = 0;
     ret [1] = 0;
     for (int i = 0; i < numberPoints; i++) {
       if (GetSense ()) {
         t1 = Calc_Elevate (tt, i);
         t2 = Calc_Elevate (1-tt, numberPoints-1-i);
       } else {
         t1 = Calc_Elevate (1-tt, i);
         t2 = Calc_Elevate (tt, numberPoints-1-i);
       }
       ret [0] += coefficients [i]*points [2*i]*t1*t2;
       ret [1] += coefficients [i]*points [2*i+1]*t1*t2;
     }
     return ret;
   }
   
   public float[] coord (float tt, boolean senset) {
     float[] ret = new float [2];
     float t1, t2;
     ret [0] = 0;
     ret [1] = 0;
     for (int i = 0; i < numberPoints; i++) {
       if (senset) {
         t1 = Calc_Elevate (tt, i);
         t2 = Calc_Elevate (1-tt, numberPoints-1-i);
       } else {
         t1 = Calc_Elevate (1-tt, i);
         t2 = Calc_Elevate (tt, numberPoints-1-i);
       }
       ret [0] += coefficients [i]*points [2*i]*t1*t2;
       ret [1] += coefficients [i]*points [2*i+1]*t1*t2;
     }
     return ret;
   }
   
   /*
   Better use the direct formula.
   Used in PreviewFull.
   public float[] Pcoord () {
     float[] ret = new float [2];
     int index1, index2;
     float [] j1 = new float [2];
     float [] j2 = new float [2];
     boolean sen = GetSense ();
     tp = GetFunction ();
     for (int i = numberPoints-2; i > 0; i--) {
       index1 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i);
       index2 = Calc_TriangularNumber(numberPoints-1) - Calc_TriangularNumber (i-1) -1;
       for (int j = index1; j <= index2; j++) {
         j1 [0] = trs [j-i-1].coord (tp, sen)[0];
         j1 [1] = trs [j-i-1].coord (tp, sen)[1];
         j2 [0] = trs [j-i].coord (tp, sen)[0];
         j2 [1] = trs [j-i].coord (tp, sen)[1];
         trs [j].SetInitPoint (j1);
         trs [j].SetEndPoint (j2);
       }
     }
     ret [0] = trs [numberTrajectories-1].coord (tp, GetSense ())[0];
     ret [1] = trs [numberTrajectories-1].coord (tp, GetSense ())[1];
     return ret;
   }
   */
   
   public float [] GetCenter () {
     // Arithmetic mean. This is not correct.
     float [] ret = {0, 0};
     for (int i = 0; i < numberPoints; i++) {
       ret [0] += points [2*i];
       ret [1] += points [2*i+1];
     }
     ret [0] /= numberPoints;
     ret [1] /= numberPoints;
     return ret;
   }
   
   public int [] GetCoefficients () {
     return coefficients;
   }
   
   public int GetNumberPoints () {
     return numberPoints;
   }
   
   public int GetNumberTrajectories () {
     return numberTrajectories;
   }
   
   public float [] GetPoint (int index) {
     float [] ret = new float [2];
     if (index < 0 || index >= numberPoints) {
       println("Bad input on BezierTrajectory.GetPoint (index).");
     } else {
       ret [0] = points [2*index];
       ret [1] = points [2*index+1];
     }
     return ret;
   }
   
   public float [] GetPoints () {
     return points;
   }
   
   public Trajectory [] GetTrajectories () {
     ActualizeTrajectories ();
     return trs;
   }
   
   public Trajectory [] GetTrajectories (float tt) {
     ActualizeTrajectories (tt);
     return trs;
   }
   
   public Trajectory [] GetTrajectories (float tt, boolean senset) {
     ActualizeTrajectories (tt, senset);
     return trs;
   }
   
   // Use IsClose (tolerance) instead.
   public boolean IsClose () {
     boolean ret = false;
     float a = abs (points [0] - points [2*numberPoints-2]);
     float b = abs (points [1] - points [2*numberPoints-1]);
     if (a == 0 && b == 0) ret = true;
     return ret;
   }
   
   public boolean IsClose (int tolerance) {
     boolean ret = false;
     float a = abs (points [0] - points [2*numberPoints-2]);
     float b = abs (points [1] - points [2*numberPoints-1]);
     if (abs (a*a - b*b) < tolerance) ret = true;
     return ret;
   }
   
   public void PreviewFull () {
     ActualizeTrajectories ();
     boolean sen = GetSense ();
     tp = GetFunction ();
     noStroke ();
     fill (0, 200, 0);
     for (int i = 0; i < numberPoints; i++)
       ellipse (points [2*i], points [2*i+1], 20, 20);
     for (int i = 0; i < numberTrajectories; i++)
       trs [i].Preview ();
     for (int i = 0; i < numberTrajectories; i++) {
       if (i != numberTrajectories-1) {
         fill (200, 0, 0);
       } else {
         fill (0, 0, 200);
       }
       noStroke ();
       ellipse (trs [i].coord (tp, sen)[0], trs [i].coord (tp, sen)[1], 15, 15);
     }
   }
   
   public void RemovePoint () {
     if (numberPoints > 3) {
       float [] npoints = new float [2*numberPoints -2];
       for (int i = 0; i < 2*numberPoints-2; i++)
         npoints [i] = points [i];
       BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
     } else {
       println ("Bad call on BezierTrajectory.RemovePoint (): Less than three points in this type is not allowed.");
     }
   }
   
   public void RemovePoint (int index) {
     if (index >= numberPoints) {
       RemovePoint ();
     } else {
       if (numberPoints > 3) {
         float [] npoints = new float [2*numberPoints -2];
         if (index > 0) for (int i = 0; i < 2*index; i++)
           npoints [i] = points [i];
         for (int i = 2*index; i < 2*numberPoints-2; i++)
           npoints [i] = points [i+2];
         BezierConstructor (npoints, GetVelocity (), IsRoundTrip(), GetType ());
       } else {
         println ("Bad call on BezierTrajectory.RemovePoint (): Less than three points in this type is not allowed.");
       }
     }
   }
   
   public void RemovePoints (int index, int amount) {
     if (index >= numberPoints) {
       RemovePoint ();
     } else {
       int n = amount;
       while (numberPoints > 3 && n > 0) {
         RemovePoint (index);
         n --;
       }
     }
   }
   
   public void SetPoints (float [] tpoints) {
     if (BezierConditions (tpoints)) {
       BezierConstructor (tpoints, GetVelocity (), IsRoundTrip(), GetType ());
     } else {
       BezierBadConditions ();
     }
   }
 }

/*
 class RecursiveTrajectory extends Trajectory {
   private Trajectory [] trs;
   private int N;
   private String typT;
 }
 */