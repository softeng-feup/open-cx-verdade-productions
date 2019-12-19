# openCX-*Verdade Productions* Development Report

Welcome to the documentation pages of the *Conferly* of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

*João Abelha*
*João Varela*
*Tiago Verdade*
*Rita Mota*
*Vítor Barbosa*


---

## Product Vision
This app will not only give our consumers the opportunity to easily talk with others and discuss each other's ideas regarding various events through chats and forums, but also facilitate the connection with various users who share similar preferred themes, by allowing people to create their own personalized profiles, containing their favorite interests.


---
## Elevator Pitch
Conference attendees are often frustrated with the lack of time they have to communicate and network with others, being unable to experience conferences at their fullest. Our product provides the users the possibility to enjoy the time they spend during conferences, while not having to worry about trivial things, making them feel as though they are in tune with their surroundings. We understand how the attendees feel and how that feeling can be changed. With our app, wasted time will easily be turned into something productive and with personal value.

---
## Requirements
Our main objective is to help the people that attend conferences guiding them through it and enabling them to discuss and share their ideas with others in a simple and easy way.

About the **nonfunctional requirements** we decided it was better to focus on **usability**, since our product will  empower its users with a lot of features, while keeping it simple and intuitive. We want the user to do what it wants, without having to think to much! 
We will also pay particular attention to **reliability** because it is extremely important for us, that the user can always make full use of the app and enjoy its conference without stressing out.
**Portability** is something that we considerate a lot as well, so that all users can make the most of our app, in any platform they want.
 
The **functional requirements** are exposed on the [Use case diagram](#Use-case-diagram) and [User stories](#User-stories) sections.

### Use case diagram 
![Use Case Diagram](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/Use-case.jpg)

*Create/Manage personal profile:*
* **Actor.** User

* **Description.** Give the users the oportunity to share a bit about themselves in order to make networking more productive allowing user to see if other user's share a similar job or similar interrests.

* **Preconditions and Postconditions.** The user has to create and account to create the profile and be logged in to manage it. To do both, he must have internet connection.

* **Normal Flow.** To create and account the user must click the "Sign up" button and insert his e-mail, password and name. To manage his personal profile he must access his profile page and press the "Edit Profile" button, where he can change his interests, personal description, photo... 

* **Alternative Flows and Exceptions.** 

*Manage personal agenda:*
* **Actor.** User

* **Description.** Allows the user to only see the events he's interrested in, creating an easier access to forums and specific information about and event that he might need such as location or schedule.

* **Preconditions and Postconditions.** The user has to be loggend in, have internet connection and also have added events to his personal agenda.

* **Normal Flow.** Click the personal agenda button on the bottom navegation menu. 

* **Alternative Flows and Exceptions.** If the user doesn't hasn't added any events to his personal agenda, it will appear empty.

*Participate in forums:*
* **Actor.** User

* **Description.** Give the users the oportunity to discuss the event, share opinions and interact with the speaker so they feel clarified about a specific talk or subject. The likes and dislikes systems allows the speaker to know the general punblic opinion.

* **Preconditions and Postconditions.** The user has to be logged in and have internet.

* **Normal Flow.** After loggin in, the user must access the event page in order to get ot the event forum page. After that he can comment freely and like or dislikes other user's comments.

* **Alternative Flows and Exceptions.** 

*Chat with other users:*
* **Actor.** User

* **Description.** Give the users the oportunity to talk with each other in a more personal context, making networking easier and allowing the user to create professional relationships or friends. 

* **Preconditions and Postconditions.** The user has to be logged in and have internet.

* **Normal Flow.** After clicking the chat button in the bottom navigation manu, the user must either create a chat by selecting the users he wants to message or choose and existing chat. After that he just clicks the new or already existing chat and writes the message/s he wants to send.

* **Alternative Flows and Exceptions.** 

### User stories
*As a user I want to be able to communicate and share my ideas with others easily, wherever and whenever, so that I can promote my opinion, meet new people and learn from the experience.*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/forum.png" width="160" height="350" />

As a user I want to be part of discussions of the events I am attending, so that I can find people with similar interests and clarify any doubs I might be having.

**Feature**: Forum

**Scenario**: Write a comment on forum 
*Given* a message that I want to share
*When* I write and submit it
*Then* I expect everyone to see it and answer

	Value: Must Have
	Effort: XL

  **Scenario**: See forum discussion 
    *Given* a forum that I am attending to
    *When* I open that forum
    *Then* I want to be able to see other people's comments

	Value: Must Have
	Effort: M
	
***
*As a user I want to be able to talk privately with other people, so that I can get to know them better and grow my network.*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/messages_new.png" width="160" height="350" />                       <img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/messages_chat.png" width="160" height="350" />

**Feature**: Chat

 **Scenario**: Message others
  *Given* a message that I want to share with someone
  *When* I write and send the message
  *Then* I expect the other to be able to receive it and answer it.

	Value: Could Have
	Effort: XL
***
*As a user I want to be able to see a list of my conversations so I can start chatting again easily.*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/agenda.png" width="160" height="350" />

**Feature**: Agenda

**Scenario**: Check all the events 
    *When* I open the agenda
    *Then* I expect to see all the events.

	Value: Must Have
	Effort: S
***
*As a user I want to be able to see the event's details so that I can know beforehand what each event will be about.*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/event_detail.png" width="160" height="350" />

 **Feature**: Agenda
   
   **Scenario**: See event's details
    *When* I open an event
    *Then* I expect to see it's details.

	Value: Should Have
	Effort: XS
***
*As a user I want to have a personal agenda so that I can add to it the events that I want to attend*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/events.png" width="160" height="350" />

**Feature**: Personal Agenda

  **Scenario**: Build my own agenda 
    *Given* the agenda with all the events
    *When* I want to attend a specific event
    *Then* I add to my personal agenda.

	Value: Should Have
	Effort: M
***
*As a user I want to manage my profile so that I can share my personal information.*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/profile.png" width="160" height="350" />

**Feature**: Profile

 **Scenario**: Build my own profile
    *When* I create my account
    *Then* I expect to be able to personalize my profile and share it.

	Value: Should Have
	Effort: M
***
*As a user I want to be able to see other people's interests on their profile, so that I can connect with them.*

<img src="https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/profile.png" width="160" height="350" />

  **Scenario**: Check profiles
    *Given* a person that got my interest
    *When* I open it's profile
    *Then* I expect to be able to see it's information and start chatting.

	Value: Should Have
	Effort: L

### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

![Domain Model UML](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/domain_model.png)

---

## Architecture and Design
In this section we will be talking about the overall software system organization, describing the components of the project and their interrelations and detailing the decomposition of the system in their parts (high-lever components) and the key behaviors and collaborations between them.

We'll be first explaining the high-level logical structure of the code (**Logical Architecture**) and then the high.level physical structure of the software system (**Physical Architecture**).

### Logical architecture
From the very beginning, the group opted to keep a very simple logical architecture since learning Flutter and the basics off mobile applications development would be the most important obstacles do tackle.

We can decompose the structure of the code in the following packages:
* **Widgets** - holds the most important widgets of the application, focusing mostly on the application's logic.
* **Screens** - provides an interface for the user.
* **Services** - enables the app to get information from the back-end.

When we got the hang of Flutter and tackled the most important aspects of the project the group started working towards a more well defined structure namely the **MVC** (Model View Controller) which would allow a faster development of the application and easier scalability and maintainability.

### Physical architecture
The high-level physical software system is very straightforward since the user only needs to install our mobile application. This application uses [Firebase](https://firebase.google.com) as it's backend service meaning that every bit of information about the conference, it's events and it's users are maintained on Firebase services such as [Cloud Firestore](https://firebase.google.com/docs/firestore),  [Firebase Authentication](https://firebase.google.com/docs/auth) and [Cloud Storage](https://firebase.google.com/docs/storage).

![Physycal Architecture Diagram](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/firebase.jpg)

We opted to use **Firebase** as our backend service since it allows our developers to focus on giving the user an amazing experience without having to worry about about managing data and servers. Firebase is our server, our API and our datastore, all at the same time!
This service provides a **Real Time Database** which uses WebSockets instead of HTTP connections, resulting in a much faster connection since this database does not require an HTTP request but instead the app receives the data as soon as it's updated on the database.
Firebase also provides their clients a simple way to store binary files, such as images, in the [Google Cloud Storage](https://cloud.google.com/storage/).
The Firebase Authentication also comes in really handy, since it has a built in email/password authentication system and also supports other types of authentications such as Google, Facebook, Twitter and Github. It is a pretty reliable service and lifts us the weight of having to build our own custom authentication system.

One of the hardest decisions was deciding which framework to use when developing the app. It was mainly about choosing between [Flutter](https://flutter.dev/) and [React Native](https://facebook.github.io/react-native/) since both of them allows the development of native apps in both IOS and Android. While both frameworks can be quite comparable, Flutter exceeds React Native in terms of performance, since it uses Dart as a language whose code is compiled to machine language (the same does not happen with Javascript).
Flutter has also been trending a lot in the recent past which means the opportunity for us to learn a new technology that might get the throne in the cross-platform apps development world.

### Prototype
We experimented the technology we were going to use throughout the semester, namely flutter. To give us confidence, since we already have made the mock ups, we made a prototype of the pages with hardcoded information just to create the structure of the app. The user stories that were implemented were the agenda, personal agenda, profile and event page.



---

## Implementation
During implementation, while not necessary, it 

It might be also useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. 

Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.
 
A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

For the Software project management the group opted to use [Github Projects](https://github.com/features/project-management/com) for it's simplicity and usability, where we do things such as registering tasks, assing taks, add estimations to taks, monitor tasks progress, etc.
We can also filter the tasks according to the project's iteration:

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.
  * [Iteration 1](https://github.com/softeng-feup/open-cx-verdade-productions/projects/1?card_filter_query=label%3A%22iteration+1%22)
  * [Iteration 2](https://github.com/softeng-feup/open-cx-verdade-productions/projects/1?card_filter_query=label%3A%22iteration+2%22)
  * [Iteration 3](https://github.com/softeng-feup/open-cx-verdade-productions/projects/1?card_filter_query=label%3A%22iteration+3%22)
  * [Iteration 4](https://github.com/softeng-feup/open-cx-verdade-productions/projects/1?card_filter_query=label%3A%22iteration+4%22)
