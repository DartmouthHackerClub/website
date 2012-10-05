---
layout: post
title: "Getting Started with Flask"
date: 2012-10-05 22:12
comments: true
categories: 
---

[Flask](http://flask.pocoo.org/) is a great web development framework
written in Python. It's what we use to build web apps in Hacker Club,
and it's easy to get started even if you've only taken CS 1.

In this guide, I'm going to assume that you've got Python installed and
that you're using some kind of UNIX-based operating system, like Linux
or OS X. (If you're on Windows, I recommend installing
[Ubuntu](http://www.ubuntu.com/) in
[VirtualBox](https://www.virtualbox.org/).)

<!-- more -->

Getting the starter Flask app
-----------------------------

We've written a Flask template you can use a base for your projects. It
includes Dartmouth authentication and Bootstrap by default.

```bash
$ git clone https://github.com/DartmouthHackerClub/flask_template.git
$ cd flask_template
$ pip install -r requirements.txt
$ python app.py
```

