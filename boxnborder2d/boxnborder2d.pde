import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;

Box box;
ArrayList <Box> boxes = new ArrayList<Box>();
Border border;

void setup() {
  size(600, 400);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  box = new Box(width/2, height/2, 16, 16);
  border = new Border(width/2, height-8, width, 16);
  //boxes.add(new Box(width/2, height-16, 16, 16));
  //boxes.add(new Box(width/2+6, height-38, 12, 12));
  //boxes.add(new Box(width/2-6, height-38, 12, 12));
}

void draw() {
  background(50);
  box2d.step();

  box.display();
  border.display();
  for (Box b : boxes) {
    b.display();
  }
}