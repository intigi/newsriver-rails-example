# Intigi News River Example App

This example app powers news.intigi.com and demonstrates how the Intigi API can be used.

# Setting Up

## API Key

You will need to obtain a key from Intigi and set this variable with your key:

* ENV['INTIGI_API_KEY']

## Authentication

This app uses a very basic authentication method and relies on the following two environment variables. For serious production environments you should set up a proper authentication system.

* ENV['INTIGI_RIVERS_USERNAME']
* ENV['INTIGI_RIVERS_PASSWORD']

## Embedly API

This app will fetch image previews and excerpts from embedly but you need to install your embedly API key.

* ENV['EMBEDLY_API_KEY']

## Heroku Setup

$ heroku config:add INTIGI_API_KEY=yourapikey INTIGI_RIVERS_USERNAME=yourusername INTIGI_RIVERS_PASSWORD=yourpassword EMBEDLY_API_KEY=yourembedlyapikey

Check your variables using:

$ heroku config

And you should see something like:

=== intigi-news Config Vars
INTIGI_API_KEY:         yourapikey
INTIGI_RIVERS_PASSWORD: yourusername
INTIGI_RIVERS_USERNAME: yourpassword

## Development Setup

Edit your ~/.bashrc to include the environment variables so you can test in development:

export INTIGI_API_KEY=yourapikey
export INTIGI_RIVERS_USERNAME=yourusername
export INTIGI_RIVERS_PASSWORD=yourpassword
export EMBEDLY_API_KEY=yourembedlyapikey

# Setup A "River"

1. Browse to /rivers/new
2. Enter your username and password
3. Fill out details to create the river.
4. Browse to the river, you will see no results.
5. Manually trigger the pulling or recommendations from intigi by browsing to /work.

# Setup Cron Jobs

## Rake Tasks

This rake task will fetch all new recommendations from Intigi:

rake fetch_all_recommendations_from_intigi

## Setup on Heroku

$ heroku addons:add scheduler:standard

Run manually from console to test if you like:

$ heroku run rake fetch_all_recommendations_from_intigi

Add the rake task to the heroku scheduler. This command will open a web browser.

$ heroku addons:open scheduler

…type this for your task (without quotes): "rake fetch_all_recommendations_from_intigi"

## Setup domain name on Heroku

$ heroku domains:add news.yoursite.com
