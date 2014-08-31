import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 1.0

import Controller 1.0
import ".."

Item {
    id: root
    anchors.fill: parent

    Column {
        anchors.topMargin: _style.marginSmall
        anchors.fill: parent
        spacing: 2 * _controller.dpiFactor
        Button {
            text: qsTr("Remove duplicate tasks")
            onClicked: {
                _storage.removeDuplicateData()
            }
        }
        Button {
            visible: _storage.webDAVSyncSupported
            text: qsTr("WebDAV Sync")
            onClicked: {
                _controller.webDavSync()
            }
        }
        Button {
            text: qsTr("Dump debug info")
            onClicked: {
                _storage.dumpDebugInfo()
            }
        }
    }
}
