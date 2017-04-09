class CircularTrajectory extends Trajectory {
   
   float cx, cy, r, radI, radF;
   
   CircularTrajectory (float cxt, float cyt, float rt, float velt, boolean roundTript) {
     cx = cxt;
     cy = cyt;
     r = rt;
     radI = 0;
     radF = 2*PI;
     vel = velt;
     roundTrip = roundTript;
   }
   
   CircularTrajectory (float cxt, float cyt, float rt, float velt, boolean roundTript, int ttype) {
     cx = cxt;
     cy = cyt;
     r = rt;
     radI = 0;
     radF = 2*PI;
     vel = velt;
     roundTrip = roundTript;
     type = ttype;
   }
   
   CircularTrajectory (float cxt, float cyt, float rt, float radIt, float radFt, float velt, boolean roundTript) {
     cx = cxt;
     cy = cyt;
     r = rt;
     radI = radIt;
     radF = radFt;
     vel = velt;
     roundTrip = roundTript;
   }
   
  CircularTrajectory (float cxt, float cyt, float rt, float radIt, float radFt, float velt, boolean roundTript, int ttype) {
     cx = cxt;
     cy = cyt;
     r = rt;
     radI = radIt;
     radF = radFt;
     vel = velt;
     roundTrip = roundTript;
     type = ttype;
   }
   
   float[] coord () {
     float[] ret = new float [2];
     if (!roundTrip) {
       ret[0] = r*sin (t*(radF-radI) + radI) +cx;
       ret[1] = r*cos (t*(radF-radI) + radI) +cy;
     } else {
       if (sense) {
         ret[0] = r*sin (t*(radF-radI) + radI) +cx;
         ret[1] = r*cos (t*(radF-radI) + radI) +cy;
       } else {
         ret[0] = r*sin (-t*(radF-radI) + radF) +cx;
         ret[1] = r*cos (-t*(radF-radI) + radF) +cy;
       }
     }
     return ret;
   }
 }