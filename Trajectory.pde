class Trajectory {
   
   private float vel, t, t0 = 0;
   private boolean roundTrip;
   private boolean sense = true, ntc = false;
   private int type = 1, n = 0, n0 = 0;
   // type:     0: sinusoidal.
   //        else: t=t0^type.
   
   public float [] coord () {
     print ("Bad call: abstract function. Code A.");
     float [] ret = {0,0};
     return ret;
   }
   
   public float [] coord (float tt) {
     print ("Bad call: abstract function. Code B.");
     float [] ret = {0,0};
     return ret;
   }
   
   public float [] coord (float tt, boolean senset) {
     print ("Bad call: abstract function. Code C.");
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
   
   public float GetGuide () {
     return t0;
   }
   
   public float [] GetEndPoint () {
     print ("Bad call: abstract function. Code D.");
     float [] ret = {0, 0};
     return ret;
   }
   
   public float GetFunction () {
     return t;
   }
   
   public float[] GetCenter () {
     print ("Bad call: abstract function. Code E.");
     float [] ret = {0,0};
     return ret;
   }
   
   public float[] GetInitPoint () {
     print ("Bad call: abstract function. Code F.");
     float [] ret = {0,0};
     return ret;
   }
   
   public float GetLength() {
     print ("Bad call: abstract function. Code G.");
     return 0;
   }
   
   public int GetNumberTrips () {
     return n;
   }
   
   public boolean GetRoundTrip () {
     return roundTrip;
   }
   
   public boolean GetSense () {
     return sense;
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
         ellipse (coord (fg, true)[0], coord (fg, true)[1], 3, 3);
       }
     } else {
       println ("Bad preview.");
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