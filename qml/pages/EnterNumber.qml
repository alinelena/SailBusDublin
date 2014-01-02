import QtQuick 2.0
import Sailfish.Silica 1.0
import "../state.js" as StateLogic

Page {
    function successRoute() {
        Qt.dublinBusState = StateLogic.state;
        pageStack.push(Qt.resolvedUrl("Route.qml"));
    }

    function successStop() {
        Qt.dublinBusState = StateLogic.state;
        pageStack.push(Qt.resolvedUrl("Stop.qml"));
    }

    function error() {
        console.log("Error");
    }

    id: page
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "Open Stop"
                onClicked: StateLogic.state.openStop(routenumber.text.toUpperCase().trim(), successStop, error)
            }
            MenuItem {
                text: "Open Route"
                onClicked: StateLogic.state.openRoute(routenumber.text.toUpperCase().trim(), successRoute, error)
            }
        }

        contentHeight: column.height
        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Enter Route or Stop Number"
            }
            TextArea {
                id: routenumber
                width: parent.width
                inputMethodHints: Qt.ImhPreferNumbers
            }
        }
    }
}
