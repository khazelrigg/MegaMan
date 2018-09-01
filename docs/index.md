---
title: Making Megaman
layout: single
header:
    overlay_image: /assets/img/header.jpg
    cta_label: "View Posts"
    cta_url: "/posts"

author_profile: true
---
# Welcome to my MegaMan project


<div>
      <h4>{{ site.data.ui-text[site.locale].related_label | default: "Check out my posts" }}</h4>
      <div class="grid__wrapper">
        {% for post in site.posts limit:4 %}
          {% include archive-single.html type="grid" %}
        {% endfor %}
      </div>
</div>
