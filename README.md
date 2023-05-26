# Robot Framework Automated Testing for Todo App

This repository contains automated test cases written in Robot Framework using the Selenium library for testing the Todo App. The test cases verify various functionalities of the Todo App, such as adding new todos, deleting todos, updating completion status, and retrieving todos.

## Prerequisites

- Maven: Ensure that Maven is installed on your system.
- Spring Boot: Make sure you have the Todo App project set up and running.
- Robot Framework: Install Robot Framework
- Selenium Library: Install the Selenium library for Robot Framework


## Test Cases

#### a. Add new TODO
Verify that a user can add a new TODO, and after submit, it is added 
in the table and all text inputs are empty.

#### b. Delete
Verify user can delete a TODO, and it is removed from the table.

#### c. Update completion
Verify user can update the completion of TODO, by click the 
checkbox, and the table display it in the wright way.

#### d. Get all TODOs
Verify that all TODO is displayed correctly

#### e. Get completed TODOs
Verify that the table display only completed TODO
