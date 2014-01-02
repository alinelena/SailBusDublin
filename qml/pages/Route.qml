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
