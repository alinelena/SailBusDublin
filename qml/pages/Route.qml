import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    property bool loading: false
    function successStop() {
        page.loading = false;
        pageStack.push(Qt.resolvedUrl("Stop.qml"));
    }

    function error() {
        page.loading = false;
        console.log("Error");
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: page.loading
        visible: page.loading
    }

    SilicaListView {
        id: listView
        visible: !page.loading
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
            onClicked: {
                page.loading = true;
                Qt.dublinBusState.openStopOnRoute(index, successStop, error);
            }
        VerticalScrollDecorator {}
        }
    }
}
