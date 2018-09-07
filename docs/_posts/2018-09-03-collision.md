---
title: "Creating Collisions"
date: 2018-09-03
category: code
gallery:
    - url: /assets/img/collision/bombMan.jpg
      image_path: assets/img/collision/bombMan.jpg
      title: "Regular BombMan Stage"
    - url: /assets/img/collision/bombManCollision.jpg
      image_path: assets/img/collision/bombManCollision.jpg
      title: "BombMan Stage collision image"
---
## Stop walking through Walls!
Currently our player has the incredible ability to walk through obstacles, unfortunately this makes for a pretty boring platformer. In this post I'll set up player collisions that allow us to navigate the map.

To define our world collisions I decided to create a second image that blacks out any areas we could collide with.

{% include gallery caption="The two images for Bomb Man's Stage." %}

With this image we will load it in our `BombStage` and use Processing's `get()` function to check if pixels at certain coordinates are black. All of our Level's will need a collision image so we can simply add another instance variable to every `Level`.

{% highlight java linenos %}
abstract class Level {
    PImage bgImg;
    PImage collisionImg;
    PVector pos;

    abstract void drawLevel();
}

class BombStage extends Level {
    BombStage() {
        bgImg = loadImage("stages/bombMan.jpg");
        collisionImg = loadImage("stages/bombManCollision.jpg");
        pos = new PVector(13, 990);
    }
}
{% endhighlight %}

Now we have loaded our collision image and it is ready to be used.

## Player Collisions
Now that our world has it's collision areas defined, it's time to figure out where the player collides with the world.

### Feet Collisions
Our player's feet is one of our most important collision checks because it prevents us from falling through the map and allows us to stand on platforms.

In the original game we can see that our player can stand on their right foot as long as the 4th pixel from the edge is still on the platform, on the left they need 5.
{% include figure image_path="/assets/img/collision/feetCollision.png" alt="Feet Collisions" caption="Foot collisions while standing on platform" %}

To perform these checks, a few modifications to our Player class will allow for our player to stand on the platforms.
{% highlight java linenos %}
class Player { 

  void move() {
    boolean onGround = false;
  
    if (!checkCollisionSouth(pos)) {
      velocity.y += 0.5; //Gravity if we are not at bottom of screen
    } else {
      velocity.y = 0;
      playerState = state.STAND;
      onGround = true;
    }

    if (onGround && up != 0) {
      velocity.y = -jumpSpeed;
    }

    velocity.x = walkSpeed * (left + right);

    if (!onGround) {
      playerState = state.JUMP;
    } else if (right != 0 || left != 0) {
      playerState = state.WALK;
    }

    PVector futurePos = new PVector(pos.x, pos.y);
    futurePos.add(velocity);

    if (futurePos.x > 0  && futurePos.x < 256) {
      pos.x = futurePos.x;
    }

    if (futurePos.y > 0 && futurePos.y < height) {
      pos.y = futurePos.y;
    }

    pushMatrix();
    translate(stage.pos.x + pos.x, stage.pos.y + pos.y);
    scale(direction, 1); // Scaling with direction means we can flip our image if moving left/right
    imageMode(CENTER);
    updateImage();
    image(img, 0, 0);
    popMatrix();
  } 


  boolean checkCollisionSouth(PVector pos) {
     //Get the player coordinates if they were on the collision img 
    int playerX = int(stage.pos.x + pos.x);
    int playerY = int(stage.pos.y + pos.y) + 12; //Move y value 12px because our current position is the center

    //Get the color of our 2 test points
    color leftSide = stage.collisionImg.get(playerX - 5, playerY); 
    color rightSide = stage.collisionImg.get(playerX + 4, playerY);

    return leftSide == #000000 || rightSide == #000000;
  }     
}
{% endhighlight %}

Now our player is able to stand anywhere on the collision that is black, there are still some issues since we can walk through walls and our character treats them like floors. Next we need to check our players left and right side for collisions.

### Side Collisions
