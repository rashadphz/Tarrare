# Tarrare (Student to Student Delivery)


https://user-images.githubusercontent.com/20783686/182677225-7a1676d5-fbb3-4c4e-a61a-caccaef00460.mov


## Table of Contents

1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Project Task Board](#Project-Task-Board)
1. [Schema](#Schema)

## Overview

### Description

The application allows students to order food for delivery on campus
and have it picked up and delivered by another student while
optimizing convenience for both students.

### App Evaluation

[Evaluation of your app across the following attributes]

- **Category:** Delivery/Food
- **Mobile:** The app is suited for mobile use since it gives users
  easy access to order/deliver food while on the go
- **Story:** Delivery apps are expensive. Delivery people have to go
  out of their way to go to a resturant, pick up food, and deliver it
  to a different location. There is wasted opportunity with students
  on a college campus. Students are able to deliver to one another
  with less hassle, as they are more likely to share usual locations.
- **Market:** This app would be targeted towards college students
  looking for cheaper delivery and also students looking to make extra
  money without much effort.
- **Habit:** Students looking to deliver would open the app whenever
  they are at a resturant. They would input where they are headed
  after leaving the resturant, and indicate they are open to picking
  up food. Students looking to order, can either open their app or be
  notified when a student is willing to deliver to their location. If
  a deliverer and an orderer are matched, they can communicate through
  temporary chat.
- **Scope:** The core features of this application is being able to
  match two students for food delivery. The basic version would allow
  students to input locations and able-to-deliver status. It wwill
  also allow the students to communicate through chat. Once the core
  features are implemented, the app will be extended to make the
  matching process more fluid and require less user input and chat.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] Users are able to login/sign-up/logout from the application
- [X] Users are able to search for nearby resturants/buildings using
      the Google Places SDK
- [X] Delivering Students can check in once they are at a resturant by
      marking themselves as "Able to deliver" and inputting their
      delivery destination
- [X] Ordering Students can see a list of resturants and delivery
      locations and request a match
- [X] Delivering Students can accept and Ordering Students match
      request and communicate with them through chat
- [X] Users who have been matched can communicate through chat

**Optional Nice-to-have Stories**

- [ ] Users are separated by college campus (determined by
      registration email)
- [ ] Ordering Students can input their location and resturants they would be willing to order from
- [X] Orderers and Deliverers can see a map with corresponding restaurant/delivery building locations     
- [ ] Matching process between orderers and deliverers is all done on
      the backend with minimal user input. Matching is determined by
      delivery locations and resturants
- [ ] Orders can track their food on a map using a Apple's MapKit

### 2. Screen Archetypes

#### Any User Screens
- Login Screen
  - Users are able to login/sign-up from the application
- Sign Up Screen
  - Users are able to login/sign-up from the application
- All Chats Screen
  - Users can see their message history and open chats with any users
    they have matched with
  - Chats will disappear after both the orderer and deliverer mark the
    order as complete
- Individual Chats Screen
  - Users can see their messages with any user they are currently
    matched with and the order has not been completed
  - The screen has messages and a chat box for sending messages
  - The screen also contains buttons for marking the order as complete
- Locations Screen
  - Users can search for nearby resturants/buildings using the Apple
    MapKit SDK for results
  - Users can either search by name or address, and see a list of
    results that they can select.
- Profile Screen
  - Button for the user to switch between Ordering and Delivering

#### Order Flow Screens
- Main Orderer Screen
  - Orderer can see a table view of restaurants to choose from
  - The list of restaurants shown are restaurants that currently have deliverers
- Restaurant Specific Screen
  - Once a restaurant cell is selected, a new screen with all deliverers at this restaurant is presented
  - This screen is a table view of cells containing: deliver location, distance from
  current user, and a request button
- Pending Match Response
  - Once a request is sent, a pending match view controller is presented
  - This screen has the order information, and a loading visual
  - The screen also has a cancel request button 
- Order Matched Screen
  - The screen has a map marked with the order's restaurant and delivery building
  - The screen has the deliverer's name and an button that opens a chat with them

#### Deliver Flow Screens
- Main Deliverer Screen
  - Deliverers can input their current restaurant, delivery building, and then mark themselves as able to deliver
- New Offer Screen
  - A screen shows a map with a new offer for the deliverer
  - The deliverer can either accept or decline the match offer
- Deliver Matched Screen
- The screen has a map marked with the order's restaurant and delivery building
- The screen has the orderer's name, a button that opens a chat with them, and a directions button that opens in Apple Maps
- The screen has a complete delivery button

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- Home Screen (Order)
- Messages
- Account/Profile

**Flow Navigation** (Screen to Screen)

- Home Screen (Order)
  - Tap Restaurant Cell to view deliverers at that restaurant
  - Tap Delivery Cell's request button to present pending match screen
- Pendng Match Screen (Order)
  - Tap "Cancel Request" button to dismiss screen
  - Present New Match Screen automatically when a deliverer accepts the order
- Home Screen (Deliver)
  - Tap "Edit" button on restaurant or delivery building to present Locations Screen
- New Offer Screen (Deliver)
  - Presented automatically when a matching order is found
  - The Accept Button presents the Deliver Matched Screen
- Messages
  - Select cell to navigate to "Individual Chat Screen" for a specific
    user
## Wireframes

[Wireframes](https://www.figma.com/file/kPGAnC0qNWWI4V0bKFuk8Q/Tarrare-Wireframing?node-id=12%3A695)

## Project Task Board

[Project Task Board](https://github.com/rashadphil/Tarrare/projects/1)

### [BONUS] Digital Wireframes & Mockups

## Schema

### Models

<img width="788" alt="image" src="https://user-images.githubusercontent.com/20783686/180578675-4b05f84e-90ba-4311-ba28-3a4243f11935.png">

### Networking

- Login Screen
  - (Read/GET) Get user information based on login information
- Sign Up Screen
  - (Create/POST) Create a new user object
- Orderer Screen
  - (Read/GET) List current deliverers and their information
  - (Read/GET) Get currently logged in user's location/building
- Deliver Screen
  - (Read/GET) List current orders and their information
  - (Read/GET) Get currently logged in user's resturant/building
  - (Update/POST) Mark logged in user as able to deliver
  - (Update/POST) Add deliverer to the current deliveries database table
- New Request Screen (Orderer)
  - (Update/POST) Create a new order given a user's location and resturants and add it to the order table
- Location Screen
  - (Read/GET) Query locations that begin with current search term
  - (Read/GET) Query logged in user's current location
  - (Update/POST) Set current user's resturant/delivery location
- All Chats Screen
  - (Read/GET) Get a list of all of the logged in user's open chats
- Individual Chat Screen
  - (Read/GET) Query all messages between two users
  - (Update/POST) Add a new message to the chat database between two
    users

