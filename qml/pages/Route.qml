import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    function successStop() {
        pageStack.push(Qt.resolvedUrl("Stop.qml"));
    }

    function error() {
        console.log("Error");
    }
    SilicaListView {
        id: listView

        PullDownMenu {
            MenuItem {
                text: "Sort by Name"
                onClicked: {
                    Qt.dublinBusState.sortRoute(false);
                    pageStack.replace(Qt.resolvedUrl("Route.qml"));
                }
            }
            MenuItem {
                text: "Sort by Number"
                onClicked: {
                    Qt.dublinBusState.sortRoute(true);
                    pageStack.replace(Qt.resolvedUrl("Route.qml"));
                }
            }
        }

        model: Qt.dublinBusState.getNumberOfStops()
        anchors.fill: parent
        header: PageHeader {
            title: Qt.dublinBusState.getCurrentRoute() + " - Bus"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: Qt.dublinBusState.getNthStopOnRouteString(index)
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: Qt.dublinBusState.openStopOnRoute(index, successStop, error)
        }
        VerticalScrollDecorator {}
    }
}
