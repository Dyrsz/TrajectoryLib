class Trajectory {
   
   private float vel, t, t0 = 0;
   private boolean roundTrip;
   private boolean sense = true, ntc = false;
   private int type = 1, n = 0, n0 = 0;
   // type: function: t=t0^type.
   
   public float [] coord () {
     print ("Bad call: abstract function");
     float [] ret = {0,0};
     return ret;
   }
   
   public float [] coord (float tt) {
     print ("Bad call: abstract function");
     float [] ret = {0,0};
     return ret;
   }
   
   public float [] coord (float tt, boolean senset) {
     print ("Bad call: abstract function");
     float [] ret = {0,0};
     return ret;
   }
   
   public float elevate (float a, int b) {
     float ret = 1;
     for (int i = 0; i < b; i++) ret = ret*a;
     return ret;
   }
   
   public float functype (int typ, float t0t) {
     return elevate (t0t, typ);
   }
   
   public float [] GetEndPoint () {
     print ("Bad call: abstract function");
     float [] ret = {0, 0};
     return ret;
   }
   
   public float GetFunction () {
     return t;
   }
   
   public float[] GetInitPoint () {
     print ("Bad call: abstract function");
     float [] ret = {0,0};
     return ret;
   }
   
   public float GetLength() {
     print ("Bad call: abstract function");
     return 0;
   }
   
   public int GetNumberTrips () {
     return n;
   }
   
   public boolean GetSense () {
     return sense;
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