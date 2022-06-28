# Tarrare (Student to Student Delivery) 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
The application allows users to plan their meals for the next week, and check the meals they have planned for the day.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Delivery/Food
- **Mobile:** The app is suited for mobile use since it gives users easy access to order/deliver food while on the go
- **Story:** Delivery apps are expensive. Delivery people have to go out of their way to go to a resturant, pick up food, and deliver it to a different location. There is wasted opportunity with students on a college campus. Students are able to deliver to one another with less hassle, as they are more likely to share usual locations.
- **Market:** This app would be targeted towards college students looking for cheaper delivery and also students looking to make extra money without much effort.
- **Habit:** Students looking to deliver would open the app whenever they are at a resturant. They would input where they are headed after leaving the resturant, and indicate they are open to picking up food. Students looking to order, can either open their app or be notified when a student is willing to deliver to their location. If a deliverer and an orderer are matched, they can communicate through temporary chat.
- **Scope:** The core features of this application is being able to match two students for food delivery. The basic version would allow students to input locations and able-to-deliver status. It wwill also allow the students to communicate through chat. Once the core features are implemented, the app will be extended to make the matching process more fluid and require less user input and chat. 


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [ ] Users are able to login/sign-up/logout from the application
* [ ] Ordering Students can input their location and resturants they would be willing to order from
* [ ] Delivering Students can input their resturant and a location they are going to after leaving the resturant
* [ ] Ordering Students can see a list of resturants and delivery locations and request a match
* [ ] Delivering Students can accept and Ordering Students match request and communicate with them through chat
* [ ] Users who have been matched can communicate through chat

**Optional Nice-to-have Stories**
* [ ] Users are separated by college campus
* [ ] Orders can track their food using a Maps SDK 

**Finished Everything and polished app Stories**
* [ ] Integrate a payment system through the app (Stripe iOS SDK)

### 2. Screen Archetypes

* Login Screen
    * Users are able to login/sign-up/logout from the application
* Sign Up Screen
    * Users are able to login/sign-up/logout from the application
* Orderer Screen
    * Users can see a table view of ordering students 
    * This view will be a simple table with cells containing resturants and orderer locations 
* Deliverer Screen
    * Users can see a table view of delivering students
    * This view will be a simple table with cells containing resturants and deliverer locations after leaving their current resturant
* Deliverer Screen
    * Users can see a table view of delivering students
    * This view will be a simple table with cells containing resturants and deliverer locations after leaving their current resturant
* Chat Screen
    * Users can see their message history and open chats with any users they have matched with

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Dashboard Screen
* Create Meal Plan

**Flow Navigation** (Screen to Screen)

* Dashboard Screen
   * See detail view of meal – view meals planned for a day
* Create Meal Plan
   * Access different recipes 
   * Designate what meals to cook on which day (event planning)

## Wireframes

### [BONUS] Digital Wireframes & Mockups

## Schema 
### Models
#### Meal

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image of the meal |
   | description   | String   | description of the meal |
   | ingredients   | String[] | list of ingredients for the meal |
   | commentsCount | Number   | number of comments that has been posted to an image |
   | likesCount    | Number   | number of likes for the post |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
### Networking
- Login Screen
    - (Read/GET) Get user information based on login information
- Register Screen
    - (Create/POST) Create a new user object
- Dashboard Screen
    - (Read/GET) List out logged in user's plans for the day
    - (Read/GET) List out other user's meal plans
    - (Create/POST) Like on another user's meal plan
    - (Delete) Delete like on another user's meal plan
- Create Meal Segue
    - (Create/POST) Create a new meal object
- Profile Screen
    - (Read/GET) Query logged in user object
    - (Read/GET) Query meal plans posted by user object

#### Existing API Endpoints
##### Edamam Nutrition Analysis API Documentation
- BASEURL - [https://api.edamam.com]

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /search | search for recipes
    `GET`    | /search?q=query | query text for the recipes
    `GET`    | /search?calories=calories | calories of the meal
    `GET`    | /search?health=health | health type of the meal
    
## Sprint 1 GIFs:

## Sprint 2 GIFs:

## Sprint 3 GIFs:
