 class CompTrajectory extends Trajectory {
   
   private float totalLength, t1, tp;
   private int N;
   private Trajectory [] trs;
   private float[] segms;
   
   CompTrajectory (Trajectory [] trst, float velt, boolean roundTript) {
     AdjustTrajectories (trst);
     SetVelocity (velt);
     SetRoundTrip (roundTript);
   }
   
   CompTrajectory (Trajectory [] trst, float velt, boolean roundTript, int typet) {
     AdjustTrajectories (trst);
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
   }
   
   public void AddCompTrajectory (CompTrajectory ctrt) {
     Trajectory [] trst = ctrt.GetTrajectories ();
     trst = (Trajectory []) concat (trs, trst);
     AdjustTrajectories (trst);
   }
   
   public void AddCompTrajectory (CompTrajectory ctrt, int index) {
     Trajectory [] trst = ctrt.GetTrajectories ();
     trst = (Trajectory []) splice (trs, trst, index);
     AdjustTrajectories (trst);
   }
   
   public void AddTrajectory (Trajectory trt) {
     Trajectory [] trst = (Trajectory []) append (trs, trt);
     AdjustTrajectories (trst);
   }
   
   public void AddTrajectory (Trajectory trt, int index) {
     Trajectory [] trst = (Trajectory []) splice (trs, trt, index);
     AdjustTrajectories (trst);
   }
   
   public void AddTrajectories (Trajectory [] trt) {
     Trajectory [] trst = (Trajectory []) concat (trs, trt);
     AdjustTrajectories (trst);
   }
   
   public void AddTrajectories (Trajectory [] trt, int index) {
     Trajectory [] trst = (Trajectory []) splice (trs, trt, index);
     AdjustTrajectories (trst);
   }
   
   private void AdjustTrajectories (Trajectory [] trst) {
     N = trst.length;
     trs = new Trajectory [N];
     totalLength = 0;
     for (int i = 0; i < N; i++) {
       trs [i] = trst [i];
       totalLength += trs [i].GetLength ();
     }
     segms = new float [N+1];
     segms [0] = 0;
     for (int i = 1; i < N+1; i++) 
       segms [i] = segms [i-1] + trs [i-1].GetLength ()/totalLength;
   }
   
   public void CloseTrajectory () {
     if (!IsClose (2)) {
       Trajectory ctr = new LinealTrajectory2D (trs [N-1].GetEndPoint()[0], 
       trs [N-1].GetEndPoint()[1], trs [0].GetInitPoint()[0], trs [0].GetInitPoint()[1], 0, false);
       AddTrajectory (ctr);
     }
   }
   
   public void CloseTrajectory (String typ, boolean torient) {
     if (!IsClose (2)) {
       if (typ.equals ("Lineal2D")) {
         Trajectory ctr1 = new LinealTrajectory2D (trs [N-1].GetEndPoint()[0], 
         trs [N-1].GetEndPoint()[1], trs [0].GetInitPoint()[0], trs [0].GetInitPoint()[1], 0, false);
         AddTrajectory (ctr1);
       } else if (typ.equals ("Circle") && N > 1) {
         Trajectory ctr2 = new CircularTrajectory (true, trs [N-1].GetEndPoint()[0], 
         trs [N-1].GetEndPoint()[1], trs [N-1].GetEndPoint()[0] - trs [N-2].GetEndPoint()[0], 
         trs [N-1].GetEndPoint()[1] - trs [N-2].GetEndPoint()[1], trs [0].GetInitPoint()[0], 
         trs [0].GetInitPoint()[1], 0, false);
         AddTrajectory (ctr2);
       }
     }
   }
   
   public float[] coord () {
     float[] ret = new float [2];
     tp = GetFunction ();
     if (GetSense()) {
       for (int i = 0; i < N; i++)
         if (segms [i] <= tp && tp <= segms [i+1]) {
           t1 = (tp-segms [i])/(segms [i+1] - segms [i]);
           ret = trs [i].coord (t1, true);
         }
     } else {
       for (int i = 0; i < N; i++)
         if (segms [i] <= 1-tp && 1-tp <= segms [i+1]) {
           t1 = ((1-tp)-segms [i])/(segms [i+1] - segms [i]);
           ret = trs [i].coord (t1, true);
         }
     }
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret = new float [2];
     if (GetSense()) {
       for (int i = 0; i < N; i++)
         if (segms [i] <= tt && tt <= segms [i+1]) {
           t1 = (tt-segms [i])/(segms [i+1] - segms [i]);
           ret = trs [i].coord (t1, true);
         }
     } else {
       for (int i = 0; i < N; i++)
         if (segms [i] <= 1-tt && 1-tt <= segms [i+1]) {
           t1 = ((1-tt)-segms [i])/(segms [i+1] - segms [i]);
           ret = trs [i].coord (t1, true);
         }
     }
     return ret;
   }
   
   public float[] coord (float tt, boolean senset) {
     float[] ret = new float [2];
     if (senset) {
       for (int i = 0; i < N; i++)
         if (segms [i] <= tt && tt <= segms [i+1]) {
           t1 = (tt-segms [i])/(segms [i+1] - segms [i]);
           ret = trs [i].coord (t1, true);
         }
     } else {
       for (int i = 0; i < N; i++)
         if (segms [i] <= 1-tt && 1-tt <= segms [i+1]) {
           t1 = ((1-tt)-segms [i])/(segms [i+1] - segms [i]);
           ret = trs [i].coord (t1, true);
         }
     }
     return ret;
   }
   
   public float GetCompFunction () {
     return t1;
   }
   
   public float GetLength () {
     return totalLength;
   }
   
   public float GetNumberComp () {
     return N;
   }
   
   public Trajectory [] GetTrajectories () {
     return trs;
   }
   
   public boolean IsClose () { // Simple version
     boolean ret = false;
     if (N > 0) {
       if (trs [0].GetInitPoint ()[0] == trs [N-1].GetEndPoint()[0])
         if (trs [0].GetInitPoint ()[1] == trs [N-1].GetEndPoint()[1])
           ret = true;
     }
     return ret;
   }
   
   public boolean IsClose (float tol) { // tolerance version
     boolean ret = false;
     if (N > 0) {
       float dx = trs [0].GetInitPoint ()[0] - trs [N-1].GetEndPoint()[0];
       float dy = trs [0].GetInitPoint ()[1] - trs [N-1].GetEndPoint()[1];
       float dt = sqrt (dx*dx+dy*dy);
       if (dt <= tol) ret = true;
     }
     return ret;
   }
   
   public void RemoveTrajectory (int index) {
     Trajectory [] trst1 = (Trajectory []) subset (trs, index-1);
     Trajectory [] trst2 = (Trajectory []) subset (trs, index);
     Trajectory [] trst = (Trajectory []) concat (trst1, trst2);
     AdjustTrajectories (trst);
   }
   
   public void RemoveTrajectories (int i1, int i2) {
     Trajectory [] trst1 = (Trajectory []) subset (trs, i1-1);
     Trajectory [] trst2 = (Trajectory []) subset (trs, i2);
     Trajectory [] trst = (Trajectory []) concat (trst1, trst2);
     AdjustTrajectories (trst);
   }
 }