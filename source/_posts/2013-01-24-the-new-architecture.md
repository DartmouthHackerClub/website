---
layout: default
---

For a while now, one of our biggest problems has been deployment. Well, that's no longer a problem.

## Continuous Deployment

Most people don't want to worry about the technical details of getting their code to run in a production environment -- they just want to write the code and be done with it. Our [new continous integration server](http://ci.hackdartmouth.org/) handles these technical details for us, leaving us to focus on the jobs that still demand human mental faculties.

![Our new Jenkins CI server](http://i.imgur.com/zAQAe2J.png)

Whenever you push code to a continuous integration-enabled repository (currently [coursetown](https://github.com/DartmouthHackerClub/coursetown), [blitzlistr](https://github.com/DartmouthHackerClub/blitzlistr-flask), and [this website](https://github.com/DartmouthHackerClub/website)), the CI server will run the test suite and, if all tests pass, deploy the app. Of course, we don't have any test suites so it will just deploy the app.

## Heroku

Moving forward, all new apps should be hosted on Heroku. It allows us to offload sysadmin duties to people that actually know what they're doing. That said, some apps simply can't run on Heroku.

## Hacktown

Our humble server was recently moved to the server room, bringing uptime from 43% up to an astronomical 97%. That means we can now host apps on hacktown with confidence. Right now, the only app that can't run on Heroku (and thus needs to run on hacktown) is [coursetown](http://courses.hackdartmouth.org/). The [server architecture](https://ariejan.net/2011/09/14/lighting-fast-zero-downtime-deployments-with-git-capistrano-nginx-and-unicorn) is unicorn as the app server and nginx as the web server, with the all the code in `/home/deploy/coursetown`. 

## GitHub Pages

This site is hosted on GitHub Pages.

## Cloudflare

Finally, we have the Cloudflare CDN tying everything together. On top of the performance boost you get from routing traffic through their network, they also provide free DNS servers.

![Cloudflare DNS](http://i.imgur.com/4VOIql5.png)

## tl;dr

Just push your code to GitHub and it will appear on the live site.