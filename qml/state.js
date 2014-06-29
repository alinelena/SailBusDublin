.import "dublin-bus-api.js" as DublinBus

/*
* Copyright (c) 2014 Shane Quigley
*
* This software is MIT licensed see link for details
* http://www.opensource.org/licenses/MIT
*
* @author Shane Quigley
*/

/*global DublinBus: false*/
/*jslint devel: true, white: true*/

var state = (function() {
    "use strict";
    var stops = [],
        stop, stopData, routeNumber;

    function openRoute(number, changePageCallback, error) {
        console.log("openRoute");
        routeNumber = number;
        DublinBus.api.getRouteData(number, function (busStops) {
            stops = busStops;
            changePageCallback();
        }, error);
    }

    function getNumberOfStops() {
        return stops.length;
    }

    function getNthStopOnRouteString(index) {
        return stops[index].number + " - " + stops[index].name;
    }

    function openStop(number, changePageCallback, error) {
        console.log("openStop");
        stop = number;
        DublinBus.api.getStopData(number, function (buses) {
            console.log("openStop - success");
            stopData = buses;
            changePageCallback();
        }, error);
    }

    function openStopOnRoute(index, changePageCallback, error) {
        openStop(stops[index].number, changePageCallback, error);
    }

    function getCurrentRoute() {
        return routeNumber;
    }

    function getCurrentStop() {
        return stop;
    }

    function getStopData() {
        return stopData;
    }

    function getBusString(i) {
        var bus = stopData[i];
        return bus.route + " - " + bus.destination + " - " + (bus.time !== "Due" ? bus.time + " min" : bus.time);
    }

    //sortRoute:
    //  synchronous function which sorts the current route in the state
    //  input boolean numberRatherThanPlace:
    //  true will sort By StopNumber
    //  false will sort by Named Location
    function sortRoute(numberRatherThanPlace) {
        if (numberRatherThanPlace) {
            stops.sort(function (a, b) {return a.number - b.number;});
        } else {
            stops.sort(function (a, b) {
                if (a.name > b.name) {
                    return 1;
                }
                if(b.name > a.name) {
                    return -1;
                }
                return 0;
            });
        }
    }

    function getStopLocation() {
        var currentStop = stops.filter(function (s) { return s.number === stop; });
        if(currentStop.length > 0) {
            return currentStop[0].location;
        }
        return false;
    }

    return {
        openRoute: openRoute,
        sortRoute: sortRoute,
        getNumberOfStops: getNumberOfStops,
        getNthStopOnRouteString: getNthStopOnRouteString,
        openStop: openStop,
        openStopOnRoute: openStopOnRoute,
        getCurrentRoute: getCurrentRoute,
        getCurrentStop: getCurrentStop,
        getStopData: getStopData,
        getBusString: getBusString,
        getStopLocation: getStopLocation
    };
}());
