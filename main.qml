import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import "Composants"
import "GestionActions"

Item {
    width: 1600
    height: 800
    Rectangle
    {
        //Creation of a custom wallpaper
        id: rectangle
        anchors.fill: parent
        LinearGradient {
            id: linearGradient
            anchors.right: parent.right
            anchors.rightMargin: parent.width/2
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            start: Qt.point(0, 0)
            end: Qt.point(parent.width/2, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0d0d0d" }
                GradientStop { position: 1.0; color: "#262626" }
            }


        }

        LinearGradient {
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            start: Qt.point(parent.width/2, 0)
            end: Qt.point(0, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0d0d0d" }
                GradientStop { position: 1.0; color: "#262626" }
            }
        }

        ListModel
        {
            id:listModel
            ListElement{ _nom:" " ;     index : 0 }
            ListElement{ _nom:" " ;         index : 1 }
            ListElement{ _nom:" " ;      index : 2 }
            ListElement{ _nom:"Édition Action" ;        index : 3 }
            ListElement{ _nom:" " ;     index : 4 }
            ListElement{ _nom:" " ;    index : 5 }
            ListElement{ _nom:" " ;            index : 6 }
        }

        SelecteurOnglets {
            id: selecteurOnglets
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            model:listModel
        }

        SwipeView
        {
            id:swipeview
            currentIndex: selecteurOnglets.indiceAffiche
            anchors.right: rectangle.right
            anchors.rightMargin: 0
            anchors.left: selecteurOnglets.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.leftMargin: 0
            interactive: false
            orientation: Qt.Vertical
            clip:true

            Item
            {
                id: item1
            }
            Item
            {
                id: item2
            }
            Item
            {
                id: item3
            }
            MainPageGestionActions
            {
                id: mainPageGestionActions
            }
            Item
            {
                id: item5
            }
            Item
            {
                id: item6
            }
            Item
            {
                id: item7
            }
        }
    }
}
