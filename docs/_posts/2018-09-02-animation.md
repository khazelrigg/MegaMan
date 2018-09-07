---
title: "Adding Animation to Mega Man"
date: 2018-09-02
category: code
header:
    teaser: /assets/img/animate/teaser.png
---
## Adding movement to our movement

Previously we added our player but he lacks animation and looks pretty boring, today we fix that.

In the previous versions we were only using one image but to create an animation we will need to load in multiple images. In our `Player` class lets add a function that loads our player images

{% highlight java linenos %}
class Player {
    PImage img;
    PVector pos;

    PImage[] images = new PImage[9]; //Declare an array of images for our character

    ...

        Player() {
            pos = new PVector(100, 159);
            loadImages();
        }

    void loadImages() {
        /*
           0 - Blink
           1 - Standing
           2-4 - Running
           5 - Jumping
           6 - Shooting ground
           7 - Shooting jump
           8 - Hurt
         */

        for (int i = 0; i < images.length; i++) {
            images[i] = loadImage("right" + i + ".png"); //All images are facing right, we can translate them to face left
        }

        img = images[1];
    }

    ...

}
{% endhighlight %}


### Defining player States
Now our player has an array of images that will be loaded on creation but we only use `images[1]`. To update our `img` variable which we will use as to set our current image lets create an enumerated type of potential player states. We know that our player can be standing still, walking, falling/jumping, and eventually shooting, taking damage, and climbing. For now we will only worry about standing, walking, and jumping because shooting and the rest will come later.


{% highlight java linenos %}
enum state {
    STAND, WALK, JUMP
};
{% endhighlight %}

Now that we have our playerStates defined we can update our players image using the `img` variable depending on our `state`, our new function will simply be named `updateImage`

{% highlight java linenos %}
enum state {
    STAND, WALK, JUMP
};

class Player {
    ...
    state playerState = state.STAND;
    ...

    void updateImage() {
        switch(playerState) {
            case STAND:
                img = images[1];
                break;
            case WALK:
                img = images[2];
                break;
            case JUMP:
                img = images[2];
                break;
            default:
                img = images[1];
        }
    }
}
{% endhighlight %}

Now we are able to update our `img` based on the player's state but our `playerState` is never changed. Our `playerState` will change depending on what movement we are doing so we can update it from within `move()`.

{% highlight java linenos %}
class Player {
    ...

    void move() {
        int groundY = 185 - img.height / 2;

        if (pos.y < groundY ) {
            velocity.y += 0.5; //Gravity if we are not at bottom of screen
        } else {
            velocity.y = 0;
            pos.y = groundY; //If we are below the ground move us back up
            playerState = state.STAND;
        }

        if (pos.y >= groundY && up != 0) {
            velocity.y = -jumpSpeed;
        }

        velocity.x = walkSpeed * (left + right);

        if (pos.y < groundY) {
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

}
{% endhighlight %}
<p>Our groundY value is simply set to the value of the ground in the first area of the map, it will not work if we move past that area</p>{: .notice--info}


<video autoplay="autoplay" loop="loop" width="512" height="448">
    <source src="{{ site.baseurl }}/assets/img/animate/animated.webm" type="video/webm">
</video>{: .align-left}
What our player now looks like as we move around. The next step is to improve our walking animation so that we are not ice skating across the level.

<div style="height: 266px;"></div>
<hr>

### Adding walking and standing animations

To make our player walk I'll be adding another function `walk` which simply rotates through images 2-4 
{% highlight java linenos %}
class Player {
    ...
    int walkImg = 2
    int framesSinceWalk = 0;
    ...
    void updateImage() {
      switch(playerState) {
      case STAND:
        img = images[1];
        break;
      case WALK:
        walk();
        break;
      case JUMP:
        img = images[5];
        break;
      default:
        img = images[1];
      }
    }

    void walk() {
      img = images[walkImg];
      if (framesSinceWalk == 7) { //How many frames until next walk img
        walkImg++;
        framesSinceWalk  = 0;
      }
      framesSinceWalk++;
      if (walkImg > 4) walkImg = 2;
    }
}
{% endhighlight %}

The standing animation is pretty simple, the player blinks every second (in our case every 60 frames) and our `stand` function will be very similar to our `walk` function

{% highlight java linenos %}
class Player {
    ...
    int framesSinceWalk, framesSinceStand = 0;
    ...
  
    void updateImage() {
      switch(playerState) {
      case STAND:
        stand();
        break;
      case WALK:
        walk();
        break;
      case JUMP:
        img = images[5];
        break;
      default:
        img = images[1];
      }
    }

    void stand() {
      if (framesSinceStand > 60) {
        img = images[0];
        if (framesSinceStand > 62) // Keep img as blink for 3 frames
          framesSinceStand = 0;
      } else {
        img = images[1];
      }
      framesSinceStand++;
  }
}
{% endhighlight %}

<h2>The final result</h2>{: .text-center}
<video autoplay="autoplay" loop="loop" width="512" height="448">
    <source src="{{ site.baseurl }}/assets/img/animate/animatedWalk.webm" type="video/webm">
</video>{: .align-center}
