
Summary

We are a local home cleaning company called Homework. Today we are keeping track of all our bookings using a spreadsheet and we want to move it into a web application instead using Ruby on Rails. Our main goal with this project is to make it possible for customers to schedule a booking online. I've already created the scaffolding of the app for you and now I need you to add some functionality to it. This should take you about 1-2 hours, but you have up to 4 hours to complete it.

Deliverables

- All models and columns should have validation as described in the model spec below.
- Currently we operate in 10 cities, but plan to expand quickly. We need a way to store the list of cities we operate in and the ability to add to the list. You should create a new table to do this.
- On the Cleaner Form we need a way to select the cities a cleaner works in. This should be a checkbox list populated by the list of cities we operate in. You may need to need to create a new table to store this data.
- We need a way for customers to signup and schedule a booking all on one form. To accomplish this you will need to do the following:
  1. Create a new root page for the application with a form designed for customers to signup and create a booking.
  2. On this form, capture all the data needed to create a customer in the database (first name, last name, phone number).
  3. If the customer already exists in the database (use phone number to determine this) use the existing record instead of creating a new one. You should probably add a validation to enforce this.
  4. Let the customer select what city they are in from the cities table created earlier.
  5. Let the customer specify a date and time when they would like their house cleaned.
  6. When the user submits the form, look for cleaners that work in the specified city that do not have any bookings that conflict with the time specified.
  7. If you can find an available cleaner, create the booking and display the name of the cleaner assigned to the booking.
  8. If you can't find an available cleaner, tell the user that we could not fulfill their request.
  9. Write tests for the parts of the application you feel need it the most.

Models

-- customer
first_name (required)
last_name (required)
phone_number (optional)

-- booking
customer (required)
cleaner (required)
date (required)

-- cleaner
first_name (required)
last_name (required)
quality_score (required, must be a number between 0.0 and 5.0)

Restrictions

- Do not remove git from your application directory.
- No additional third-party gems other than those already included
