import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaListView {
        id: listView
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





