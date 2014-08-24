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
import "../state.js" as StateLogic

Page {
    id: page
    property bool loading: false
    function successRoute() {
        page.loading = false;
        Qt.dublinBusState = StateLogic.state;
        Qt.dublinBusState.stopOpenedByRoute = true;
        pageStack.push(Qt.resolvedUrl("Route.qml"));
    }

    function successStop() {
        page.loading = false;
        Qt.dublinBusState = StateLogic.state;
        Qt.dublinBusState.stopOpenedByRoute = false;
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

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: "Settings"
                onClicked: {
                    page.loading = false;
                    pageStack.push(Qt.resolvedUrl("Settings.qml"));
                }
            }
            MenuItem {
                text: "Open Stop"
                onClicked: {
                    page.loading = true;
                    StateLogic.state.openStop(routenumber.text.toUpperCase().trim(), successStop, error);
                }
            }
            MenuItem {
                text: "Open Route"
                onClicked: {
                    page.loading = true;
                    StateLogic.state.openRoute(routenumber.text.toUpperCase().trim(), successRoute, error);
                }
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
            SearchField {
                id: routenumber
                width: parent.width
                inputMethodHints: Qt.ImhPreferNumbers
            }
            SilicaListView {
              id: favourites
              width: page.width 
              height: page.height/2
              header: PageHeader{
                title: "Favourite Stops"
              }
              anchors.fill: routenumber.bottom
              spacing: Theme.paddingSmall
              model: 10 
              property Item contextMenu
              delegate: Item {
                id: myFavItem
                property bool menuOpen: favourites.contextMenu != null && favourites.contextMenu.parent === myFavItem

                 width: ListView.view.width
                 height: menuOpen ? favourites.contextMenu.height + delFav.height : delFav.height
                 BackgroundItem {
                   id: delFav
                   width:parent.width
                   Label { 
                     x: Theme.paddingLarge
                     text: { favourites.getFavStop(index) }
                     anchors.verticalCenter: parent.verticalCenter
                     color: delFav.highlighted ? Theme.highlightColor : Theme.primaryColor
                   }
                   onClicked: {
                    page.loading = true
                    StateLogic.state.openStop(favourites.getFavStop(index), successStop, error)
                  }
                  onPressAndHold: {
                    if (!favourites.contextMenu) {
                      favourites.contextMenu = contextMenuComponent.createObject(favourites)
                    }
                    favourites.contextMenu.show(myFavItem)
                   }
                }
              }
              VerticalScrollDecorator {}
              function getFavStop(index) {
                if (index==0) {
                  return 903;
                } else {
                  return index;   
                }   
              }
              RemorsePopup { 
                id: remorse 
              }
              function remove(i) {
                remorse.execute(qsTr("Removing"), function() {
                console.log("removeFavStop("+i+")")
              });
              }
              Component {
                id: contextMenuComponent
                ContextMenu {
                  MenuItem {
                    text: "Remove"
                    onClicked: favourites.remove(favourites.currentIndex);
                  }
                }
             }
           }
        }
    }
}
