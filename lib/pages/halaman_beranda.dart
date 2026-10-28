import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Selamat Datang!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Nusantara Cerdas Mobile membantu masyarakat '
          'mengakses layanan secara lebih mudah.',
        ),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.location_city,
              size: 40,
            ),
            title: const Text('Nusantara Cerdas'),
            subtitle: const Text(
              'Aplikasi layanan masyarakat berbasis digital.',
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Gunakan menu navigasi untuk melihat layanan '
          'dan daftar pengajuan.',
        ),
      ],
    );
  }
}