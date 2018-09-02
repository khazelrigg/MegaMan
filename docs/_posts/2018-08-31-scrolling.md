---
title: "Creating a Scrolling Background - pt1"
date: 2018-08-31
header:
    teaser: /assets/img/scrolling/teaser1.png
category: code
---
### What good is a sidescrolling platformer if our background can't move?

MegaMan uses basic sidescrolling and in this demo we are going to create a sidescrolling background using an image of Bomb Man's Stage available [here](https://www.spriters-resource.com/nes/mm/sheet/215/)


To set this up and allow for potential additions of future levels my idea is to design an abstract class named `Level` that we will extend for each of our stages which is responsible for drawing our background.

Our `Level` has a few basic components: the image we want to display, our position in the image, and a function that draws the image

Lets begin by setting up out abstract class Level with its basic components:

{% highlight java linenos %}
abstract class Level {
    PImage bgImg;
    PVector pos;
    
    abstract void drawLevel();
}
{% endhighlight %}

Now that we have our first class, our second class `BombStage` will load our image and set our initial position:

{% highlight java linenos %}
class BombStage extends Level {
    
    BombStage() {
        bgImg = loadImage("bombStage.jpg");
        pos = new PVector(13, 990);
    }
}
{% endhighlight %} 

For this demo, let's use the user's keyboard input to move our image around. Using Processings `keyPressed` and `key` variables we will update our image on each key press and move our image using the translate function. 
In order to translate our image we will change our position by a certain distance and translate our image to our new position.

{% highlight java linenos %}
class BombStage extends Level {
    
    BombStage() {
        bgImg = loadImage("bombStage.jpg");
        pos = new PVector(13, 990);
    }

    void drawLevel() {
        int dX = 0; // delta X
        int dY = 0; // delta Y
        int d = 12; // distance to move

        if (keyPressed) {
            switch(key) {
                case('w'):
                    dY = -d;
                    brekak;
                case('a'):
                    dX = -d;
                    break;
                case('s'):
                    dY = d;
                    break;
                case('d'):
                    dX = d;
                    break;
            }
        }
        
        pos.y += dY;
        pos.x += dX;
        translate(-pos.x, -pos.y);
        image(bgImg, 0, 0);
    }
}
{% endhighlight %}

<p>translate uses -pos.x and -pos.y because the coordinate system is reversed along the y-axis in Processing and we want the image to move along the x-axis away from us</p>{: .notice--info}
[Demo Sketch](https://www.openprocessing.org/sketch/584256){: .btn .btn--success}

We can move our image like we wanted but we are able to move the image off the map so we need to add a few checks to make sure we don't move off the map area.
Modifying our draw function to use a few functions that tell our tell us if it is able to move in a certain direction is an easy solution.

{% highlight java linenos %}
    void drawLevel() {
    int dX = 0;
    int dY = 0;
    int d = 4;
    if (keyPressed) {
      switch(key) {
        case('w'): 
        if (canMoveUp())
          dY = -d;
        break;
        case('s'): 
        if (canMoveDown())
          dY = d;
        break;
        case('a'):
        if (canMoveLeft())
          dX = -d;
        break;
        case('d'): 
        if (canMoveRight())
          dX = d;
        break;
      }
    }
    
    pos.y += dY;
    pos.x += dX;
    translate(pos.x, -pos.y);
    image(bgImg, 0, 0);
  }

  boolean canMoveUp() {
    if (pos.x >= 13 && pos.x < 1549 ||
      pos.y == 30 ||
      pos.y == 510 && pos.x < 2826) return false;
    return true;
  }

  boolean canMoveDown() {
    if (pos.y == 990 ||
      pos.y == 926 ||
      pos.y == 30 && !(pos.x == 2829 || pos.x == 4109) ||
      pos.y == 510 && pos.x != 4109) return false;
    return true;
  }

  boolean canMoveLeft() {
    if (pos.x == 13 ||
      pos.x == 1549 && pos.y != 990 ||
      pos.x == 2829 && pos.y != 510 ||
      pos.x == 4109 && pos.y != 30) return false;
    return true;
  }

  boolean canMoveRight() {
    if (pos.x == 1549 && pos.y != 510 ||
      pos.x == 4109 ||
      pos.x == 2829 && pos.y != 30) return false;
    return true;
  }
{% endhighlight %}

With these modifications we now have a background we can navigate using the keyboard without clipping past any of the map boundaries.

In [part 2]({{ site.baseurl }}{% post_url 2018-09-01-scrolling2 %})  I'll add how to move the background based on player position instead of using keyboard input.
