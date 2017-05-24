class Trajectory {
   
   private float vel, t, t0 = 0;
   private boolean roundTrip;
   private boolean sense = true, ntc = false;
   private int type = 1, n = 0, n0 = 0;
   // type:     0: sinusoidal.
   //        else: t=t0^type.
   private float mcd, Mcd;
   
   public void ActualizeBasics () {
     mcd = CalcMinCenterDistance ();
     Mcd = CalcMaxCenterDistance ();
   }
   
   public void ActualizeBasics (int precision) {
     mcd = CalcMinCenterDistance (precision);
     Mcd = CalcMaxCenterDistance (precision);
   }
   
   public float CalcMaxCenterDistance () {
     float ret = 0;
     float [] c = GetCenter();
     if (GetLength() > 5 && c != null) {
       float l = 5/GetLength ();
       float a, b, d;
       for (float fg = 0; fg <= 1; fg+= l) {
         a = c [0] - coord (fg, true)[0];
         b = c [1] - coord (fg, true)[1];
         d = a*a+b*b;
         if (d > ret) ret = d;
       }
       ret = sqrt (ret);
     } else {
       println ("Bad call on Trajectory.CalcMaxCenterDistance ().");
     }
     return ret;
   }
   
   public float CalcMaxCenterDistance (int precision) {
     float ret = 0;
     float [] c = GetCenter();
     if (precision > 0) {
       if (c != null) {
         float l = 1/float (precision);
         float a, b, d;
         for (float fg = 0; fg <= 1; fg+= l) {
           a = c [0] - coord (fg, true)[0];
           b = c [1] - coord (fg, true)[1];
           d = a*a+b*b;
           if (d > ret) ret = d;
         }
         ret = sqrt (ret);
       } else {
         println ("Bad call on Trajectory.CalcMaxCenterDistance (). No center.");
       }
     } else {
       println ("Bad input on Trajectory.CalcMaxCenterDistance ().");
     }
     return ret;
   }
   
   public float CalcMinCenterDistance () {
     float ret = 0;
     float [] c = GetCenter();
     if (GetLength() > 5 && c != null) {
       float l = 5/GetLength ();
       float a, b, d;
       for (float fg = 0; fg <= 1; fg+= l) {
         a = c [0] - coord (fg, true)[0];
         b = c [1] - coord (fg, true)[1];
         d = a*a+b*b;
         if (fg == 0) {
           ret = d;
         } else {
           if (d < ret) ret = d;
         }
       }
       ret = sqrt (ret);
     } else {
       println ("Bad call on Trajectory.CalcMinCenterDistance ().");
     }
     return ret;
   }
   
   public float CalcMinCenterDistance (int precision) {
     float ret = 0;
     float [] c = GetCenter();
     if (precision > 0) {
       if (c != null) {
         float l = 1/float (precision);
         float a, b, d;
         for (float fg = 0; fg <= 1; fg+= l) {
           a = c [0] - coord (fg, true)[0];
           b = c [1] - coord (fg, true)[1];
           d = a*a+b*b;
           if (fg == 0) {
             ret = d;
           } else {
             if (d < ret) ret = d;
           }
         }
         ret = sqrt (ret);
       } else {
         println ("Bad call on Trajectory.CalcMinCenterDistance (). No center.");
       }
     } else {
       println ("Bad input on Trajectory.CalcMinCenterDistance ().");
     }
     return ret;
   }
   
   public float CenDisMaxNormalized () {
     float ret = 0;
     if (GetMaxCenterDistance () != 0) {
       ret = CenterDistance ()/GetMaxCenterDistance ();
     } else {
       println ("Bad call on Trajectory.CenDisMaxNormalized (): Use Trajectory.ActualizeBasics () first.");
     }
     return ret;
   }
   
   public float CenDisNormalized () {
     float ret = 0;
     if (GetMaxCenterDistance () != 0) {
       if (GetMaxCenterDistance () > GetMinCenterDistance ()) {
         ret = CenterDistance ()/(GetMaxCenterDistance () - GetMinCenterDistance ());
       } else {
         ret = CenterDistance ();
       }
     } else {
       println ("Bad call on Trajectory.CenDisNormalized (): Use Trajectory.ActualizeBasics () first.");
     }
     return ret;
   }
   
   public float CenterDistance () {
     float [] cd = GetCenter ();
     float a = cd [0] - coord ()[0];
     float b = cd [1] - coord ()[1];
     return sqrt (a*a+b*b);
   }
   
   public float CenterDistance (float tt) {
     float [] cd = GetCenter ();
     float a = cd [0] - coord (tt)[0];
     float b = cd [1] - coord (tt)[1];
     return sqrt (a*a+b*b);
   }
   
   public float CenterDistance (float tt, boolean senset) {
     float [] cd = GetCenter ();
     float a = cd [0] - coord (tt, senset)[0];
     float b = cd [1] - coord (tt, senset)[1];
     return sqrt (a*a+b*b);
   }
   
   public float [] coord () {
     print ("Bad call: abstract function. Fail on Trajectory.coord ()");
     float [] ret = {0,0};
     return ret;
   }
   
   public float [] coord (float tt) {
     print ("Bad call: abstract function. Fail on Trajectory.coord (float).");
     float [] ret = {0,0};
     return ret;
   }
   
   public float [] coord (float tt, boolean senset) {
     print ("Bad call: abstract function. Fail on Trajectory.coord (float, boolean).");
     float [] ret = {0,0};
     return ret;
   }
   
   public float elevate (float a, int b) {
     float ret = 1;
     for (int i = 0; i < b; i++) ret = ret*a;
     return ret;
   }
   
   public float functype (int typ, float t0t) {
     float ret;
     if (typ == 0) {
       ret = sin (t0t);
     } else {
       ret = elevate (t0t, typ);
     }
     return ret;
   }
   
   public float[] GetCenter () {
     //float [] ret = {0, 0};
     print ("Bad call: abstract function. Fail on Trajectory.GetCenter ()");
     return null;
   }
   
   public float GetGuide () {
     return t0;
   }
   
   public float [] GetEndPoint () {
     float [] ret = {coord (1)[0], coord (1)[1]};
     return ret;
   }
   
   public float GetFunction () {
     return t;
   }
   
   public float[] GetInitPoint () {
     float [] ret = {coord (0)[0],coord (0)[1]};
     return ret;
   }
   
   public float GetLength() {
     print ("Bad call: abstract function. Fail on Trajectory.GetLength ().");
     return 0;
   }
   
   public float GetMaxCenterDistance () {
     return Mcd;
   }
   
   public float GetMinCenterDistance () {
     return mcd;
   }
   
   public int GetNumberTrips () {
     return n;
   }
   
   public boolean GetSense () {
     return sense;
   }
   
   public String GetTrajectoryType () {
     return "Null";
   }
   
   public int GetType () {
     return type;
   }
   
   public float GetVelocity () {
     return vel;
   }
   
   public boolean IsRoundTrip () {
     return roundTrip;
   }
   
   public boolean NumberTripsChange () {
     return ntc;
   }
   
   public boolean NumberTripsChange (int nt) {
     if (n == nt && ntc) {
       return true;
     } else {
       return false;
     }
   }
   
   public void OnDraw () {
     t0 += vel;
     if (t0 >= 1) {
       if (roundTrip) sense = !sense;
       t0 --;
       n++;
     }
     t = functype (type, t0);
     if (n != n0) {
       n0 = n;
       ntc = true;
     } else {
       ntc = false;
     }
   }
   
   public void Preview () {
     if (GetLength() > 5) {
       float l = 5/GetLength ();
       for (float fg = 0; fg <= 1; fg+= l) {
         noStroke ();
         fill (150);
         ellipse (coord (fg, true)[0], coord (fg, true)[1], 2, 2);
       }
     } else {
       println ("Bad preview.");
     }
   }
   
   public void Preview (int precision) {
     if (precision > 0) {
       float l = 1/float (precision);
       for (float fg = 0; fg <= 1; fg+= l) {
         noStroke ();
         fill (150);
         ellipse (coord (fg, true)[0], coord (fg, true)[1], 3, 3);
       }
     } else {
       println ("Bad input on Preview (int).");
     }
   }
   
   public void SetVelocity (float nvel) {
     vel = nvel;
   }
   
   public void SetRoundTrip (boolean nrt) {
     roundTrip = nrt;
   }
   
   public void SetSense (boolean nsense) {
     sense = nsense;
   }
   
   public void SetType (int ntype) {
     type = ntype;
   }
 }