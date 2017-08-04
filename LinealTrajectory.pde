class LinealTrajectory extends Trajectory {
   
   private float xi, xf;
   private float tp;
   
   LinealTrajectory (float xit, float xft, float velt, boolean roundTript) {
     xi = xit;
     xf = xft;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     ActualizeBasics ();
   }
   
   LinealTrajectory (float xit, float xft, float velt, boolean roundTript, int ttype) {
     xi = xit;
     xf = xft;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
     ActualizeBasics ();
   }
   
   public float CalcMaxCenterDistance () {
     return xi/2;
   }
   
   public float CalcMaxCenterDistance (int i) {
     return xi/2;
   }
   
   public float CalcMinCenterDistance () {
     return 0;
   }
   
   public float CalcMinCenterDistance (int i) {
     return 0;
   }
   
   public float CenterDistance () {
     return abs ((xi+xf)/2 - coord1D ());
   }
   
   public float CenterDistance (float tt) {
     return abs ((xi+xf)/2 - coord1D (tt));
   }
   
   public float CenterDistance (float tt, boolean senset) {
     return abs ((xi+xf)/2 - coord1D (tt, senset));
   }
   
   // Sorry for all of this -1D functions:
   
   public float coord1D () {
     float ret;
     tp = GetFunction ();
     if (GetSense()) {
       ret = (1-tp)*xi + tp*xf;
     } else {
       ret = (1-tp)*xf + tp*xi;
     }
     return ret;
   }
   
   public float coord1D (float tt) {
     float ret;
     if (GetSense()) {
       ret = (1-tt)*xi + tt*xf;
     } else {
       ret = (1-tt)*xf + tt*xi;
     }
     return ret;
   }
   
   public float coord1D (float tt, boolean senset) {
     float ret;
     if (senset) {
       ret = (1-tt)*xi + tt*xf;
     } else {
       ret = (1-tt)*xf + tt*xi;
     }
     return ret;
   }
   
   public float GetCenter1D () {
     return (xi+xf)/2;
   }
   
   public float GetEndPoint1D () {
     return xf;
   }
   
   public float GetInitPoint1D () {
     return xi;
   }
   
   public float GetLength() {
     return xf-xi;
   }
   
   public String GetTrajectoryType () {
     return "Lineal1D";
   }
   
   public void SetEndPoint1D (float xft) {
     xf = xft;
     ActualizeBasics ();
   }
   
   public void SetInitPoint1D (float xit) {
     xi = xit;
     ActualizeBasics ();
   }
 }
 
 class LinealTrajectory2D extends Trajectory {
   
   private float xi, xf, yi, yf;
   private LinealTrajectory trX, trY;
   private float tp;
   
   LinealTrajectory2D (float xit, float yit, float xft, float yft, float velt, boolean roundTript) {
     xi = xit;
     xf = xft;
     yi = yit;
     yf = yft;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     trX = new LinealTrajectory (xi, xf, velt, roundTript);
     trY = new LinealTrajectory (yi, yf, velt, roundTript);
     ActualizeBasics ();
   }
   
   LinealTrajectory2D (float xit, float yit, float xft, float yft, float velt, boolean roundTript, int ttype) {
     xi = xit;
     xf = xft;
     yi = yit;
     yf = yft;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
     trX = new LinealTrajectory (xi, xf, velt, roundTript, ttype);
     trY = new LinealTrajectory (yi, yf, velt, roundTript, ttype);
     ActualizeBasics ();
   }
   
   public float CalcMaxCenterDistance () {
     return sqrt ((xi/2)*(xi/2)+(yi/2)*(yi/2));
   }
   
   public float CalcMaxCenterDistance (int i) {
     return sqrt ((xi/2)*(xi/2)+(yi/2)*(yi/2));
   }
   
   public float CalcMinCenterDistance () {
     return 0;
   }
   
   public float CalcMinCenterDistance (int i) {
     return 0;
   }
   
   public float CenterDistance () {
     return trX.CenterDistance ();
   }
   
   public float CenterDistance (float tt) {
     return trX.CenterDistance (tt);
   }
   
   public float CenterDistance (float tt, boolean senset) {
     return trX.CenterDistance (tt, senset);
   }
   
   public float[] coord () {
     tp = GetFunction ();
     float[] ret = new float [2];
     ret [0] = trX.coord1D (tp, GetSense());
     ret [1] = trY.coord1D (tp, GetSense());
     return ret;
   }
   
   public float[] coord (float tt) {
     float[] ret = new float [2];
     ret [0] = trX.coord1D (tt, GetSense());
     ret [1] = trY.coord1D (tt, GetSense());
     return ret;
   }
   
   public float[] coord (float tt, boolean senset) {
     float[] ret = new float [2];
     ret [0] = trX.coord1D (tt, senset);
     ret [1] = trY.coord1D (tt, senset);
     return ret;
   }
   
   public float[] GetCenter () {
     float [] ret = {trX.GetCenter1D (), trY.GetCenter1D ()};
     return ret;
   }
   
   public float [] GetEndPoint () {
     float [] ret = {xf, yf};
     return ret;
   }
   
   public float [] GetInitPoint () {
     float [] ret = {xi, yi};
     return ret;
   }
   
   public float GetLength() {
     float xl = xf-xi;
     float yl = yf-yi;
     return sqrt (xl*xl+yl*yl);
   }
   
   public String GetTrajectoryType () {
     return "Lineal2D";
   }
   
   public LinealTrajectory GetTrajectoryX () {
     return trX;
   }
   
   public LinealTrajectory GetTrajectoryY () {
     return trY;
   }
   
   public void Preview () {
     stroke (200);
     strokeWeight (3);
     line (xi, yi, xf, yf);
   }
   
   public void SetEndPoint (float [] pft) {
     if (pft.length == 2) {
       xf = pft [0];
       yf = pft [1];
       trX = new LinealTrajectory (xi, xf, GetVelocity (), IsRoundTrip(), GetType());
       trY = new LinealTrajectory (yi, yf, GetVelocity (), IsRoundTrip(), GetType());
       ActualizeBasics ();
     } else {
       println ("Bad input on LinealTrajectory.SetEndPoint ().");
     }
   }
   
   public void SetInitPoint (float [] pit) {
     if (pit.length == 2) {
       xi = pit [0];
       yi = pit [1];
       trX = new LinealTrajectory (xi, xf, GetVelocity (), IsRoundTrip(), GetType());
       trY = new LinealTrajectory (yi, yf, GetVelocity (), IsRoundTrip(), GetType());
       ActualizeBasics ();
     } else {
       println ("Bad input on LinealTrajectory.SetInitPoint ().");
     }
   }
 }