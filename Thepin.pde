int sizeX = 1000; //size of the canvas
int sizeY = 1000; //size of the canvas
int numSlots1 = 500; // static ball limit (goes by hundreds)
int numSlots2 = 600; // static ball limit (goes by hundreds)
int numPins = numSlots2/100; // should give you the number of pins based off the num of Slots
double gravity = 0.8; // global gravity var

fallingBall bob = new fallingBall(); //creates the falling ball
ArrayList<collisionBalls> dude = new ArrayList<collisionBalls>(); // creates an array of the static balls
pins[] pinner = new pins[numPins]; // creates pins ( dependent on numSlots )
public void setup() {
  size(1000, 1000);
  for (int x = 0; x <= numSlots1; x+=100) { // creates a grid of balls
    for (int y = 0; y <= numSlots1; y+=100) { 
      dude.add(new collisionBalls( 250 + x, 300 +y));
    }
  }
  for (int x = 0; x <= numSlots2; x+=100) { // creates a grid of balls
    for (int y = 0; y <= numSlots2; y+=100) { 
      dude.add(new collisionBalls( 200 + x, 250 +y));
    }
  }
  
  for(int i = 0; i < pinner.length; i++) {   //creates pins based off the number of static balls
    pinner[i] = new pins(i * 100 + 200, 850);
    // creating pins 
  }
  
}

public void draw() {
  background(255);
  //COLLISION WITH FALLINGBALL AND STATIC BALLS 
  boolean changeMove = true;
  for (int i = 0; i < dude.size(); i++) {
    if (dist((float)bob.getX(), (float)bob.getY(), (float)dude.get(i).getX(), (float)dude.get(i).getY()) < 20) {
      changeMove = false; //if hits ball move it to the right by 25 or to the left by 25
      bob.setGravity(0);
      bob.move2();
    } else {
      changeMove = true;
    }
  }
for(int i = 0; i < pinner.length; i++) {
  pinner[i].show(); // creates slots
}
      
  //COLLISION WITH FALLINGBALL AND PINSLOTS
  for (int i =0; i < pinner.length; i++) {
    if(dist((float)bob.getX(), (float)bob.getY(), (float)pinner[i].getX(), (float)pinner[i].getY()) < 20) {
      changeMove = false; // sets it false so it doesnt constantly change the gravity back to its original
      bob.setGravity(0); // stops the ball from moving downwards
      text("Your ball landed on..." + pinner[i].getRand(), 10, 100); // a text that will show you the number that it landed on 
		} 
	}
  
  
  
  
  if (changeMove) { //when true, will set the gravity to the global variable "gravity"
    bob.setGravity(gravity); //this logic allows the ball to move constantly when nothing is touching it
    bob.move(); // implements the ball to move with the gravity given
  }
  
  bob.show(); // shows the falling ball
  for (int i = 0; i < dude.size(); i++) {
    dude.get(i).show(); //shows the static balls
  }
}

//fix gravityE and gravity on draw and fallingball

class fallingBall {
  private double gravity; // declaring variables
  private double x, y, r;
  private int change;

  public fallingBall() {
    
    gravity = 0.8; //initializing...
    x = sizeX/2;
    y = sizeY/4 - 100;
    r = 25;
    change = 50;
    
  }
  public fallingBall(int a, int s, int d) { //This is an unnecessary (provisional) argument constructer that would be used to make multiple falling balls
    gravity = 0.8; 
    x = a;
    y = s;
    r = d;
  }
  public void move() { // moves the ball
    if (y <= sizeY) {
      y+=gravity; /// moves down by the gravity
    }
  }

  public void move2() { //moves the ball left or right depending on chance
    double randomChance = Math.random();
   // this determines wether the ball will move left or right with a 50 percent chance
      if (randomChance > .5) { 
        x-=change;
      } else {
        x+=change;
      }
    if(x <= 150) {
      x+=change;
      x+=change;
    }
    if(x >= 850) {
      x-=change;
      x-=change;
    }
    
  }

  public void show() { //a function to show the ball
    ellipse((float)x, (float)y, (float)r, (float)r);
  }
  public double getY() { 
    return y;
  }
  public double getX() { 
    return x;
  }
  public void setY(double t) { //sets y value (for mousepressed)
    y = t;
  }   
  public void setX(double lol) { //sets x value (for mousepressed)
    x = lol;
  }
 
  public void setGravity(double Y) { 
    gravity = Y;
  }
  public double getGravity() { return gravity; }
}

class collisionBalls { //creates the static balls
  private int x, y;
  public int getX() { 
    return x;
  }
  public int getY() { 
    return y;
  }
  public collisionBalls(int X, int Y) {
    x = X;
    y = Y;
  }
  public void show() {
    ellipse(x, y, 20, 20);
  }
}



class pins { //creates pins with the random texts in each of them
  
  private int x, y, r;
  private int randomNum;
  private int rectY;
  public pins() { return;}
  public pins(int a, int b) {
    x = a;
    y = b;
    r = 50;
		rectY = y + r * 2;
    randomNum =(int)(Math.random()*100);
  }
  
  
  public void show() {
  
	stroke(0,255,0);
  line(x,y ,x, y + 95);  
  rect(x, rectY, 100 , 10);
  line(x + 100, y, x + 100, y + 95);
    textSize(32);
    text(randomNum, x + 20, y + 50);
    fill(0,255,0);
  }
  public int getX() { return x + 50; }
  public int getY() { return rectY; }
  public int getRand() { return randomNum;} 
  public void setRand(int x) { randomNum = x; }
  
}


public void mousePressed() {
  
  bob.setY(sizeY/4 - 100);
  bob.setX(sizeX/2);
  for(int i = 0; i < pinner.length; i++) {
    pinner[i].setRand((int)(Math.random()*100));
  }
}
