# Bookstore App
A simple Bookstore app created for exploring the CloverGo SDK. Users can purchase books using CloverGo's SDK to process payments.

### Before you run this mess:
* Install Python or some other tool to run a simple server on `localhost:8000`
* Install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html "CocoaPods Guides - Getting Started")

### How to run this mess:
1. Run the command `pod install` in the `Bookstore` directory. Make sure the directory has a Podfile in it.
2. Get a server running on `localhost:8000` so custom url links can be redirected to the app
    * Using Terminal or a similar program, navigate to the `exampleServer` directory and start the server using the command `python -m SimpleHTTPServer`
    * Note: I'm using Python version 2.7.11, so if you have another version look up the syntax
3. Open the `Bookstore` folder and open `Bookstore.xcworkspace` in XCode. 
    * May or may not compile in XCode 9.1. I had to downgrade to XCode9 since 9.1 is a bit sensitive with compiling different versions of Swift.
4. Build it/run it? 
5. Click the `Connect` button on the first screen to connect to the CloverGo system. Type in your sandbox credentials when prompted and click `Open` to go back to the app.
6. Click on the `Store` tab and click on any of the books' `Buy` buttons.
7. Enter sample payment information and click `Submit`

An alert should pop up saying `Sale isn't authorized` because this isn't a real app, but it doesn't. Currently trying to figure out why there's no sale response in the `CloverGoConnectorListener` class. It's a mystery.
¯\\_(ツ)_/¯
