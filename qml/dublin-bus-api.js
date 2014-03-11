var api = (function () {
    "use strict";
    var routeCache = {};
    function networkCall(url, callback, errorcallback) {
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    callback(request.responseText);
                } else {
                    errorcallback();
                }
            }
        };
        request.open("GET", url, true);
        request.send(null);
    }

    function getStopData(number, callback, errorCallback) {
        networkCall("http://192.168.1.66:4567/bus/stop/" + number,
        function (response) {
            var responseJSON = JSON.parse(response);
            console.log(responseJSON.errorcode);
            if(responseJSON.errorcode === "0") {
                var buses = [];
                for(var i = 0; i< responseJSON.results.length; i+=1) {
                    buses.push({
                        time: responseJSON.results[i].duetime,
                        destination: responseJSON.results[i].destination,
                        route: responseJSON.results[i].route
                    });
                }
                callback(buses);
            } else {
                errorCallback(responseJSON.errormessage);
            }
        }, errorCallback);
    }

    function getStopLoc(number, callback, errorCallback) {
        networkCall("http://192.168.1.66:4567/location/stop/" + number,
        function (response) {
            var responseJSON = JSON.parse(response);
            console.log(responseJSON.errorcode);
            if(responseJSON.errorcode === "0") {
                if(responseJSON.results && responseJSON.results.length > 0) {
                    var stopInfo = responseJSON.results[0];
                    callback(stopInfo.latitude + "," + stopInfo.longitude);
                }
            } else {
                errorCallback(responseJSON.errormessage);
            }
        }, errorCallback);
    }

    function getRouteData(number, callback, errorCallback) {
        networkCall("http://192.168.1.66:4567/bus/route/" + number,
        function (response) {
            var responseJSON = JSON.parse(response);
            console.log(responseJSON.errorcode);
            if(responseJSON.errorcode === "0") {
                //TODO: Hack to get it to work with current state API need UI to deal with both directions
                var stops = responseJSON.results[0].stops.map(function (el) {
                    return {"number":el.stopid,"name":el.shortname,"location": el.latitude + "," + el.longitude};
                });
                callback(stops);
            } else {
                errorCallback(responseJSON.errormessage);
            }
        }, errorCallback);
    }

    return {
        getRouteData: getRouteData,
        getStopData: getStopData,
        getStopLoc: getStopLoc
    };
}());
