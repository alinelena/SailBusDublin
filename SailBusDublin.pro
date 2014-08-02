# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-sailbusdublin

CONFIG += sailfishapp

SOURCES += \
    src/harbour-sailbusdublin.cpp \
    src/sailbusdublin.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/dublin-bus-api.js \
    qml/state.js \
    qml/pages/EnterNumber.qml \
    qml/pages/Route.qml \
    qml/pages/Stop.qml \
    qml/pages/Settings.qml \
    rpm/harbour-sailbusdublin.yaml \
    rpm/harbour-sailbusdublin.spec \
    harbour-sailbusdublin.desktop \
    harbour-sailbusdublin.png \
    qml/harbour-sailbusdublin.qml
HEADERS += \
    src/sailbusdublin.h

