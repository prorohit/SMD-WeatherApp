# SMD-WeatherApp
Weather App

# Steps to Run Project:
1. Open Terminal in Mac Machine.
2. Clone the project from github using command.
  git clone https://github.com/prorohit/SMD-WeatherApp.git
3. Open  "WeatherApp.xcworkspace" file using XCode.
4. In terminal run command pod install. This is an optional step
4. Press [Command + R] to run the project.
5. Press [Command + U] to run test cases and generate code coverage report.

# Architecture Explanation:
1. MVVM Achitecture as been implemented to complete this Test assignment.
    https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/MVVM.png
2. Cocoa pods has been used as a dependency manager. So, in order to run the project, please open "WeatherApp.xcworkspace" file in xcode.
3. Object Oriented Programming (OOP|) and  Protocol Orinted Programming  (POP) paradigm has been followed.
4. Central Network Layer Has been followed using the Generics and Protocols oriented Aproach.
5. Project Code is written using Swift and using native technology code without using third part libraries of Cocoa pods (Only SVProgressHud pod is used in the project).

# Test Cases:
1. Unit Test Cases has been written in order to cover the business logic written in the View models.
2. Test case coverage report is also generated as shown in screen shot:
    https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/TestCoverage.png
    
# Project UI work flow

1. https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/UI/1.PNG
2. https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/UI/2.PNG
3. https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/UI/3.PNG
4. https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/UI/4.PNG
5. https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/UI/5.PNG
6. https://github.com/prorohit/SMD-WeatherApp/blob/master/ScreenShots/UI/6.PNG

# Part 1 - Cities weather information separated by comma (,)
#1 Copy the following cURL in the postman to test the API
curl \
 'https://api.openweathermap.org/data/2.5/weather/?q=Dubai&appid=287247cce4410857d4e8ae6c74d9ac01' \
 -X GET \
 
 #2.  https://api.openweathermap.org/data/2.5/weather/?q=Dubai&appid=287247cce4410857d4e8ae6c74d9ac01

# Part 2 - 5Days 3 Hours Data
#1 Copy the following cURL in the postman to test the API.
curl \
 'https://api.openweathermap.org/data/2.5/weather/?q=Dubai&appid=287247cce4410857d4e8ae6c74d9ac01' \
 -X GET \
 
 #2 https://api.openweathermap.org/data/2.5/weather/?q=Dubai&appid=287247cce4410857d4e8ae6c74d9ac01'
