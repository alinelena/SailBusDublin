# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = SailBusDublin

CONFIG += sailfishapp

SOURCES += src/SailBusDublin.cpp

OTHER_FILES += qml/SailBusDublin.qml \
    qml/cover/CoverPage.qml \
    rpm/SailBusDublin.spec \
    rpm/SailBusDublin.yaml \
    SailBusDublin.desktop \
    qml/dublin-bus-api.js \
    qml/state.js \
    qml/pages/EnterNumber.qml \
    qml/pages/Route.qml \
    SailBusDublin.png \
    qml/pages/Stop.qml

