
![Imgur](http://i.imgur.com/f9JazZu.png)

![Build Status](https://codeship.com/projects/22fb9240-0ba7-0133-8b96-265ef25499ca/status?branch=master)
![Code Climate](https://codeclimate.com/github/jraenorris/workoutbuddy.png)

<tt>http://workoutpartner.herokuapp.com/</tt>

## About

WorkoutPartner aims to alleviate the stress of going to the gym and not knowing what to do, a major hurdle for many looking to get or stay in shape. It allows users to create workouts prior to going to the gym, and even seek help from trainers in the creation of their workouts. Progress reports encourage motivation and make tracking accomplished workouts easy.

## Why build WorkoutPartner?

The idea came about, as many do, over a few beers with a friend. While discussing my new career path with a friend who, in addition to law school, is a personal trainer. He voiced concern about how his field is often stuck in an age of having hand-written workout routines that get lost and quickly outdated. After talking with him and learning more about what would be beneficial to help support his clients, the idea of WorkoutPartner was born. The fact that the need for such an app is so obvious both for myself and for others is something that keeps me excited about it.

## See all your workouts - Desktop view
![Imgur](http://i.imgur.com/U83wvPs.png)

## Edit your workout and the exercises in it - Mobile view
![Imgur](http://i.imgur.com/iFv2hOS.png)

## View workout details and mark as completed - Desktop view
![Imgur](http://i.imgur.com/fNfojRu.png)

## Track workout completion - Mobile view
![Imgur](http://i.imgur.com/vyA1pZR.png)

## Download
```
git clone https://github.com/jraenorris/workoutbuddy.git
cd workoutbuddy
bundle install
rake db:create db:migrate
```

## To do
 - Create tutorial for how to best navigate the site on the root page
 - Utilize AJAX throughout more of the app to create a faster user-experience
 - Enhance the trainer feature by allowing users to request trainer's help via email request
