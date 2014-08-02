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
import "pages"
import harbour.SailBusDublin 1.0 

ApplicationWindow
{
    property string _serverURL:  SailBusDublin.getSetting("RTPIserver", "")
    
    initialPage: Component { EnterNumber { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


