# Best Buddies

**Live url:** https://bestbuddies.sweebleapp.com

## About

Best Buddies is a microsite to find which of your friends likes your photos the most on Instagram. [Since launch](https://www.producthunt.com/tech/best-buddies), it's [been used by over](https://twitter.com/TylerPearson/status/710349828295790593) 20,000 people and analyzed 30 million likes by 6.6 million different accounts on Instagram. 

## Launch

[Within a day of launching](https://www.dropbox.com/s/sknu4ov8h5vrdno/IMG_5817%202.PNG?dl=0), Best Buddies was featured on the home page of [Product Hunt](https://www.producthunt.com/tech/best-buddies) and [stayed on the popular page](https://www.dropbox.com/s/0im0lsx7oje9pi0/IMG_5835%202.PNG?dl=0) for close to a week. Best Buddies was also written about in numerous other places, like Business Insider, [where it was listed on the home page](https://www.dropbox.com/s/bbq1c6la2r6a4y3/IMG_5824.PNG?dl=0). It was also shared extensively on social media sites. Not a bad launch!

## Setup 

If you look through the code, it's a pretty standard Rails app. Since analyzing each account takes some time, these are pushed in a background job (handled by Delayed Job) and polling occurs to find when it is finished. 

Screenshots use [PhantomJS](http://phantomjs.org) to create images that are easy to share on Facebook, Twitter, Instagram, and elsewhere.

Since I expected heavy usage and the need to easily scale, I chose to host the site with Heroku, which I'm super glad I did. 
I've had nothing but good experiences with Heroku and [they've written about how I've used their service before](https://www.heroku.com/customers/sweeble).

At one point right after launch, there were 12 web servers and 80 background servers running. Since the launch occured at night, and I was working during the day the next few days, I monitored how the microsite was doing with Heroku's *amazing* [Saber iOS app](https://itunes.apple.com/us/app/saber-for-heroku/id991360311?mt=8) which let me easily spin up and down servers and run `rails console` *on my phone* to [keep an eye on how many background jobs](https://www.dropbox.com/s/fceqsag9nxaxct8/IMG_5836.PNG?dl=0) were in the queue. Fairly soon after launch one of the tables started to have over a million records and I needed to change an index on one of the tables. With Heroku, I was able to scale up the background servers up to handle the back log until I could make the change. 

The database is Postgres and has close to 4gb's of data in it now. When I was running a bunch of servers, I was able to easily bump to a larger database server with Heroku's amazing setup to handle more simultaneous database connections. 

Caching is done with MemCachier. Images are stored on S3 and Cloudfront is used as a CDN for assets. Phusion Passenger with Nginx was used as the web app server. Raygun and New Relic were used for monitoring errors and the servers.

It's a microsite and I put it together quickly, so it has some *really ugly code*, but I'm going to open source it anyway.

![Screenshot](http://i.imgur.com/F9JHzsx.png)

