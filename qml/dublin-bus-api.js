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

    function padNumber(number) {
        var out, i, originalLength;
        out = number.toString();
        originalLength = out.length;
        for (i = 0; i < 5 - originalLength; i += 1) {
            out = "0" + out;
        }
        console.log(out);
        return out;
    }

    function checkedBuses(buses) {
        var i = 0;
        for (i = 0; i < buses.length; i += 1) {
            if (buses[i].time < 0) {
                buses.splice(i, 1);
            }
        }
        if (buses.length > 0) {
            return true;
        }
        return false;
    }

    function getStopData(number, callback, errorCallback) {
        networkCall("http://rtpi.ie/Text/WebDisplay.aspx?stopRef=" + padNumber(number),
        function (reponse) {
            var table, i, rows, buses, time, timerow;
            table = reponse.match(/<table(\s|\S)+\/table>/);
            if (table && table.length > 1) {
                rows = table[0].split("</tr>");
                buses = [];
                time = new Date();
                for (i = 0; i < rows.length - 1; i += 1) {
                    if (i !== 0) {
                        if (rows[i].split("</td>")[2].match(/\d+:\d+/) === null) {
                            buses.push({
                                route: rows[i].match(/\d+/)[0],
                                destination: rows[i].split("</td>")[1].replace(/<td[^>]+>/, ""),
                                time: rows[i].split("</td>")[2].match(/\d+/)[0]
                            });
                        } else {
                            timerow = rows[i].split("</td>")[2].match(/\d+:\d+/)[0].split(":");
                            buses.push({
                                route: rows[i].match(/\d+/)[0],
                                destination: rows[i].split("</td>")[1].replace(/<td[^>]+>/, ""),
                                time: (parseInt(timerow[0], 10) * 60 + parseInt(timerow[1], 10)) - (time.getHours() * 60 + time.getMinutes())
                            });
                        }
                    }
                }
                if (checkedBuses(buses)) {
                    callback(buses);
                } else {
                    errorCallback();
                }
            } else {
                errorCallback();
            }
        }, errorCallback);
    }

    function grabNumber(href) {
        var matching = href.match(/\/\d+/)[0];
        return parseInt(matching.replace(/\/[0]+/, ""), 10);
    }

    function getRouteData(number, callback, errorCallback) {
        var url = "http://dublinbus-api.heroku.com/stops?routes=" + number;
        if (routeCache[url] === undefined) {
            networkCall(url, function(response) {
                var data = JSON.parse(response).data,
                    i = 0;
                for (i = 0; i < data.length; i += 1) {
                    data[i].number = grabNumber(data[i].href);
                }
                routeCache[url] = data;
                callback(data);
            }, errorCallback);
        } else {
            callback(routeCache[url]);
        }
    }

    return {
        getRouteData: getRouteData,
        getStopData: getStopData
    };
}());
