import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
        PullDownMenu {
            MenuItem {
                text: "Refresh"
                onClicked: {
                    Qt.dublinBusState.openStop(Qt.dublinBusState.getCurrentStop(), function () {
                        pageStack.replace(Qt.resolvedUrl("Stop.qml"));
                    }, function() {
                        console.log("Error")
                    });
                }
            }
            MenuItem {
                text: "Open Location"
                onClicked: {
                    var loc = Qt.dublinBusState.getStopLocation();
                    if (loc) {
                        Qt.openUrlExternally("geo:" + loc);
                    }
                }
                visible: Qt.dublinBusState.stopOpenedByRoute
            }
        }
        model: Qt.dublinBusState.getStopData().length
        anchors.fill: parent
        header: PageHeader {
            title: Qt.dublinBusState.getCurrentStop() + " - Stop"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: Qt.dublinBusState.getBusString(index)
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }
        VerticalScrollDecorator {}
    }
}





