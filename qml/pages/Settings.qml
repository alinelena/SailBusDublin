import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: settingsDialog
    onAccepted: {
                    _serverURL = rtpiURL.text;
                    saveSettings();
    } 
    Column {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium
            DialogHeader {
                title: qsTr("Settings")
                acceptText: qsTr("Save")
                cancelText: qsTr("Cancel")
            }
            Label {
                x: Theme.paddingLarge
                text: "rtpi server:"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            TextField {
                id: rtpiURL
                x: Theme.paddingLarge
                placeholderText: "http://www.yourdomain.com:port/"
                anchors.right: parent.right
                anchors.left: parent.left
                inputMethodHints: Qt.ImhNoPredictiveText
            }
        }

    Component.onCompleted: {
        loadSettings();
    }

    function loadSettings() {
        console.log("Loading Settings");
        _serverURL = SailBusDublin.getSetting("RTPIserver", "");

        if ( _serverURL!= "") {
            rtpiURL.text = _serverURL;
        }
    }

    function saveSettings() {
        console.log("Saving Settings");
        SailBusDublin.setSetting("RTPIserver", _serverURL);
    }
}
