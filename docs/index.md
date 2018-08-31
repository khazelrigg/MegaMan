---
title: khazerligg - Megaman
---

## Welcome to my MegaMan project, from here I plan to upload some of my ideas and explain some of my design choices.


### View my posts

<ul>
{% for post in site.posts %}
<li>
<a href="{{ post.url }}">{{ post.title }}</a>
</li>
{% endfor %}
</ul>

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
