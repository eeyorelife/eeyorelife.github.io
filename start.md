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

But we want more. We are not happy with an empty canvas and an empty world. We want to fill the world with flowers and trees that wave in the wind. We want unicorns running to and fro, chasing the double raindow that moves across the sky! But hold your horses, err unicorns. Before we can fill the world we've created, we need to be let in on a few _[secrets](Secrets)_.
