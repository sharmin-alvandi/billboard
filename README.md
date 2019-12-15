# README

Shopify Central Discount Billboard App

 A billboard for Shopify Merchants to post their discounted products and special offers.

Goals:
- To create a shared marketplace and add a new feature to Shopify as a shopping mall
- To increase the traffic of young and/or small shopify stores
- To facilitate the Shopify’s merchants marketing
- To help customers find their favourite products with less efforts and for less price

This app has been created using:

* dev tool
* Ruby version 2.6.5
* Rails 6
* Bootstrap 4.3
* Whenever gem
* Bootstrap-datepicker


 
 * Please use following commands to run the app:
  1-* dev up
  
  2-* dev s
  
  * Merchants need to sign up and login using their stores names. Then they redirect to their dashboard where they can see, add, edit or remove their ads.
  * Ads have an effective date as well as an expiration date and will beremoved automatically at their expiration date.
* To prevent overloading, a maximum number of ads is considered per store.
* Customers can search discounted products using their favorite collection.

  
  * Important note:
  The main idea of creating this app was to create a Shopify app. But because of some technical problems and time constraint I needed to create it as an stand alone project. As a Shopify app it only needs a class of "Advertisement" and has  access to the shops(stores), products and products' collections info through Shopify APIs. So here in the current app, the "Store" and "Collection" classes are only to simulate those APIs and to fill the "advertisements" table. 
  
  

