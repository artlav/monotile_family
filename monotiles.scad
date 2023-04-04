//Generating a family of aperiodic monotiles
//As per the paper here: https://arxiv.org/pdf/2303.10798.pdf
//Using the tile(a,b) notation from section 6

//Angles of each side
angs = [90,180,120,30,90,0,60,330,270,210,300,240,150];
thk=4;
side=10;

//Starting from 0,0 construct the tile by adding each distance at each angle
function point(i,dsts) = [
  (i<=0)?0:(point(i-1,dsts).x+sin(angs[i])*dsts[i]),
  (i<=0)?0:(point(i-1,dsts).y+cos(angs[i])*dsts[i])
]; 
 
 module tile(a,b) {
  //Normalize the size
  x=max(a,b);
  a=a/x;
  b=b/x;
  dsts=[a,b,b,a,a,b,b,a,2*a,a,b,b,a];   //Distances
  points = [ for (i = [0:12]) point(i,dsts) ];
  linear_extrude(thk) {
    scale(side) rotate(180) polygon(points);
  }
 }
 
 //Hat
 translate([0,0,0]) tile(1,sqrt(3));
 
 //Turtle
 translate([5*side,0,0]) tile(sqrt(3),1);
 
 //Whatevers
 translate([5*side,5*side,0]) tile(1,1.5*sqrt(3));
 translate([0,5*side,0]) tile(1,3.5*sqrt(3));

 