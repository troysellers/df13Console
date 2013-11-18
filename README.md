df13Console
===========

Code artifacts that support our Dreamforce 13 session, Supercharge Your Salesforce Console

Presentation at Dreamforce 5:15pm Wednesday 20th November 2013

What is contained in this repository

1 - Canvas Console Application.
This is the complete Java application that was deployed to Heroku to simulate an ERP system existing off platform. (Struts 2 / Apache Tiles)
The files that demonstrate the canvas integration are 
	- src/main/webapp/templates/component.jsp (javascript lib includes)
	- src/main/webapp/pages/component.jsp (javascript interaction with canvas framework for eventing)
	- src/main/java/com/force/aus/df13/canvas/interceptors/SignedRequestInterceptor.java (processing the Canvas Signed Request)
	- src/repo (contains dependencies that aren't in the central maven repository)
	
2 - Salesforce Artifacts
This is a collection of the SFDC artifacts that were demonstrated during the session.
Not an installable package.

	