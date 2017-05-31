# Box2D for dummies

Ok, so I'll try to go through this step by step in a way that makes sense. The "making sense" part is definitely the hardest part.

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
Ok, it does something. And it is in fact a great place to start. This is the minimal possible code you need to make a Box2D world.

So what is happening here? We start off by importing the library: `import shiffman.box2d.*;` So that we get access to that oh so sweet Box2D code. Next, we initialize the Box2D class: `Box2DProcessing box2d;` because we need this to create our Box2D World: `box2d.createWorld();`. But before we do that, we need to make an instance of that box2d class: `box2d = new Box2DProcessing(this);`

But we more. We are not happy with an empty canvas and an empty world. We want to fill the world with flowers and trees that wave in the wind. We want unicorns running to and fro, chasing the double raindow that moves across the sky! But hold your horses, or unicorns, maybe. Before we can fill our newly created world, we need to be let in on a few _secrets_.

### The secrets

1. Box2D is a comlicated world. It is not all flowers and unicorns chasing the rainbow. Box2D has _forces_ like _gravity_ and every single object needs to have a _body_ a _shape_ and the body and the shape _**isn't even the same thing**_, we need to join them with a _fixture_. An we need to specify all of this for _every single object in the Box2D world_
2. Box2D and Processing does not agree on coordinates. While Box2D is still hung up on that old fashioned _Cartesian_ coordiante system, Processing has moved on to the new and improved _computer graphics_ coordinate system. What does that mean? It means that `0,0,`in processing is in the top left corner, while in Box2D places `0,0` _in the middle of the screen_. But, that's not it. It get's worse. If you are familiar with processing, you know that the y-axis moves _downwards_, so the higher the y value, the lower you find yourself on the axis. But in Box2D it is apparently logical to move _up_ the y-axis by increasing the y value?
3. I hope you didn't rage quit over that coordinate issue above, because there is an solution. Luckily, Box2D knows how silly it is to stick to that old cartesion coordinate system. Therefore, it has included a set of functions that we can use to translate coordinates between the Box2D world and the processing window (we'll go through them later).
I think that was it actually. For now at least.


