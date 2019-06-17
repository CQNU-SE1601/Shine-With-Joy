import Felgo 3.0
import QtLocation 5.5
import QtQuick 2.5
import QtPositioning 5.12 //使用定位
NavigationStack {
  // show the map
  AppMap {
    anchors.fill: parent

    // configure map provider
    plugin: Plugin {
      name: "mapbox"
      // configure your own map_id and access_token here
      parameters: [  PluginParameter {
          name: "mapbox.mapping.map_id"
          value: "mapbox.streets"
        },
        PluginParameter {
          name: "mapbox.access_token"
          value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
        },
        PluginParameter {
          name: "mapbox.mapping.highdpi_tiles"
          value: true
        }]
    }

    // configure the map to try to display the user's position
    showUserPosition: true
    zoomLevel: 13

    // check for user position initially when the component is created
    Component.onCompleted: {
      if(userPositionAvailable)
        center = userPosition.coordinate
    }

    // once we successfully received the location, we zoom to the user position
    onUserPositionAvailableChanged: {
      if(userPositionAvailable)
        zoomToUserPosition()
    }
  }
}
