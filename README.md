# Tarrare (Student to Student Delivery) 
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
The application allows students to order food for delivery on campus and have it picked up and delivered by another student while minimizing inconvenience for both students.

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
* [ ] Users are able to search for nearby resturants/buildings using the MapKit SDK
* [ ] Ordering Students can input their location and resturants they would be willing to order from
* [ ] Delivering Students can check in once they are at a resturant by marking themselves as "Able to deliver" and inputting their delivery destination
* [ ] Ordering Students can see a list of resturants and delivery locations and request a match
* [ ] Delivering Students can accept and Ordering Students match request and communicate with them through chat
* [ ] Users who have been matched can communicate through chat

**Optional Nice-to-have Stories**
* [ ] Users are separated by college campus (determined by registration email)
* [ ] Matching process between orderers and deliverers is all done on the backend with minimal user input. Matching is determined by delivery locations and resturants
* [ ] Orders can track their food on a map using a Apple's MapKit

### 2. Screen Archetypes

* Login Screen
    * Users are able to login/sign-up from the application
    * Users from different colleges will be presented with screens specific to their college
    * Colleges will be determined by the email address (@utexas, @umich)
* Sign Up Screen
    * Users are able to login/sign-up from the application
* Orderer Screen
    * Orderer can see a table view of delivering students 
    * This view will be a simple table with cells containing resturants and deliver delivery destinations 
    * Orders can check if their preferences and location match with any current deliverers, if not orderer can press the request button to add a new order request 
* Deliverer Screen
    * Deliverers can see a table view of students who have placed order requests
    * This view will be a simple table with cells containing orders interested resturants and pickup locations
* New Request Screen (Orders)
    * Order can input a list of resturants that they are interested in ordering from
    * Orderer's location will be determined by MapKit, but can be manually overriden by the orderer
    * Once resturants and pickup location are selected, orderer can add their orderer to the table view list of current orders
    * Orderer can be notified whenever they are a match with a deliverer, or a deliverer can reach out if they see the match in the table view of orders
* Locations Screen
    * Users can search for nearby resturants/buildings using the Apple MapKit SDK for results
    * Users can either search by name or address, and see a list of results that they can select.
    * Filter results to only include the city that the college is in (more precise stretch filter could limit results to smaller area)
* All Chats Screen
    * Users can see their message history and open chats with any users they have matched with
    * Chats will disappear after both the orderer and deliverer mark the order as complete
* Individual Chats Screen
  * Users can see their messages with any user they are currently matched with and the order has not been completed
  * The screen has messages and a chat box for sending messages
  * The screen also contains buttons for marking the order as complete

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Screen (Order)
* Home Screen (Deliver)
* Messages
* Account/Profile

**Flow Navigation** (Screen to Screen)

* Home Screen (Order)
   * Tap "Deliver" to switch to Home Screen (Deliver)
   * Tap current location to navigate to locations screen
   * Tap "Request" to switch to new requests screen
   * In table view, tap a cell's chat box to open a chat with a user

* Home Screen (Deliver)
   * Tap "Order" to switch to Home Screen (Order)
   * Tap "My Resturant" to navigate to locations screen
   * Tap "Delivery Location" to navigate to locations screen
   * Tap "Delivery Status" to toggle delivery status

* Messages
    * Select cell to navigate to "Individual Chat Screen" for a specific user

## Wireframes
[Wireframes](https://www.figma.com/file/kPGAnC0qNWWI4V0bKFuk8Q/Tarrare-Wireframing?node-id=12%3A695)

### [BONUS] Digital Wireframes & Mockups

## Schema 
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | id            | Int   | unique id for the user (default field) |
   |               | Pointer to User| image author |
   | image         | File     | image of the meal |
   | description   | String   | description of the meal |
   | ingredients   | String[] | list of ingredients for the meal |
   | commentsCount | Number   | number of comments that has been posted to an image |
   | likesCount    | Number   | number of likes for the post |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
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
