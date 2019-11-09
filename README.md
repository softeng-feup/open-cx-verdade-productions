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
We are developing an app that will hold information about the event, and for each one there will be a forum/chat where people can comment or chat about the event. Users will be able to create profiles and define their interests getting the opportunity to connect with other people with similar ones. They will also be able to trade user data with their microbit badge.


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

![Messages Chat](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/messages_chat.png =100x300)



*As a user I want to have a open discussion about the event and its topics through forums so that I can clearify things.* 

![Forum](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/forum.png)



*As a user I want to be connected with the speakers so that I can freely ask them questions.* 

![Messages New](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/messages_new.png)



*As a user I want to be part of discussions of the events I am attending, so that I can find people with similar interests.* 

![Forum](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/forum.png)



*As a user I want to be able to talk privately with other people, so that I can get to know them better and grow my network.* 

![Messages List](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/messages_list.png)



*As a user I would like to get recommendations (users and events) based on my interests, so that I can find what I am interested in effortlessly.*

 *As a user I want to have a personal agenda so that I can add to it the events that I want to attend.* 
 
 ![Agenda](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/agenda.png)
 
 

*As a user I want to have a complete agenda with all the events' information so that I can filter and pick the ones I am interested in.* 

![Events](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/events.png)



*As a user I want to be able to see other people's interests on their profile, so that I can connect with them.*

![Profile](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/profile.png)



 *As a user I want to get notified in time, so that I don't miss the events that interest me the most.* 

*As a user I want to manage my profile so that I can share my personal information.* 

![Profile](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/profile.png)



*As a speaker I want to promote my ideas and projects so that I can find people I can work with and grow my network.* 

![Event Detail](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/event_detail.png)



*As a speaker I want to share my knowledge and experience so that I can help people to be better and make better decisions.* 

![Event Detail](https://github.com/softeng-feup/open-cx-verdade-productions/blob/master/docs/event_detail.png)



*As an admin I want to supervise the discussions and intervene accordingly, banning users if necessary, so that I can make sure everything is peaceful and well organized.*


This section will contain the requirements of the product described as **user stories**, organized in a global **user story map** with **user roles** or **themes**.

For each theme, or role, you may add a small description. User stories should be detailed in the tool you decided to use for project management (e.g. trello or github projects).

A user story is a description of desired functionality told from the perspective of the user or customer. A starting template for the description of a user story is 

*As a < user role >, I want < goal > so that < reason >.*


**INVEST in good user stories**. 
You may add more details after, but the shorter and complete, the better. In order to decide if the user story is good, please follow the [INVEST guidelines](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

**User interface mockups**.
After the user story text, you should add a draft of the corresponding user interfaces, a simple mockup or draft, if applicable.

**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in Gherkin), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.

**Value and effort**.
At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method) and the team should add an estimation of the effort to implement it, for example, using t-shirt sizes (XS, S, M, L, XL).

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

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:
  * [Trello.com](https://trello.com)
  * [Github Projects](https://github.com/features/project-management/com)
  * [Pivotal Tracker](https://www.pivotaltracker.com)
  * [Jira](https://www.atlassian.com/software/jira)

We recommend to use the simplest tool that can possibly work for the team.
