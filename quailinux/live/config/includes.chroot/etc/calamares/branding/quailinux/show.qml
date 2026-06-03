import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 20000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Image {
            id: welcomeImage
            source: "/usr/share/quailinux/artwork/wallpaper.png"
            width: 467; height: 280
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: welcomeImage.horizontalCenter
            anchors.top: welcomeImage.bottom
            text: qsTr("Installing QuaiLinux.<br/>This should only take a few minutes.")
            wrapMode: Text.WordWrap
            width: 600
            horizontalAlignment: Text.Center
        }
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }
}
