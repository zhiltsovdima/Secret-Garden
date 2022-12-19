# Secret-Garden
UIKit app for storing your plants collection and the ability to browse the product store 

<img src="https://user-images.githubusercontent.com/50846656/208388696-ee2ca791-dd6c-4984-b616-e73d799aa5d6.PNG" width = 20% height = 20%> <img src="https://user-images.githubusercontent.com/50846656/208388925-867d9344-8898-440c-a76e-451d25f220c1.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208389023-0698e4c8-3790-4a11-aaaa-7c783aac26d6.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208389095-9c3bd6ff-bea2-488c-a657-991b0bdba175.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208389107-25288bae-c35a-4412-8b9e-db84caeb624e.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208389120-9330aece-374f-465d-8e65-5c711300df8f.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208391394-831977ef-2238-4316-a65a-1226cfa5e5f9.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208391424-89896483-ee75-42ca-a7f6-f960e0e8380a.PNG" width = 20% height = 20%>
<img src="https://user-images.githubusercontent.com/50846656/208391472-ac5cf102-07ae-4a50-9aa2-2a9ad623765d.PNG" width = 20% height = 20%>

Tech Stack: UIKit, MVC, SPM, FireBase, FileManager

Description: the project for storing a personal collection of plants with the implementation of the upload from the internet features of the plant, also with implementation of the interface of the plant store

Implementation:
- TabBarController, NavigationController
- AlertController, PopViewController
- TableView, CollectionView with a supplementaryView
- Custom Cells
- Delegation/completionHandlers
- Downloading images from Camera/PhotoLibrary
- Downloading data from the internet for a plant added by user
- Saving/Loading json data using a FileManager
- Downloading shop data from FireBase
- Little number of unit tests
- Checking the application for memory leaks
- Design, AppIcon, LaunchScreen

List of things planned for implementation:
- Dark mode
- Cache for loaded images
- SearchBar
- Stepper for CartVC
- List of tips
- Possibly change the way plants are saved/loaded from the FileManager
- Refactoring and code improvement
- UX/UI improvements
- More tests!

In the long run:
- Change the architecture of the app
- Add a plant watering reminder
- Add a note diary for the plant(with more photos)
- Visual effects of adding to cart/favorites
- CoreML (plant recognizer, search or creation a small coreML model)
- Further developing the shoping cart(maybe)
