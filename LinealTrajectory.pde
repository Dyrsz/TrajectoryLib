class LinealTrajectory extends Trajectory {
   
   private float xi, xf;
   private float tp;
   
   LinealTrajectory (float xit, float xft, float velt, boolean roundTript) {
     xi = xit;
     xf = xft;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
   }
   
   LinealTrajectory (float xit, float xft, float velt, boolean roundTript, int ttype) {
     xi = xit;
     xf = xft;
     SetVelocity (velt);
     SetRoundTrip (roundTript);
     SetType (ttype);
   }
   
   public float CenDisNormalized () {
     return CenterDistance ()/(xi/2);
   }
   
   public float CenterDistance () {
     return abs ((xi+xf)/2 - coord1D ());
   }
   
   // Sorry for this:
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
   }
   
   public float CenDisNormalized () {
     return trX.CenDisNormalized ();
   }
   
   public float CenterDistance () {
     return trX.CenterDistance ();
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
   
   public float [] GetEndPoint () {
     float [] ret = {xf, yf};
     return ret;
   }
   
   public float[] GetInitPoint () {
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
 }