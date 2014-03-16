/*
* Copyright (c) 2014 Shane Quigley
*
* This software is MIT licensed see link for details
* http://www.opensource.org/licenses/MIT
*
* @author Shane Quigley
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: coverPage
    property bool loading: false
    function successStop() {
        var length = (Qt.dublinBusState.getStopData().length > 5 ? 5 : Qt.dublinBusState.getStopData().length),
            index = 0,
                text = "Stop: " + Qt.dublinBusState.getCurrentStop() + "\n";
        for (index = 0; index < length; index++) {
            text += Qt.dublinBusState.getStopData()[index].route + " - " + Qt.dublinBusState.getStopData()[index].time + " min\n"
        }
        label.text = text;
        coverPage.loading = false;
    }

    function error() {
        console.log("Error");
        coverPage.loading = false;
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: coverPage.loading
        visible: coverPage.loading
    }

    Label {
        id: label
        anchors.centerIn: parent
        text: "Dublin Bus"
        visible: !coverPage.loading
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                if (Qt.dublinBusState !== undefined) {
                    coverPage.loading = true;
                    Qt.dublinBusState.openStop(Qt.dublinBusState.getCurrentStop(), successStop, error);
                }
            }
        }
    }
}
