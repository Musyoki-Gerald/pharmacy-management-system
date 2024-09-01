# Pharmacy-Management-System
Proposed Project Title (A PHARMACY MANAGEMENT SYSTEM(TENOL)

# Proposed Solution  
The project aims to assist a pharmacy in managing its inventory, details of customers, employees 
and suppliers as well as keeping track of its purchases and sales.  

# Project Objectives   
The main objective of the project is to manage the administration of a pharmaceutical store and to 
enhance accuracy, safety and potency. 

# Other objectives.  
• To improve the maintenance and manipulation of drugs and make information 
accessible. The pharmacy management system will minimize time and resources by 
maintaining the details of the drug system so that the data can be used as quickly as 
possible. The resources that are minimized are the workforce, money, papers, etc. 
The system is user-friendly and will help the pharmacist. This system will provide 
more accurate details about drugs and the patient.   
• The system permits the user to enter a producing and ending date for a selected product 
or drug throughout gap stock and sales dealings. The computer code will save a list of 
products sold and the sales invoices etc 

# Getting Started

## Installation and Setup

1. Download and Install [XAMPP](https://www.apachefriends.org/download.html)
2. Open the XAMPP Control Panel and start Apache and MySQL.
3. Clone the repository to your system or download and extract the zipped folder.
4. Place the folder PHARMACY in *C:\xampp\htdocs*.
5. In a web browser, open *localhost/phpmyadmin*.
6. Create a new database called 'tenol' in phpmyadmin.
7. Import the file 'tenol.sql' into the database.

## Launch

1. After successfully importing, start the project by typing the following in the web browser:  *localhost/tenol/mainpage.php*   
2. Admin login interface  
This interface provides text fields that require some personal information about the administrator 
to enable logging and gaining full access to the whole system. :
    ```
    Username: gerald
	Password: 1234567 
    ```
3. Refer to the 'emplogin' table in the database for Pharmacist Login. 
    Example:
    ```
    Username: daniel
	Password: 003
    ```

# ABSTRACT  
Pharmacies have been the primary stalls where medicinal drugs are prepared or sold. They provide a range 
of healthcare services including helping people to get the most benefit from their medicines and to lead 
healthier lives. This makes the network of pharmacies a valuable asset for the provision of healthcare goals 
to improve accuracy and enhance efficiency in pharmaceutical stores and shops. The theory behind this 
project is based on the design and implementation of a pharmacy management system that provides 
sophistication to perform any task in a particular form, hence forming corresponding idealistic 
pharmacy-related activities, improving accuracy, and enhancing efficiency in the pharmacy. 

# INTRODUCTION     
A pharmacy is a retail shop which provides pharmaceutical drugs, among other products. At the 
pharmacy, the standard activities and operational model include the following; Drug designation and 
classification which consists of the arrangement of drugs according to their uses to avoid confusion. 
Shelves, racks and pallets are set in the pharmacy for accommodating the goods to be stored at the 
pharmacy which ensures air circulation and protects the drugs against humidity. A desk is required 
for the person in charge of the pharmacy for administrative work and the keeping of documents. 
Stocking areas are set up within the pharmacy for receiving medicines from suppliers. A pharmacist 
oversees the fulfilment of medical prescriptions and is available to counsel patients about 
prescription and over-the-counter drugs or about general health issues. Pharmacists have an in-depth 
knowledge of the chemistry of various drugs how they react in humans, and also how drugs interact 
with each other. The pharmacy management system is a management system that is designed to 
improve accuracy and enhance safety and efficiency in the pharmaceutical store. It is a computer-based system which helps the Pharmacist to improve inventory management, cost, and medical 
safety. 
The system allows users to enter a manufacturing and expiry date for a particular product or drug 
during opening stock and sales transactions. It also involves manual entry upon arrival of new 
batches of drugs and drug movement out of the pharmacy for a certain period, i.e. every month, the 
pharmacist may want to generate a report for the movement of drugs in and out of the pharmacy, 
getting information about the drugs e.g. expiry date, date purchased, number of drug type left, 
location of a drug in the pharmacy and managing the employees. At present, a manual system is 
being utilized in the pharmacy. It requires the pharmacist to manually monitor each drug that is 
available in the pharmacy. This usually leads to mistakes as the workload of the pharmacist 
increases. 

## Objectives
The main objectives/features of the system are:

- Ease of use 
- Deals with automation of tasks
- Provides fast search capabilities
- Time and resource utilization is maximized via digitalisation
- Generate alerts and reports as required on sales and medicines.

## Users of the System
The system is developed for use by either the **Admin** or **Pharmacists**. 

# Admin Capabilities:
 • Access and update the list of available medicines/drugs  
• Access and modify drug suppliers’ data  
• Access and update any details of new purchases of stock for the company  
• Access and update all employees’ details  
• Access and update all customers’ details  
• Keep track of all sale transactions  
• Generate and view reports based on the data 




### Screenshots

#### Admin Login Page

<img src="https://github.com/Tim-Dugan/pharmacy-management-system/blob/main/PHARMACY%20MANAGEMENT%20SYSTEM/Screenshots/Admin%20login%20interface.jpg">

#### Admin Dashboard

<img src="https://github.com/Tim-Dugan/pharmacy-management-system/blob/main/PHARMACY%20MANAGEMENT%20SYSTEM/Screenshots/Admin%20dashboard.jpg">

# Pharmacist Capabilities:  
• View the inventory of medicines, their price, quantity and other details – no changes are 
allowed from a pharmacist' point of view  
• View minimal details regarding existing customers  
• Add a new customer to their database  
• Make a new sale and register the sale details onto the database. 

### Screenshots

#### Pharmacist Login Page

<img src="https://github.com/Tim-Dugan/pharmacy-management-system/blob/main/PHARMACY%20MANAGEMENT%20SYSTEM/Screenshots/Pharmacist%20Login%20Screen.jpg">

#### Pharmacist DashBoard

<img src="https://github.com/Tim-Dugan/pharmacy-management-system/blob/main/PHARMACY%20MANAGEMENT%20SYSTEM/Screenshots/Pharmacist%20dashboard.jpg">


## Database Architecture
 
**MEDS: 
Contains details regarding the list of all medicines, mainly their type, the quantity 
currently present in the store and their price. 

**SUPPLIERS: 
Contains details regarding any of the drug suppliers who supply stock to the 
pharmacy. PURCHASE: Contains details regarding any stock purchased by the company. 
Purchasing a stock consists of placing an order for multiple medicines and multiple suppliers via a 
single purchase on an online platform on a date as specified by the purchase date (based on the 
date of delivery). It also contains the manufacturing and expiry dates for the purchased items. 

**EMPLOYEES: 
Contains details regarding all employees, including Admin, Managers and 
Pharmacists.  

** CUSTOMERS:  
Contains details of all customers for ease during sales transactions.  

**SALES: 
Contains details regarding all sales made by the pharmacy. It keeps track of the sale 
invoice number, the customer ID of the customer, the employee ID of the employee who 
conducted the sales, the total amount of sales and the sale date and time.  

**SALES_ITEMS:
Contains details regarding the particular medicines sold during each sale. It 
keeps track of the sale invoice number, the medicine ID, the quantity of that medicine purchased 
and the total cost for that particular sale.  

**ADMIN: 
Contains the employee ID, the username and the password for the Admin. Only a single 
record exists. Admin capabilities can be implemented only by this login.  

**EMPLOGIN: 
Contains the employee ID, the employee username and password for all the 
pharmacists and managers, apart from Admin. Pharmacist capabilities can be implemented by 
using any of the login details in the table. 

### ER Diagram

<img src="https://github.com/">

### Relational Database Model

<img src="https://github.com/">


## Project Overview:  
It is a web-based application implemented using Hypertext Preprocessor (PHP) with MySQL as 
the Database Management System. User Interface is designed using Hypertext Markup 
Language 5 (HTML5), Cascading Style Sheets 3 (CSS3) and JavaScript.  

## Software Requirements  
Operating System: Windows 10/Windows 11  
64-bit operating system, x64-based processor  
MySQL Database  

## Hardware Requirements  
Minimum Hardware requirements  
Processor 3.0GHZ processor speed  
SSD 120GB/HDD 500GB  
Memory 4GB/8GB RAM  
Visual display unit 800*600colors (1366*768 high colors)  

## Additional Information
-Check the triggers, procedures, and functions for further understanding.
-If a new employee has been added, their login details can only be added using the database server.
-Admin login details can only be changed using the database server.
For major changes, please open an issue first to discuss what you would like to change.

*Feel free to contact for any further queries via geraldmusyoki49@gmail.com*










