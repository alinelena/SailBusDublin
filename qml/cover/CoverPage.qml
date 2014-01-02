import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    function successStop() {
        var length = (Qt.dublinBusState.getStopData().length > 5 ? 5 : Qt.dublinBusState.getStopData().length),
            index = 0,
                text = "Stop: " + Qt.dublinBusState.getCurrentStop() + "\n";
        for (index = 0; index < length; index++) {
            text += Qt.dublinBusState.getStopData()[index].route + " - " + Qt.dublinBusState.getStopData()[index].time + " min\n"
        }
        label.text = text;
    }

    function error() {
        console.log("Error");
    }
    Label {
        id: label
        anchors.centerIn: parent
        text: "Dublin Bus"
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: (Qt.dublinBusState !== undefined ? Qt.dublinBusState.openStop(Qt.dublinBusState.getCurrentStop(), successStop, error) : undefined)
        }
    }
}


