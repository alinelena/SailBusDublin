/*global test:false, asyncTest:false, start:false, expect:false, ok:false, api:false*/
(function () {
    'use strict';
    asyncTest("Get Stop Location Data", function() {
        expect(3);
        api.getStopLoc(1998, function (location) {
            var latlong = location.split(",");
            ok(latlong.length === 2, "Badly formated lat-long");
            ok(!isNaN(parseFloat(latlong[0])), "Badly formated lat");
            ok(!isNaN(parseFloat(latlong[1])), "Badly formated long");
            start();
        }, function () {
            ok(false, "Back-end issue");
            start();
        });
    });
}());
