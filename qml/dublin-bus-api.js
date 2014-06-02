/*
* Copyright (c) 2014 Shane Quigley
*
* This software is MIT licensed see link for details
* http://www.opensource.org/licenses/MIT
*
* @author Shane Quigley
*/

/*jslint browser: true, devel: true, white: true */

var api = (function () {
    "use strict";
    var routeCache = {},
        apiBase = "";
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
        networkCall(apiBase + "/bus/stop/" + number, function (response) {
            var responseJSON = JSON.parse(response),
                buses = [],
                i = 0;
            console.log(responseJSON.errorcode);
            if(responseJSON.errorcode === "0") {
                for(i = 0; i< responseJSON.results.length; i+=1) {
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
        networkCall(apiBase + "/location/stop/" + number, function (response) {
            var responseJSON = JSON.parse(response),
                stopInfo;
            console.log(responseJSON.errorcode);
            if(responseJSON.errorcode === "0") {
                if(responseJSON.results && responseJSON.results.length > 0) {
                    stopInfo = responseJSON.results[0];
                    callback(stopInfo.latitude + "," + stopInfo.longitude);
                }
            } else {
                errorCallback(responseJSON.errormessage);
            }
        }, errorCallback);
    }

    function getRouteData(number, callback, errorCallback) {
        if(!routeCache[number]) {
            networkCall(apiBase + "/bus/route/" + number, function (response) {
                var responseJSON = JSON.parse(response),
                    stops = [];
                console.log(responseJSON.errorcode);
                if(responseJSON.errorcode === "0") {
                    responseJSON.results.forEach(function (el) {
                        el.stops.forEach(function (el) {
                            stops.push({"number":el.stopid,"name":el.shortname,
                                "location": el.latitude + "," + el.longitude});
                        });
                    });
                    routeCache[number] = stops;
                    callback(stops);
                } else {
                    errorCallback(responseJSON.errormessage);
                }
            }, errorCallback);
        } else {
            callback(routeCache[number]);
        }
    }

    return {
        getRouteData: getRouteData,
        getStopData: getStopData,
        getStopLoc: getStopLoc
    };
}());
