---
title: ReMaking Megaman
layout: single
author_profile: true
header:
    overlay_image: /assets/img/header.jpg
    cta_label: "View Posts"
    cta_url: "/posts"
---
# Welcome to my MegaMan project

This page will be following my development of a Mega Man clane written in Processing. Check out each post to see how I made certain parts of the game by studying the original behavior.

<div>
      <h4>{{ site.data.ui-text[site.locale].related_label | default: "Check out my posts" }}</h4>
      <div class="grid__wrapper">
        {% for post in site.posts limit:4 %}
          {% include archive-single.html type="grid" %}
        {% endfor %}
      </div>
</div>
