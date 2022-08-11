# Tarrare (Student to Student Delivery)

### Demo

https://user-images.githubusercontent.com/20783686/182677225-7a1676d5-fbb3-4c4e-a61a-caccaef00460.mov


## Table of Contents

1. [Overview](#overview)
1. [Product Spec](#product-spec)
1. [Figma Wireframes](https://www.figma.com/file/kPGAnC0qNWWI4V0bKFuk8Q/Tarrare-Wireframing)
1. [Project Task Board](https://github.com/rashadphil/Tarrare/projects/1)
1. [Schema](#schema)
1. [Matching System Technical Details](#matching-system-technical-details)

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
- [X] Matching process between orderers and deliverers is all done on
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

### Matching System Technical Details

- **Client Side**: Whenever an order or delivery is placed, the information is sent to the server with : the restaurant, the delivery building, and the placing user
- **Server Side**: When the server receives and order/delivery it checks the delivery/orders table for matching restaurants and delivery buildings. If a match is found, the server publishes a "newMatch" message.
- **Client Side (Deliver)**: 
  - Any deliverer marked as able to deliver, starts a GraphQL subscription and listens specifically for a "newMatch" message.
  - If the subscriber hears a "newMatch" message, it checks that the match corresponds to the current user. If so, it presents the New Match Screen for the deliverer
  - If the deliverer accepts, a match mutation is sent to the server saying that the deliverer has accepted
- **Server Side**: When the server receives a match mutation, it publishes the updated match as a "matchUpdate" message
- **Client Side (Orderer)**:
  - Once an order is placed and the orderer sees the Pending Match Screen, they start a GraphQL subscription listening for an "matchUpdate" message
  - If a "matchUpdate" message is heard, it first verifies that the match corresponds to the current user. If so, it checks if the message says the deliverer accepted the match or declined. On acceptance, it presents the order matched screen.

### Screens and Figma

### Both User Type Screens
<p float="left">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184225084-14f65982-6550-4671-865d-47b9b246e881.png">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184225153-2212d3f1-32ea-4366-8ed4-bd2980dbb6c8.png">
  <img width = "277" alt="gif" src="/transitiongif.gif"/>
</p>

#### Order Screens
<p float="left">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184220523-e4d96cb6-cf51-47ae-acc0-17edc6d3b47f.png">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184220792-dd025e7a-be83-46a0-999e-5ae2088ce5c0.png">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184221132-c69d17df-835a-4846-8aea-98127a66186f.png">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184221180-65ac636b-646a-4cc9-8ea6-06234a873d91.png">
</p>

#### Deliver Screens
<p float="left">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184221689-9deb4dc7-c0a9-449d-9c00-68d4c91839ae.png">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184223400-7a2ea488-abba-4e5b-89b3-096e463883b8.png">
  <img width="277" alt="image" src="https://user-images.githubusercontent.com/20783686/184221374-5115c82b-d476-4687-960c-e793d13016ff.png">
</p>


## Schema

### Models

<img width="788" alt="image" src="https://user-images.githubusercontent.com/20783686/180578675-4b05f84e-90ba-4311-ba28-3a4243f11935.png">

### Networking

- Login Screen
  - (Mutation) Check for user, update login information if needed
- Sign Up Screen
  - (Mutation) Create a new user object
- All Chats Screen
  - (Query) Get a list of all of the logged in user's open chats
- Individual Chat Screen
  - (Query) Query all messages between two users
  - (Mutation) Add a new message to the chat database between two
    users
  - (Subscription) Listen for new messages
- Location Screen
  - (Read/GET) Query locations that begin with current search term
  - (Read/GET) Query logged in user's current location
  - (Mutation) Send the selected place to the database
- Main Orderer Screen
  - (Query) Query the list of restaurants that currently have deliverers
- Restaurant Specific Screen
  - (Query) Query the list of deliverers at a given restaurant
- Pending Match Response Screen
  - (Subscription) Listen for accepted match request
- Order Matched Screen
- Main Deliver Screen
  - (Subscription) Listen for any matching orders
- New Offer Screen
  - (Mutation) Accept the delivery
  - (Mutation) Decline the delivery
- Deliver Matched Screen
  - (Mutation) Mark the order as complete


