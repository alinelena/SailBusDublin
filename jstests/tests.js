/*global test:false, asyncTest:false, start:false, expect:false, ok:false, module:false, api:false*/
(function () {
    'use strict';
    module("Dublin Bus API");
    asyncTest("Get Stop Location Data", function() {
        expect(3);
        api.getStopLoc(1998, function (location) {
            var latlong = location.split(",");
            ok(latlong.length === 2, "Well formated lat-long");
            ok(!isNaN(parseFloat(latlong[0])), "Well formated lat");
            ok(!isNaN(parseFloat(latlong[1])), "Well formated long");
            start();
        }, function () {
            ok(false, "Issue occurred check the backend is working if so it's an issue with the js");
            start();
        });
    });

    asyncTest("Get Stop Location with bad data", function() {
        expect(1);
        api.getStopLoc(17987987, function () {
            ok(false, "Shouldn't get here");
            start();
        }, function () {
            ok(true, "Error function was called correctly");
            start();
        });
    });

    asyncTest("Get Route Data", function() {
        api.getRouteData(123, function (stops) {
            ok(stops.length > 0, "Returned non-empty stops array");
            stops.forEach(function (el) {
                var latlong;
                ok(el.number !== undefined, "Has a number");
                ok(el.name !== undefined, "Has a name");
                ok(typeof el.name === "string", "Name is string");
                ok(el.name !== "", "Name is non empty");
                ok(el.location !== undefined, "Has a location");
                latlong = el.location.split(",");
                ok(latlong.length === 2, "Well formated lat-long");
                ok(!isNaN(parseFloat(latlong[0])), "Well formated lat");
                ok(!isNaN(parseFloat(latlong[1])), "Well formated long");
            });
            start();
        }, function () {
            ok(false, "Issue occurred check the backend is working if so it's an issue with the js");
            start();
        });
    });

    asyncTest("Input Bad Route Data", function() {
        api.getRouteData("1aoiud q23", function () {
            ok(false, "Shouldn't be called");
            start();
        }, function () {
            ok(true, "Error function was called correctly");
            start();
        });
    });

    //Only works while buses are running so either mock up a test server(best approach)
    //or check time in the test cases and don't fail after 11:30 Dublin time
    asyncTest("Get Stop Real Time Data", function() {
        api.getStopData(1998, function (buses) {
            ok(buses.length > 0, "Returned non-empty buses array");
            buses.forEach(function (el) {
                ok(el.time !== undefined && el.time !== "", "Has a non empty time");
                ok(el.route !== undefined && el.route !== "", "Has a  non empty route");
                ok(el.destination !== undefined && el.destination !== "", "Has a non empty destination");
            });
            start();
        }, function () {
            ok(false, "Issue occurred check the backend is working if so it's an issue with the js");
            start();
        });
    });

    asyncTest("Input a non existent stop to RTPI", function() {
        api.getStopData(179998, function () {
            ok(false, "Shouldn't be called");
            start();
        }, function () {
            ok(true, "Error function was called correctly");
            start();
        });
    });

    asyncTest("Input a messy string as a stop", function() {
        api.getStopData("lklkdoa", function () {
            ok(false, "Shouldn't be called");
            start();
        }, function () {
            ok(true, "Error function was called correctly");
            start();
        });
    });
}());
