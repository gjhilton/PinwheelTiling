import processing.pdf.*;

void setup() {
  size(2000, 1000, PDF, "pinwheel.pdf");
  background(204);
  noLoop();
}

void draw() {
  render(subdivide(subdivide(subdivide(subdivide(subdivide(makeInitialTriangles(0,0,height)))))));
  exit();
}

ArrayList<Point[]> makeInitialTriangles(float originx, float originy, float dimension) {
  ArrayList<Point[]> triangle = new ArrayList<Point[]>();
  triangle.add(new Point[] {new Point(0,0),new Point(dimension*2,dimension),new Point(0,dimension)});
  triangle.add(new Point[] {new Point(dimension*2,dimension),new Point(0,0),new Point(dimension*2,0)});
  return triangle;
}

ArrayList<Point[]> subdivide(ArrayList<Point[]> triangles){
 ArrayList<Point[]> subdivisions = new ArrayList<Point[]>();
 
 for(Point[] inputTriangle: triangles){
   
   // alpha
   //  |
   //  |
   //  |
   //  |
   //  _______________
   // gamma            beta
   
   Point alpha = inputTriangle[0];
   Point beta = inputTriangle[1];
   Point gamma = inputTriangle[2];
   
   Point a = scaleVector(alpha, beta, 1.0/5);
   Point b = scaleVector(alpha, beta, 3.0/5);
   Point c = scaleVector(gamma, beta, 0.5);
   Point d = scaleVector(gamma, a, 0.5);

   subdivisions.add(new Point[] {alpha, gamma, a});
   subdivisions.add(new Point[] {c,a,b});
   subdivisions.add(new Point[] {a,c,d});
   subdivisions.add(new Point[] {gamma,c,d});
   subdivisions.add(new Point[] {c,beta,b});
 }
 return subdivisions; 
}

Point scaleVector(Point pStart, Point pEnd, float scaleFactor) {
  float vecX = pEnd.x - pStart.x;
  float vecY = pEnd.y - pStart.y;
  Point p = new Point(pStart.x + (vecX * scaleFactor) ,pStart.y + (vecY * scaleFactor));
  return p;
}

void render(ArrayList<Point[]> triangles){
  for(Point[] vertices: triangles){
    beginShape(TRIANGLE_STRIP);
    for (int v = 0; v < 3 ; v++) {
      vertex(vertices[v].x, vertices[v].y); 
    }
    endShape();
  }
}

class Point {
  float x,y; 
  Point(float px, float py) {
    x = px; y = py;
  }
}  
