#-------------------------------------------------
#
# Project created by QtCreator 2013-03-25T23:56:59
#
#-------------------------------------------------

QT       -= core gui

TARGET = fuzzy2cutie
TEMPLATE = lib

DEFINES += TEN_LIBRARY

SOURCES += Fuzzy2Cutie.cpp

HEADERS += Fuzzy2Cutie.h\
        ten_global.h

INCLUDEPATH += /usr/include/postgresql

symbian {
    MMP_RULES += EXPORTUNFROZEN
    TARGET.UID3 = 0xE026014E
    TARGET.CAPABILITY = 
    TARGET.EPOCALLOWDLLDATA = 1
    addFiles.sources = ten.dll
    addFiles.path = !:/sys/bin
    DEPLOYMENT += addFiles
}

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}

OTHER_FILES += \
    fuzzy2cutie.sql
