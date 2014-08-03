include ("../global.pri")

TEMPLATE = app
TARGET = flow

QT += quick

qtHaveModule(widgets) {
    QT += widgets
}

contains(QT_CONFIG, dbus) {
    QT += dbus
    SOURCES += dbus/flow.cpp
    HEADERS += dbus/flow.h
    DEFINES += FLOW_DBUS
}

SOURCES += archivedtasksfiltermodel.cpp \
           checkabletagmodel.cpp \
           controller.cpp  \
           main.cpp        \
           pluginmodel.cpp \
           quickview.cpp   \
           settings.cpp    \
           sortedtagsmodel.cpp \
           storage.cpp \
           tag.cpp \
           tagref.cpp \
           tagstorage.cpp \
           tagstorageqsettings.cpp \
           taskstorage.cpp \
           taskstorageqsettings.cpp \
           task.cpp \
           taskfilterproxymodel.cpp \
           tooltipcontroller.cpp

HEADERS += archivedtasksfiltermodel.h \
           checkabletagmodel.h \
           controller.h      \
           genericlistmodel.h \
           plugininterface.h \
           pluginmodel.h     \
           quickview.h       \
           settings.h        \
           sortedtagsmodel.h \
           storage.h \
           tag.h \
           tagref.h \
           tagstorage.h \
           tagstorageqsettings.h \
           task.h            \
           taskfilterproxymodel.h \
           taskstorage.h \
           taskstorageqsettings.h \
           tooltipcontroller.h

OTHER_FILES += AboutPage.qml      \
               config/General.qml \
               config/Plugins.qml \
               config/Tag.qml     \
               config/Tags.qml    \
               ClickableImage.qml \
               ConfigurePage.qml  \
               DecentTabView.qml  \
               DefaultStyle.qml   \
               Main.qml           \
               MainPage.qml       \
               ModalDialog.qml    \
               Page.qml           \
               QuestionPopup.qml  \
               RegularText.qml    \
               SmallText.qml      \
               TagsMenu.qml       \
               Task.qml           \
               TaskEditorDialog.qml \
               TaskListView.qml \
               TaskTextField.qml \
               TitleText.qml     \
               ToolTip.qml


RESOURCES += resources.qrc

linux {
    QMAKE_POST_LINK += "runqmllint.sh"
}

DESTDIR = ../
