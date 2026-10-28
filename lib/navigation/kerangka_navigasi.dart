
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_lokasi.dart';
import '../pages/halaman_warga.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _selectedIndex = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanLokasi(),
    HalamanWarga(),
  ];

  void _ubahHalaman(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Badge jumlah pengajuan pada menu Warga.
  Widget _ikonWarga() {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (daftarPengajuan) => daftarPengajuan.length,
      builder: (context, totalPengajuan) {
        return Badge(
          isLabelVisible: totalPengajuan > 0,
          label: Text('$totalPengajuan'),
          child: const Icon(Icons.person),
        );
      },
    );
  }

  // Badge jumlah pengajuan pada NavigationRail.
  Widget _ikonWargaTerpilih() {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (daftarPengajuan) => daftarPengajuan.length,
      builder: (context, totalPengajuan) {
        return Badge(
          isLabelVisible: totalPengajuan > 0,
          label: Text('$totalPengajuan'),
          child: const Icon(Icons.person),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lebarLayar = MediaQuery.of(context).size.width;

    // Navigasi untuk layar lebar.
    if (lebarLayar >= 800) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _ubahHalaman,
              labelType: NavigationRailLabelType.all,
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: Text('Layanan'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map),
                  label: Text('Lokasi'),
                ),
                NavigationRailDestination(
                  icon: _ikonWarga(),
                  selectedIcon: _ikonWargaTerpilih(),
                  label: const Text('Warga'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _halaman[_selectedIndex],
            ),
          ],
        ),
      );
    }

    // Navigasi untuk layar kecil.
    return Scaffold(
      body: _halaman[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _ubahHalaman,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.miscellaneous_services_outlined),
            selectedIcon: Icon(Icons.miscellaneous_services),
            label: 'Layanan',
          ),
          const NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Lokasi',
          ),
          NavigationDestination(
            icon: _ikonWarga(),
            selectedIcon: _ikonWargaTerpilih(),
            label: 'Warga',
          ),
        ],
      ),
    );
  }
}
