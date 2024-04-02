# Check Detail Reader/Analyzer Specificartion
A simple web app that allows users to upload pdf documents, receive an analysis of the detail, and be able to print a CSV version if necessary using Amazon Textract API.

## Pain Point
Having to manually read and type out information from financial files that come in PDF format and not being able to run an analysis on check detail until it has been processed into a CRM.

## User Stories
- As a user, I want to be able to log in/register for an account and upload PDF's.
- As a user , I want to be able to see red flags that appear with a dues amounts after processing a pdf through the web app.
- As a user, I want to be able to download a CSV file of the PDF i jus uploaded.
- As a user, I want to be able to have the system prompt me if there was an issue deciding what numbers or letters to use whenever the OCR runs into issues.
- As a user, I want to be able to see a history of red flags, possibly even a graph, from the employer I select.
- As a user, I want to be able to select the employer I want from a drop down list that includes all the employers. 
- As a user, I want the web app to be visually appealing and not cluttered so it looks safe and simple.

## Domain Model

### users
- id
- created_at
- updated_at
- email
- password
- admin
- full_name

### employers
- id
- created_at
- updated_at
- user_id
- rate
- name

### checks
- id
- created_at
- updated_at
- period_ending_date
- employer_id
- check_num
- check_amount

### members
- id
- created_at
- updated_at
- first_name
- last_name
- address
- total_wages_earned
- dues_payment
- cope_payment
- check_id

### check_infractions
- id
- created_at
- updated_at
- detail_infraction_count
- check_id
