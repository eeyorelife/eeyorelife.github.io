# Box2D for dummies

Ok, so I'll try to go through this step by step in a way that makes sense. The "making sense" part is definitely the hardest part. And because programming is such a spesific language, I will not hesitate to show you a runnable snippet of code. I will not leave anything in the gray area. So as soon as I've been through enough steps to be able to make a rannuble sketch out of it, I will do that.

```
import shiffman.box2d.*;
Box2DProcessing box2d;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}
```

## AND WE ARE OFF
_to an amazing start!_ The code works, it's short, it's runnable and it does absolutely nothing what so ever!
Ok, it does something. And it is in fact a great place to start. This is the minimal possible code you need to make a Box2D world.So what is happening here? We start off by importing the library: `import shiffman.box2d.*;` So that we get access to that oh so sweet Box2D code. Next, we initialize the Box2D class: `Box2DProcessing box2d;` because we need this to create our Box2D World: `box2d.createWorld();`. But before we do that, we need to make an instance of that box2d class: `box2d = new Box2DProcessing(this);`

But we want more. We are not happy with an empty canvas and an empty world. We want to fill the world with flowers and trees that wave in the wind. We want unicorns running to and fro, chasing the double raindow that moves across the sky! But hold your horses, err unicorns. Before we can fill the world we've created, we need to be let in on a few _secrets_.

### The secrets

1. Box2D is a comlicated world. It is not all flowers and unicorns chasing the rainbow. Box2D has _forces_ like _gravity_ and every single object needs to have a _body_ and a _shape_, and the body and the shape _**isn't even the same thing**_, we need to join them with a _fixture_. An we need to specify all of this for _every single object in the Box2D world_
2. Box2D and Processing does not agree on coordinates. While Box2D is still hung up on that old fashioned _Cartesian_ coordiante system, Processing has moved on to the new and improved _computer graphics_ coordinate system. What does that mean? It means that `0,0,`in processing is in the top left corner, while Box2D places `0,0` _in the middle of the screen_. But, that's not it. It get's worse. If you are familiar with processing, you know that the y-axis moves _downwards_, so the higher the y value, the lower you find yourself on the axis. But in Box2D it is apparently logical to move _up_ the y-axis by increasing the y value?
3. I hope you didn't rage quit over that coordinate issue above, because there is an solution. Luckily, Box2D knows how silly it is to stick to that old cartesion coordinate system. Therefore, it has included a set of functions that we can use to translate coordinates between the Box2D world and the processing window (we'll go through them later).
4. Processing and Box2D does not agree on vectors. Processing has a vector class: `PVector`, but Box2D has its own vector class: `Vec2`. But this isn't really a big deal, Box2D is doing all the calculations for us, the least we could do is to use it's own vector class.
5. Every object in Box2D is one of three types: **Dynamic**, which means it collides with everything and moves around with the physics. **Static** Which means it won't budge. **Kinematic**, Which means it can be manipulated by manually by the user. It does not collide with static objects or Kinematic objects.

I think that was it actually. For now at least.

## The steps to becoming an object

Ok, so now that we know some of the secrets, we can start filling our world with all sorts of things. But let's not get too excited. We will start with a box, as that is difficult enough for a start. In order to make a box, we first need to import some more code. Because importing the library apparently isn't enough. I am not very well known with libraries, so I cannot tell you exactly what these lines of codes does, but I am positive that we need them:

```
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
```
So, keeping my promise, here is the whole sketch as it is for now:
```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}
```
Woah, it still does nothing! That's _amazing_! Ok, ok calm down. We haven't actually done anything yet. We have just imported some more code that allow us to create a _body_, a _shape_ and to make them interact with the world. 

### The body
The _body_ is the **soul** of the object. What? If it is the soul, then why is it called body? Does not a soul live inside a body? Ok, maybe it isn't the most accurate name, but it works, ok? It does the job. So what do we need to define a body? We need to know its position and its bodytype. So **let's do it!**

We start by initializing the body: `Body body;` Done. Now, we need to define the body by using the `BodyDef` class: `BodyDef bd = new BodyDef();` And set it's position: `bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));` Remember the issue with the coordinate systems? When we want to set a coordinate in the Box2D world, we convert from Processing to Box2D coordinates like this: `coordPixelsToWorld(x,y)` and if we want to go the other way we do this: `coordWorldToPixels(x,y)` One can also use a vector instead of floats: `coordPixelsToWorld(vec2)`, and `coordWorldToPixels(vec2)`. When we have set the coordinates, we can select a type: `bd.type = BodyType.DYNAMIC`. Now that the body is defined, we can put it create it like this: `body = box2d.createBody(bd);`
So, putting it all together:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body body;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));
  bd.type = BodyType.DYNAMIC;
  
  body = box2d.createBody(bd);
}
```

You can't see it, but it is there! Our body, does not have a shape. It is a lonely soul without a human to inhabit. It has coordinates, but nothing else. We ned to create a shape

### The shape
What do we need to define a shape? We need to know what kind of shape we want to create and it's size. First, we make width and height variables like we are used to in Processing: `float w = 16, h = 16;`. Then we use the ´PolygonShape()´ class to create a new shape: `PolygonShape ps = new PolygonShape();` And then we set it as a box: `ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));`. Remember that coordinate problem? yes, that applies to size as well. So we need to use the function `scalarPixelsToWorld` to convert from Processing to Box2D. Also, why are we dividing width and height by 2? Because Box2D defines width as the distance from the center to the edge. Almost like a radius in a circle. Don't ask me how that makes sense. So the width will be half of the actual width of the body. And before we throw it all together we connect the body and the shape with a fixture. For now, I think it's ok if Box2D just creates a default fixture for us: `body.createFixture(ps,1);` Throwing it all together again:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body body;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));
  bd.type = BodyType.DYNAMIC;
  
  body = box2d.createBody(bd);
  
  PolygonShape ps = new PolygonShape();
  ps.SetAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
  
  body.createFixture(ps,1);
}
```

Lok at that! We have a bogy, we have a shape, we have a fixture! But we still can't see it... How do we know where it is? Box2D does all the calcutation, so it holds all the information. Where everything is and where it is headed. So what do we do? We ask for it: `Vec2 pos = box2d.getBodyPixelCoord(body);`. And then we can use that information to draw it: `rect(pos.x, pos.y, w,h);` But it doesn't move? Why is it not reacting to any forces? Because time is standing still. That's right, we have to step through _time_: `box2d.step();` Oh, and we will have to change the reectMode: `rectMode(CENTER);`

Now, we can see it move:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body body;

float w = 16, h = 16;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));
  bd.type = BodyType.DYNAMIC;
  
  body = box2d.createBody(bd);
  
  PolygonShape ps = new PolygonShape();
  ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
  
  body.createFixture(ps,1);
}

void draw(){
  box2d.step();
  rectMode(CENTER);
  Vec2 pos = box2d.getBodyPixelCoord(body);
  rect(pos.x, pos.y, w,h);
}
```
WE MADE IT! We have a body, a shape, a fixture, and we can see it! It's a box! That was a lot of work just for a little rectangle falling off the screen. Let's make another one! But, lets try to make a static border on the bottom of the screen:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body box;
Body border;

float w = 16, h = 16;
float w1; //I want this to be the width of the screen, so we have to assign the value in setup()

void setup() {
  size(600, 400); //let's give ourselves some more space
  w1 = width;

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  BodyDef bd = new BodyDef();
  bd.position.set(box2d.coordPixelsToWorld(width/2, height/2));
  bd.type = BodyType.DYNAMIC;
  box = box2d.createBody(bd);
  PolygonShape ps = new PolygonShape();
  ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
  box.createFixture(ps, 1);


  BodyDef bd1 = new BodyDef();
  bd1.position.set(box2d.coordPixelsToWorld(width/2, height-(h/2))); //I want it to be at the bottom.
  bd1.type = BodyType.STATIC; //THis one needs to be static
  border = box2d.createBody(bd1);
  PolygonShape ps1 = new PolygonShape();
  ps1.setAsBox(box2d.scalarPixelsToWorld(w1/2), box2d.scalarPixelsToWorld(h/2)); //remember to use the right variable for width
  border.createFixture(ps, 1);
}

void draw() {
  box2d.step();
  rectMode(CENTER);
  Vec2 pos = box2d.getBodyPixelCoord(box);
  rect(pos.x, pos.y, w, h);
  
  
  Vec2 pos1 = box2d.getBodyPixelCoord(border);
  rect(pos1.x, pos1.y, w1, h);
}
```

Ok, this is very quickly going to get very messy. In fact, it is alreaddy very messy. So let's make a couple of classes and do it again:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;

Box box;
Border border;

void setup() {
  size(600, 400);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  box = new Box(width/2, height/2, 16, 16);
  border = new Border(width/2, height-8, width, 16);
}

void draw() {
  background(50);
  box2d.step();

  box.display();
  border.display();
}

class Border {

  Body border;

  float w, h;

  Border(float x, float y, float iw, float ih) {
    w = iw;
    h = ih;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.STATIC;
    border = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();

    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));
    border.createFixture(ps, 1);
  }

  void display() {
    rectMode(CENTER);
    fill(0);
    Vec2 pos = box2d.getBodyPixelCoord(border);
    rect(pos.x, pos.y, w, h);
  }
}


class Box {

  Body box;

  float w, h;

  Box(float x, float y, float iw, float ih) {
    w = iw;
    h = ih;

    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.DYNAMIC;
    box = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    
    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(w/2));
    box.createFixture(ps, 1);
  }

  void display() {
    rectMode(CENTER);
    fill(200);
    Vec2 pos = box2d.getBodyPixelCoord(box);
    rect(pos.x, pos.y, w, h);
  }
}
```

Ok, nothing really changed, except that we now have two classes. How is that better? Well, making an instance of a class is much easier and faster to do than to hard code every single object in the world. So that's the basics of Box2D. Happy coding

