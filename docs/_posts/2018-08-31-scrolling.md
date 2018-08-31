---
layout: post
title: "Creating a Scrolling Background"
date: 2018-08-31
theme: jekyll-theme-tactile
categories: game thoughts
theme: jekyll-theme-midnight
---

## Make that background move!

When I started the MegaMan project I began by creating the scrolling elements of the game. Without scrolling the game would be unplayable and I realised the scrolling aspect would influence
how I drew the player so it was the first challenge I had to take on.

At first I had to decide how the game would interact with the background so I began to design my basic classes

There would be an abstract class named Level that would contain the information about what Background image to use and some other basic variables. To begin with I plan on creating the BombMan stage so there will be a second class BombStage extending Level that would be responsible for drawing itself and moving the background.


Lets begin by setting up out abstract class Level with its basics:
{% highlight java linenos %}
abstract class Level {
    PImage bgImg;
    PVector pos;
    
    abstract void drawLevel();
}
{% endhighlight %}

Now that we have our Levels class defined it's time to make our Bomb Man Level that I'll be naming BombStage and add movement to our background:
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
        translate(dX, dY);
        image(bgImg, -pos.x, -pos.y);
    }
}
{% endhighlight %}
[openprocessing.org](https://www.openprocessing.org/sketch/584256)
