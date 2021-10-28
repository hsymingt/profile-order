#  README

### Libraries used:
* Combine - used to execute both API requests concurrently 

### Things to note:
* In the case that the call to /users fails, I display an error state view, but in the case that the call to /config fails, I made the decision to provide a default configuration so that the profiles would still appear
* Did not implement any form of image caching since each image only needs to be downloaded/displayed once
* Set NSAllowsArbitraryLoads to true inside info.plist in order to bypass ATS and allow http connection 
* Didn't get around to writing tests but I'm happy to add some if desired!

### Build Tools & Versions
* Xcode 13
* iOS 15
