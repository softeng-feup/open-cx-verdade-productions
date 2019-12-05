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
We are developing an app that will hold information about the event, and for each one there will be a forum/chat where people can comment or chat about the event. Users will be able to create profiles and define their interests getting the opportunity to connect with other people with similar ones.


---
## Elevator Pitch
Conference attendees are often frustrated with the lack of time to communicate and network with others, not experiencing the conference at its best.
Our product enables the attendees to enjoy their time spent at the conference while not having to worry about trivial things, making you feel part of the environment that surrounds you. 
Being people that also love to attend at conferences, it strikes us that conferences with good content result in a poor experience. Hence, we understand how the attendees feel and how that can be changed.
With our app, dead time will be turned into productivity and personal value.
Here's the link for the app. I'll hope to get your feedback, so that your experiences can keep improving! 

---
## Requirements
Our main objective is to help the people that attend conferences guiding them through it and enabling them to discuss and share their ideas with others in a simple and easy way.

About the **nonfunctional requirements** we decided it was better to focus on **usability**, since our product will  empower its users with a lot of features, while keeping it simple and intuitive. We want the user to do what it wants, without having to think to much! 
We will also pay particular attention to **reliability** because it is extremely important for us, that the user can always make full use of the app and enjoy its conference without stressing out.
**Portability** is something that we considerate a lot as well, so that all users can make the most of our app, in any platform they want.
 
The **functional requirements** are exposed on the [Use case diagram](#Use-case-diagram) and [User stories](#User-stories) sections.

### Use case diagram 
![Use Case Diagram](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/Use-case.jpg)


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
***
*As a user I would like to get recommendations (users and events) based on my interests, so that I can find what I am interested in effortlessly.*
***

### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

---

## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

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
