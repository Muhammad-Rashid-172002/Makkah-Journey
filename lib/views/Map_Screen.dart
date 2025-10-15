import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  final LatLng makkah = const LatLng(21.4225, 39.8262);
  final LatLng madinah = const LatLng(24.4686, 39.6142);

  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Makkah & Madinah Map',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          // 🗺️ The map itself
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: makkah,
              initialZoom: 7.5,
              maxZoom: 18,
              minZoom: 6,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=5h61oQQ3aUNh0Of4GLJ9',
                userAgentPackageName: 'com.mrtechnologies.hajjapp',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: makkah,
                    width: 80,
                    height: 80,
                    child: Column(
                      children: const [
                        Icon(Icons.location_on, color: Colors.green, size: 45),
                        Text(
                          "Makkah",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Marker(
                    point: madinah,
                    width: 80,
                    height: 80,
                    child: Column(
                      children: const [
                        Icon(Icons.location_on, color: Colors.red, size: 45),
                        Text(
                          "Madinah",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedLocation != null)
                    Marker(
                      point: _selectedLocation!,
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.push_pin,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // 🎯 Confirm button - pinned above bottom navigation
          Positioned(
            bottom: 80, // 👈 adjust depending on your bottom nav bar height
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              onPressed: () {
                if (_selectedLocation != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tap on map to select a location.'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check, color: Colors.white),
              label: const Text(
                "Confirm Location",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // 🕋 Top-right quick access buttons
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "makkah",
                  mini: true,
                  backgroundColor: Colors.green,
                  onPressed: () {
                    _mapController.move(makkah, 13);
                  },
                  child: const Icon(Icons.place),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "madinah",
                  mini: true,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _mapController.move(madinah, 13);
                  },
                  child: const Icon(Icons.place),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
