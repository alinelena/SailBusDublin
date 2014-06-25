SailBus Dublin
==============

Real Time Information App for Dublin bus for the Sailfish Operating System on the new Jolla smartphones.

#### Architecture:

* RTPI API
* Sinatra Server (Ruby)
* Local Dublin Bus API (JS)
* Application State Object (JS)
* Graphical Layer (QML)

#### Note for anyone who wants to contribute:

* Use the Google Style Guide for JS
* If you change the JS make it JSLint compliant 
	* If your adding more directives unless it's something like a global to access a qunit function. Ask first
* Make sure the unit tests pass before sending a pull request
    * To run the unit tests:

    `cd jstests/`<br/>
    `./test.sh`<br/>
    `#This will start a sintra server & open firefox to run qunit and blanket`

#### License:

* This software is MIT licensed see link for details

* http://www.opensource.org/licenses/MIT
