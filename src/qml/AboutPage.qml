import QtQuick 2.0

import Controller 1.0

Page {
    id: root
    page: Controller.AboutPage
    readonly property bool showKeyboardBindings: !_controller.isMobile
    MouseArea {
        anchors.fill: parent
        onClicked: {
            // Don't collapse
            mouse.accepted = false
        }

        Item {
            z: 1
            anchors.fill: parent

            SmallText {
                id: versionText
                anchors.top: parent.top
                anchors.topMargin: _style.marginMedium
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight
                text: qsTr("Version") + ": " + _controller.version + (_controller.gitDate ? " (" + _controller.gitDate + ")" : "")
            }

            SmallText {
                id: copyrightText
                anchors.top: versionText.bottom
                anchors.topMargin: _style.marginMedium * 2
                text: "<html>Copyright (C) 2013-2014 Klarälvdalens Datakonsult AB, a KDAB Group company, <a href=\"mailto:info@kdab.com\">info@kdab.com</a><br>" +
                      qsTr("Author") + ": Sérgio Martins &lt;<a href=\"sergio.martins@kdab.com\" >sergio.martins@kdab.com</a>&gt;<br>" +
                      "Copyright (C) 2014 Sérgio Martins &lt;<a href=\"mailto:iamsergio@gmail.com\">iamsergio@gmail.com</a>&gt;<br>"
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }

            RegularText {
                id: keysText
                text: qsTr("Keyboard bindings") + ":"
                anchors.top: copyrightText.bottom
                anchors.topMargin: _style.marginSmall
                anchors.left: parent.left
                anchors.leftMargin: _style.marginMedium
                font.bold: true
                visible: root.showKeyboardBindings
            }

            Grid {
                id: keyGrid
                visible: root.showKeyboardBindings
                anchors.top: keysText.bottom
                anchors.topMargin: _style.marginSmall
                anchors.left: parent.left
                anchors.leftMargin: _style.marginMedium
                columns: 2
                columnSpacing: _style.marginMedium

                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: "<space>"
                }

                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    text: qsTr("Pauses/Resumes an ongoing pomodoro")
                    renderType: _controller.textRenderType
                }

                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: "S"
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    text: qsTr("Stops an ongoing pomodoro")
                    renderType: _controller.textRenderType
                }

                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: "Up/Down"
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: qsTr("Select tasks")
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: "Del"
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    text: qsTr("Deletes a selected task or an ongoing one")
                    renderType: _controller.textRenderType
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: "Enter"
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    text: qsTr("Starts a selected task, or expands the window")
                    renderType: _controller.textRenderType
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: "Esc"
                }
                Text  {
                    font.pixelSize: _style.smallTextSize
                    color: _style.smallTextColor
                    renderType: _controller.textRenderType
                    text: qsTr("Collapses the window")
                }
            }

            Text {
                id: optionsText
                renderType: _controller.textRenderType
                anchors.top: keyGrid.bottom
                font.pixelSize: _style.smallTextSize
                anchors.left: parent.left
                anchors.topMargin: _style.marginMedium
                anchors.leftMargin: _style.marginMedium
                color: _style.smallTextColor
                text: qsTr("Build options") + ": " + (_controller.isMobile ? "mobile, " : "desktop, ")
                      + (_storage.webDAVSyncSupported ? "webdav, " : "no-webdav, ")
                      + (_controller.openSSLSupported ? "openssl" : "no-openssl")
                      + (_controller.hackingMenuSupported ? ", hacking" : "")
            }

            Text {
                id: dataPathText
                renderType: _controller.textRenderType
                anchors.top: optionsText.bottom
                font.pixelSize: _style.smallTextSize
                anchors.left: parent.left
                anchors.topMargin: _style.marginMedium
                anchors.leftMargin: _style.marginMedium
                anchors.right: parent.right
                anchors.rightMargin: _style.marginMedium
                color: _style.smallTextColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: qsTr("Data file") + ": " + _storage.dataFile();
            }

            SmallText {
                id: githubText
                anchors.top: dataPathText.bottom
                anchors.topMargin: 10 * _controller.dpiFactor
                text: "Source: <html><a href=\"https://github.com/iamsergio/flow-pomodoro\">https://github.com/iamsergio/flow-pomodoro</a>"
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
            SmallText {
                id: licenseText
                anchors.top: githubText.bottom
                text: "License: <html><a href=\"https://github.com/iamsergio/flow-pomodoro/blob/master/License.txt\">https://github.com/iamsergio/flow-pomodoro/blob/master/License.txt</a>"
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }

            PushButton {
                z: 2
                text: qsTr("OK")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: _style.marginSmall

                onClicked: {
                    _controller.currentPage = Controller.MainPage
                }
            }
        }
    }
}
