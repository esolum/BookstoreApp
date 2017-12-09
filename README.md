# Bookstore App
A simple Bookstore app created for exploring the CloverGo SDK. Users can purchase books using CloverGo's SDK to process payments.

### Before you run this mess:
* Install Python or some other tool to run a simple server on `localhost:8000`

### How to run this mess:

1. Get a server running on `localhost:8000` so custom url links can be redirected to the app
    * Using Terminal or a similar program, navigate to the `exampleServer` directory and start the server using the command `python -m SimpleHTTPServer`
    * Note: I'm using Python version 2.7.11 so if you have another version figure it out
2. Open the `Bookstore` folder and open `Bookstore.xcworkspace` in XCode. 
    * May or may not compile in XCode 9.1. I had to downgrade to XCode9 since 9.1 is a bit sensitive with compiling different versions of Swift.
3. Build it/run it? 
4. Click the `Connect` button on the first screen to connect to the CloverGo system. Type in your sandbox credentials when prompted and click `Open` to go back to the app.
5. Click on the `Store` tab and click on any of the books' `Buy` buttons.
6. Enter sample payment information and click `Submit`

An alert should pop up saying `Sale isn't authorized` because this isn't a real app, but it doesn't. Currently trying to figure out why there's no sale response in the `CloverGoConnectorListener` class. It's a mystery.
¯\\_(ツ)_/¯
