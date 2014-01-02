.import "dublin-bus-api.js" as DublinBus

var state = (function() {
    var stops = [],
        stop = undefined,
        stopData = undefined,
        routeNumber = undefined;

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

    return {
        openRoute: openRoute,
        getNumberOfStops: getNumberOfStops,
        getNthStopOnRouteString: getNthStopOnRouteString,
        openStop: openStop,
        openStopOnRoute: openStopOnRoute,
        getCurrentRoute: getCurrentRoute,
        getCurrentStop: getCurrentStop,
        getStopData: getStopData,
        getBusString: getBusString
    };
}());
