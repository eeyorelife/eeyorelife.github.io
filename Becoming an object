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

We start by initializing the body: `Body body;` Done. Now, we need to define the body by using the `BodyDef` class: `BodyDef bd = new BodyDef();` And set it's position: `bd.position.set(box2d.coordPixelsToWorld(width/2,height/2));` When we have set the coordinates, we can select a type: `bd.type = BodyType.DYNAMIC`. Now that the body is defined, we can create it like this: `body = box2d.createBody(bd);`
So, putting it all together:

```
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;
Body body; //Initializing the body

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  BodyDef bd = new BodyDef(); //Getting ready to define a new body
  bd.position.set(box2d.coordPixelsToWorld(width/2,height/2)); // set the position of the body
  bd.type = BodyType.DYNAMIC; //decide which bodytype we want. The three posibilities are dynamic, static and kinematic
  
  body = box2d.createBody(bd);
}
```

You can't see it, but it is there! Our body, does not have a shape. It is a lonely soul without a box to inhabit. It has coordinates, but nothing else. [We ned to create a shape](The Shape)
