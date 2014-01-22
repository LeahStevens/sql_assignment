**Case 1**

As a business owner that is thinking about expanding into the world market.  
I want to get data on the countries that we export goods to the most.  
In order to know if my product will be easy to export/sell/market.

  Usage: ./import_export stats "Exports" 

  Acceptance Criteria:
 * Prints out a country name with the amount we export to them.



**Case 2**

As a student who is studying international business.  
I want to get information on what countries we have good business relationships with.  
In order to know what language I should learn.

  Usage: ./import_export stats "Countries" 

  Acceptance Criteria:
  * Prints out top 5 countries we import from.
  * Prints out top 5 countries we export to.
  


**Case 3**
 
As an American who wants to change how many goods we import from China.     
I want to update the exact numbers for my pro "Made in America" campaign.     
In order to show the progress we are making.  

  Usage: ./import_export --Country "China"

  Acceptance Criteria:
  * Prints out the amount of goods we import from China
  * Asks for new data by year, export/import, and month.
  * Uploads new data into exports and imports by Country.

  

**Case 4**

As an International Spy who wants to control the flow of information.  
I want to delete the current records on imports and exports.  
In order to hide how much business our countries do with each other.


  Usage: ./import_export delete "Year" --Country "India" 

  Acceptance Criteria:
  * Deletes data out of exports or imports by Country.
  * Removes full records for that Country unless specified otherwise.



**Case 5**

As a person who wants to keep my database up to date.   
I want to create a row of data for each new year.    
In order to add Imports and Exports for each year.   

  Usage: ./import_export create --Year "2014" --Country "Country name" --Month "3" --Imports "1931" --Exports "2983"
  
  Acceptance Criteria:
  * Creates a new year and allows for updating that year's data. 
  * Asks a series of questions regarding that year.

  





 
