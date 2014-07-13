import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.0

import Controller 1.0
import ".."

Item {
    id: root
    anchors.fill: parent

    SmallText {
        id: noTagsText
        anchors.centerIn: parent
        text: qsTr("No tags")
        visible: _tagStorage.model.count === 0
        horizontalAlignment: Text.AlignHCenter
    }


    Flow {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: _style.marginMedium
        anchors.rightMargin: 40 * _controller.dpiFactor
        anchors.topMargin: _style.marginBig
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5

        move: Transition {
            NumberAnimation { properties: "x"; duration: _style.tagMoveAnimationDuration }
        }

        Text {
            id: invisible_helper
            text: "Invisible Item"
            visible: false
            font.pointSize: _style.tagFontSize
            font.bold: _style.tagFontBold
            color: _style.tagFontColor
        }

        Repeater {
            model: _tagStorage.model
            delegate:
            Item {
                id: item
                height: invisible_helper.height + 2 *  _controller.dpiFactor
                width: label.contentWidth + taskCountLabel.contentWidth + 30

                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        _controller.editTag(tag.name)
                        textField.text = tag.name
                        textField.forceActiveFocus()
                    }

                    onPressAndHold: {
                        _controller.editTag(tag.name)
                        textField.text = tag.name
                        textField.forceActiveFocus()
                    }

                    Rectangle {
                        anchors.fill: parent
                        border.width: _style.tagBorderWidth
                        border.color: _style.tagBorderColor
                        color: _style.tagBackgroundColor
                        radius: _style.tagRadius

                        TextField {
                            id: textField
                            focus: true
                            objectName: "Tag text field"
                            anchors.centerIn: parent
                            visible: tag.beingEdited
                            width: parent.width + 2
                            text: tag.name
                            style: TextFieldStyle {
                                 textColor: "black"
                                 background: Rectangle {
                                     radius: 6
                                     implicitWidth: 100
                                     implicitHeight: 24
                                     border.color: "#333"
                                     border.width: 1
                                 }
                            }
                            onAccepted: {
                                _controller.renameTag(tag.name, textField.text)
                            }
                            onActiveFocusChanged: {
                                if (!activeFocus) {
                                    _controller.editTag("")
                                }
                            }
                        }

                        Text {
                            id: label
                            font.pointSize: invisible_helper.font.pointSize
                            color: _style.tagFontColor
                            font.bold: true
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            anchors.verticalCenterOffset: 2
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height
                            text: tag.name
                            visible: !tag.beingEdited
                        }

                        Text {
                            id: taskCountLabel
                            anchors.left: label.right
                            text: !tag.taskCount ? "" : " (" + tag.taskCount + ")"
                            font.pointSize: _style.tagFontSize - 2
                            anchors.verticalCenterOffset: -1
                            anchors.verticalCenter: parent.verticalCenter
                            color: _style.tagFontColor
                            visible: !tag.beingEdited
                        }

                        ClickableImage {
                            id: deleteImage
                            source: "qrc:/img/delete.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: _style.buttonsSpacing
                            visible: !tag.beingEdited

                            function reallyRemove()
                            {
                                _tagStorage.removeTag(tag.name);
                            }

                            onClicked: {
                                if (tag.taskCount > 0) {
                                    _controller.showQuestionPopup(this, qsTr("There are tasks using this tag. Are you sure you want to delete it?"), "reallyRemove()")
                                } else {
                                    _tagStorage.removeTag(tag.name)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    ClickableImage {
        // Just for testing purposes
        id: playImage
        source: "qrc:/img/add.png"
        anchors.bottom: parent.bottomight
        visible: true
        onClicked: {
            _tagStorage.createTag("Test" + _tagStorage.model.count)
        }
    }
}