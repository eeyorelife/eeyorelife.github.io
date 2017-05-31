# Box2D for dummies

Ok, so I'll try to go through this step by step in a way that makes sense. The "making sense" part is definitely the hardest part.

`import shiffman.box2d.*;
Box2DProcessing box2d;

void setup(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}`

## AND WE ARE OFF
_to an amazing start!_ The code works, it's short, it's runnable and it does absolutely nothing what so ever!
Ok, it does something. And it is in fact a great place to start. This is the minimal possible code you need to make a Box2D world.
**So what is happening here?** We start off by importing the library: `import shiffman.box2d.*;` So that we get access to that oh so sweet Box2D code
Next, we initialize the Box2D class: `Box2DProcessing box2d;` because we need this to create our Box2D World: `box2d.createWorld();`.



We then make an instance of that 
