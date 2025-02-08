import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class AppMap extends StatelessWidget {
  const AppMap({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(latitude, longitude),
        initialZoom: 16.2,
      ),
      children: [
        TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.armancoders.billitnow'),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () async => await launchUrl(
                  Uri.parse('https://openstreetmap.org/copyright'),
                  mode: LaunchMode.platformDefault),
            ),
          ],
        ),
        MarkerLayer(markers: [
          Marker(
              point: LatLng(latitude, longitude),
              width: 60.0,
              height: 60.0,
              child: Icon(
                Icons.location_on,
                size: 40,
                color: Colors.red,
              ))
        ])
      ],
    );
  }
}
