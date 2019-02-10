int sizeX = 1000;
int sizeY = 1000;
int numSlots1 = 500;
int numSlots2 = 600;
int numPins = numSlots2/100;

fallingBall bob = new fallingBall();
ArrayList<collisionBalls> dude = new ArrayList<collisionBalls>();
pins[] pinner = new pins[numPins];
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
  
  for(int i = 0; i < pinner.length; i++) {
    pinner[i] = new pins(500, 900); // creating pins 
  }
  
}

public void draw() {
  background(255);
  boolean changeMove = true;
  for (int i = 0; i < dude.size(); i++) {
    if (dist((float)bob.getX(), (float)bob.getY(), (float)dude.get(i).getX(), (float)dude.get(i).getY()) < 20) {
      changeMove = false; //if hits ball move it to the right by 25 or to the left by 25
      bob.setY(0);
      bob.move2();
    } else {
      changeMove = true;
    }
  }

  if (changeMove) {
    bob.setY(0.8);
    bob.move();
  }
  //set Y value to 0 if the circle touches the other one yoooooo fire emoji
  // falls down, if it touches a circle, stop, move either to the right or left , repeat
  // make sure it doesnt go over the border(create boundries)
  // create the slots
  bob.show();
  for (int i = 0; i < dude.size(); i++) {
    dude.get(i).show();
  }
}



class fallingBall {
  private double gravity;
  private double x, y, r;
  private int change;
  public fallingBall() {
    gravity = 0.8;
    x = sizeX/2;
    y = sizeY/4 - 100;
    r = 25;
    change = 50;
  }
  public fallingBall(int a, int s, int d) {
    gravity = 0.8;
    x = a;
    y = s;
    r = d;
  }
  public void move() {
    if (y <= sizeY) {
      y+=gravity; /// moves down by the gravity
    }
  }

  public void move2() {
    double randomChance = Math.random();
   
      if (randomChance >= .5) {
        x-=change;
      } else {
        x+=change;
      }
    if(x <= 200) {
      x+=change;
    }
    if(x >= 600) {
      x-=change;
    }
    
  }

  public void show() {
    ellipse((float)x, (float)y, (float)r, (float)r);
  }
  public double getY() { 
    return y;
  }
  public double getX() { 
    return x;
  }
  public void setY(double Y) { 
    gravity = Y;
  }
}

class collisionBalls {
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



class pins {
  
  private int x, y, r;
  private int randomNum;
  public pins() { return;}
  public pins(int a, int b) {
    x = a;
    y = b;
    r = 50;
    randomNum =(int)(Math.random()*100);
  }
  
  
  public void show() {
  //two lines on each side
  // a rectangle base
  // a transparent number
  rect(x, y*2,x + r, y + r);
  
    
  }
  
  public int getRand() { return randomNum;} 
  
}
    
