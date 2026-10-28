
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Identitas pengguna
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'M HABIB RIZKY',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pengguna Nusantara Cerdas Mobile',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Judul halaman
        const Text(
          'Halaman Warga',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        // Total pengajuan
        Card(
          child: BlocBuilder<PengajuanCubit, List<String>>(
            builder: (context, pengajuan) {
              final total = context
                  .read<PengajuanCubit>()
                  .totalPengajuan;

              return ListTile(
                leading: const Icon(
                  Icons.assignment,
                  size: 32,
                ),
                title: const Text('Total Pengajuan'),
                subtitle: Text('$total pengajuan'),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Pengaturan tema
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.brightness_6,
              color: Colors.blue,
            ),
            title: const Text('Pengaturan Tema'),
            subtitle: const Text(
              'Ubah tampilan terang atau gelap.',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'Ganti tema',
              onPressed: () {
                context.read<ThemeCubit>().toggle();
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Daftar layanan favorit
        const Text(
          'Layanan Favorit',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, daftarFavorit) {
            if (daftarFavorit.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Belum ada layanan favorit.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tandai layanan dengan ikon bintang '
                        'pada halaman Layanan.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: daftarFavorit.map((namaLayanan) {
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text(namaLayanan),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      onPressed: () {
                        context
                            .read<FavoritCubit>()
                            .batalTandai(namaLayanan);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
