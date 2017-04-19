 
 // Hacer una clase que ¿una? trayectorias lineales.
 // Recibe dos trayectorias lineales y devuelve una compuesta.
 /*
   Clase de trayectorias lineales compuestas, supongo.
   Como constructor admite tanto lineales como compuestas.
   Luego la clase de trayectoria poligonal sería fácil.
 */
 
 float [] gyre (float x, float y, float cx, float cy, float rad) {
   float[] ret = new float [2];
   x = x - cx;
   y = y - cy;
   ret [0] = x*cos(rad) - y*sin(rad) + cx;
   ret [1] = x*sin(rad) + y*cos(rad) + cy;
   return ret;
 }

 void polygon (int n, float cx, float cy, float r, float angle, color col) {
   float x1, y1, x2, y2;
   x1 = gyre (cx, cy-r, cx, cy, angle)[0];
   y1 = gyre (cx, cy-r, cx, cy, angle)[1];
   for (int i = 0; i < n; i++) {
     noStroke ();
     fill (col);
     ellipse (x1, y1, 5, 5);
     x2 = gyre (x1, y1, cx, cy, 2*PI/n)[0];
     y2 = gyre (x1, y1, cx, cy, 2*PI/n)[1];
     stroke (col);
     strokeWeight(10);
     line (x1,y1,x2,y2);
     x1 = x2;
     y1 = y2;
   }
 }
 
 class PolygonTrajectory extends Trajectory {
   
   //float cx, cy, r, 
   
 }