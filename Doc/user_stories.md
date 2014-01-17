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

  As an American who wants to know how many goods we import from China.
  I want to get the exact numbers for my pro "Made in America" campaign.
  In order to know how best to incite public outrage.

  Usage: ./import_export stats "China"

  Acceptance Criteria:
  * Prints out the amount of goods we import from China
  * Prints out total goods we import, then can calculate from there.
  

**Case 4**

  As an International Spy who wants to control the flow of information.
  I want to update and delete the current records on imports and exports.
  In order to hide how much business our countries do with each other.

  Usage: ./import_export update/delete "Countries"

  Acceptance Criteria:
  * Deletes data out of exports or imports by Country.
  * Uploads new data into exports and imports  by Country.



