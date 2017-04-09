class Trajectory {
   
   float vel, t, t0;
   boolean roundTrip;
   boolean sense = true; // Auxiliary.
   int type = 1, n = 0;
   // type: function: t^type.
   
   public float elevate (float a, int b) {
     float ret = 1;
     for (int i = 0; i < b; i++) ret = ret*a;
     return ret;
   }
   
   public float functype (int typ, float t0t) {
     return elevate (t0t, typ);
   }
   
   public float GetFunction () {
     return t;
   }
   
   public int GetNumberTray () {
     return n;
   }
   
   public void OnDraw () {
     t0 += vel;
     if (t0 >= 1) {
       if (roundTrip) sense = !sense;
       t0 --;
       n++;
     }
     t = functype (type, t0);
   }
   
   public void OnSetup () {
     t0 = 0;
   }
 }