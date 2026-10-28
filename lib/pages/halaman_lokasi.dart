
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HalamanLokasi extends StatelessWidget {
  const HalamanLokasi({super.key});

  // Koordinat contoh lokasi di Bandung.
  // Silakan sesuaikan dengan lokasi kantor layanan yang digunakan.
  static const LatLng lokasiKantor = LatLng(
    -6.9747,
    107.6300,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Kantor'),
      ),
      body: Column(
        children: [
          // Informasi lokasi
          Card(
            margin: const EdgeInsets.all(12),
            child: const ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 35,
              ),
              title: Text(
                'Kantor Pelayanan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Peta lokasi menggunakan OpenStreetMap',
              ),
            ),
          ),

          // Peta OpenStreetMap
          Expanded(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: lokasiKantor,
                initialZoom: 15,
                minZoom: 5,
                maxZoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName:
                      'com.example.ta6',
                ),

                // Marker lokasi kantor
                MarkerLayer(
                  markers: [
                    Marker(
                      point: lokasiKantor,
                      width: 150,
                      height: 80,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                          Text(
                            'Kantor Pelayanan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Atribusi OpenStreetMap
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      '© OpenStreetMap contributors',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
