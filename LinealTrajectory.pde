class LinealTrajectory extends Trajectory {
   
   float xi, xf;
   
   LinealTrajectory (float xit, float xft, float velt, boolean roundTript) {
     xi = xit;
     xf = xft;
     vel = velt;
     roundTrip = roundTript;
   }
   
   LinealTrajectory (float xit, float xft, float velt, boolean roundTript, int ttype) {
     xi = xit;
     xf = xft;
     vel = velt;
     roundTrip = roundTript;
     type = ttype;
   }
   
   float CenDisNormalized () {
     return CenterDistance ()/(xi/2);
   }
   
   float CenterDistance () {
     return abs ((xi+xf)/2 - coord ());
   }
   
   float coord () {
     float ret;
     if (!roundTrip) {
       ret = (1-t)*xi + t*xf;
     } else {
       if (sense) {
         ret = (1-t)*xi + t*xf;
       } else {
         ret = (1-t)*xf + t*xi;
       }
     }
     return ret;
   }
 }