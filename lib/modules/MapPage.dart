import 'package:flutter/material.dart';

class  MapPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class MapPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Museum Map'),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(0, 0),
//           zoom: 0,
//           minZoom: -2,
//           maxZoom: 2,
//           interactiveFlags: InteractiveFlag.all,
//         ),
//         layers: [
//           OverlayImageLayerOptions(
//             overlayImages: [
//               OverlayImage(
//                 bounds: LatLngBounds(
//                   LatLng(1, -1),
//                   LatLng(-1, 1),
//                 ),
//                 opacity: 1.0,
//                 imageProvider: AssetImage('assets/map.jpg'),
//               ),
//             ],
//           ),
//           MarkerLayerOptions(
//             markers: _createMarkers(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Marker> _createMarkers() {
//     return [
//       _buildMarker(0.5, -0.5, 'Pharaonic'),
//       _buildMarker(-0.5, 0.5, 'Islamic'),
//       // Add more markers as needed
//     ];
//   }
//
//   Marker _buildMarker(double lat, double lng, String label) {
//     return Marker(
//       width: 80.0,
//       height: 80.0,
//       point: LatLng(lat, lng),
//       builder: (ctx) => Container(
//         child: Column(
//           children: [
//             Icon(Icons.location_on, size: 40, color: Colors.red),
//             Text(label, style: TextStyle(color: Colors.black)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: MapPage(),
//   ));
// }
