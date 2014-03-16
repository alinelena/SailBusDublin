.import "dublin-bus-api.js" as DublinBus

/*
* Copyright (c) 2014 Shane Quigley
*
* This software is MIT licensed see link for details
* http://www.opensource.org/licenses/MIT
*
* @author Shane Quigley
*/

var state = (function() {
    var stops = [],
        stop = undefined,
        stopData = undefined,
        routeNumber = undefined,
        stopOpenedByRoute = false;

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
        return bus.route + " - " + bus.destination + " - " + bus.time + " min"
    }

    //sortRoute:
    //  synchronous function which sorts the current route in the state
    //  input boolean numberRatherThanPlace:
    //  true will sort By StopNumber
    //  false will sort by Named Location
    function sortRoute(numberRatherThanPlace) {
        if (numberRatherThanPlace) {
            stops.sort(function (a, b) {return a.number - b.number});
        } else {
            stops.sort(function (a, b) {
                if (a.name > b.name) {
                    return 1;
                } else if(b.name > a.name) {
                    return -1;
                } else {
                    return 0;
                }
            });
        }
    }

    function getStopLocation() {
        for (var i = 0; i < stops.length; i += 1) {
            if (stops[i].number === stop) {
                return stops[i].location;
            }
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
