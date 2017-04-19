 class CompTrajectory extends Trajectory {
   
   private float totalLength, t1, tp;
   private int N;
   private Trajectory [] trs;
   private float[] segms;
   
   CompTrajectory (Trajectory [] trst, float velt, boolean roundTript) {
     AjustTrajectories (trst);
     SetVelocity (velt);
     SetRoundTrip (roundTript);
   }
   
   CompTrajectory (Trajectory [] trst, float velt, boolean roundTript, int typet) {
     AjustTrajectories (trst);
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (typet);
   }
   
   // closeTrajectory
   
   public void AddCompTrajectory (CompTrajectory ctrt) {
     Trajectory [] trst = ctrt.GetTrajectories ();
     trst = (Trajectory []) concat (trs, trst);
     AjustTrajectories (trst);
   }
   
   public void AddCompTrajectory (CompTrajectory ctrt, int index) {
     Trajectory [] trst = ctrt.GetTrajectories ();
     trst = (Trajectory []) splice (trs, trst, index);
     AjustTrajectories (trst);
   }
   
   public void AddTrajectory (Trajectory trt) {
     Trajectory [] trst = (Trajectory []) append (trs, trt);
     AjustTrajectories (trst);
   }
   
   public void AddTrajectory (Trajectory trt, int index) {
     Trajectory [] trst = (Trajectory []) splice (trs, trt, index);
     AjustTrajectories (trst);
   }
   
   public void AddTrajectories (Trajectory [] trt) {
     Trajectory [] trst = (Trajectory []) concat (trs, trt);
     AjustTrajectories (trst);
   }
   
   public void AddTrajectories (Trajectory [] trt, int index) {
     Trajectory [] trst = (Trajectory []) splice (trs, trt, index);
     AjustTrajectories (trst);
   }
   
   private void AjustTrajectories (Trajectory [] trst) {
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
   
   // Poner de parámetro el tipo.
   public void CloseTrajectory () {
     if (!IsClose (2)) {
       Trajectory ctr = new LinealTrajectory2D (trs [N-1].GetEndPoint()[0], 
       trs [N-1].GetEndPoint()[1], trs [0].GetInitPoint()[0], trs [0].GetInitPoint()[1], 0, false);
       AddTrajectory (ctr);
     }
   }
   
   public float[] coord () {
     float[] ret = new float [2];
     tp = GetFunction ();
     if (GetSense()) {
       for (int i = 0; i < N; i++)
         if (segms [i] <= tp && tp <= segms [i+1]) {
           t1 = (tp-segms [i])/(segms [i+1] - segms [i]);
           ret[0] = trs [i].coord (t1, true)[0];
           ret[1] = trs [i].coord (t1, true)[1];
         }
     } else {
       for (int i = 0; i < N; i++)
         if (segms [i] <= 1-tp && 1-tp <= segms [i+1]) {
           t1 = ((1-tp)-segms [i])/(segms [i+1] - segms [i]);
           ret[0] = trs [i].coord (t1, true)[0];
           ret[1] = trs [i].coord (t1, true)[1];
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
           ret[0] = trs [i].coord (t1, true)[0];
           ret[1] = trs [i].coord (t1, true)[1];
         }
     } else {
       for (int i = 0; i < N; i++)
         if (segms [i] <= 1-tt && 1-tt <= segms [i+1]) {
           t1 = ((1-tt)-segms [i])/(segms [i+1] - segms [i]);
           ret[0] = trs [i].coord (t1, true)[0];
           ret[1] = trs [i].coord (t1, true)[1];
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
           ret[0] = trs [i].coord (t1, true)[0];
           ret[1] = trs [i].coord (t1, true)[1];
         }
     } else {
       for (int i = 0; i < N; i++)
         if (segms [i] <= 1-tt && 1-tt <= segms [i+1]) {
           t1 = ((1-tt)-segms [i])/(segms [i+1] - segms [i]);
           ret[0] = trs [i].coord (t1, true)[0];
           ret[1] = trs [i].coord (t1, true)[1];
         }
     }
     return ret;
   }
   
   // Función de añadir una o más.
   // Función de quitar.
   
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
 }