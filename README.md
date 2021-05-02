# Sections
A simple app to show sections


#### Objective

The goal of the project is to build a simple app that uses `viaplay:sections and presents these sections to the user. The user should also be able to navigate to these sections
The basic feature set of the app is: 

-  The user should be able to navigate to all sections returned from the API
-  The user should be able to see the title and description of the page they have navigated to
-  The app should work online and offline

API Used: https://content.viaplay.se/ios-se

#### Tech Stack

1. XCode 12.4
2. Swift 5.3

#### Solution Approach

Project is structured into 

- Modules : - This is where all the specific module or feature related code goes in.
- Shared :- All shared components goes in here
- Webservice - All API related components goes in here
- OfflineServices - Classes that handle Offline 

App uses a customized MVP pattern. Every module will have a
- `View/ ViewController` :- Takes care of the UI/ UX
- `DataStore `:- Takes care of the business logic and presentation manipulations
- `Model`:- Any datamodel as and when required.

Views are created programmatically for better re-use.

Basic App Flow:-

The landing page of the app is `SectionsViewController` which holds a tableView to list out the sections. `SectionsDataStore` handles all the business logic and data manipulation. `SectionsDataStore` takes in a `NetworkManager`and `OfflineManager` which are responsible for fetching the data and handle offline respectively. Once the data store finish fetching the data, reload data for tableView is executed and cells are populated using convenience functions from `SectionsDataStore`, to keep viewcontrollers light weight. In the similar lines detail view is also populated.

Offline:- 
#### Approach 1
For offline initial thought was to use coredata with preloaded data and later update it from API. Considering the scope and timeline of the assignment, I considered to drop this approach as it requires quite a lot of cases to be handled, however the plan is to do this approach if time permits

#### Approach 2
Use preloaded `json` payload as offline data and load the data as it is available from the API. The respective `DataStores` uses the right data source to get the necessary data. A banner is shown to the user to let them know that the data might be old. Used `Combine` to subscribe to connectivity changes.


#### Assumptions made

1. Sections have unique id
2. No fancy UI

#### Technical Debts

1. Error handling can be improved
2. Unit testing.
3. Core data imiplementation
