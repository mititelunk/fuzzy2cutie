LANGUAGE = C++
QT -= gui
CONFIG += release
DEFINES += J_FUZZY_QT_LIBRARY
UI_DIR = ./src.gen/ui
MOC_DIR = ./src.gen/moc
OBJECTS_DIR = ./src.gen/obj
DESTDIR = ./build
win32-msvc|win32-msvc.net|win32-msvc2002|win32-msvc2003|win32-msvc2005|win32-msvc2008:TEMPLATE = vclib
else:TEMPLATE = lib
TARGET = fuzzy2cutie
DEFINES += FUZZY2CUTIE_LIBRARY
INCLUDEPATH += .
INCLUDEPATH += ../jfuzzyqt-1.11/include/
DEPENDPATH += .
# Input
HEADERS += Fuzzy2Cutie.h\
        fuzzy2cutie_global.h \
    fuzzy2cutie_global.h
SOURCES += Fuzzy2Cutie.cpp

INCLUDEPATH += $$system(pg_config --includedir)
INCLUDEPATH += $$system(pg_config --includedir-server)

LIBS += -L../jfuzzyqt-1.11/build/ -ljfuzzyqt
LIBS += -L$$system(pg_config --libdir) -lpq

OTHER_FILES += \
    fuzzy2cutie.sql \
    card.fcl \
    risk_card.dat \
    risk_card.fcl
