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



