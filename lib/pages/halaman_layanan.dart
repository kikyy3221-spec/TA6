
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import 'halaman_detail_layanan.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() => _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  final Set<String> _layananTerpilih = {};

  final List<Map<String, dynamic>> daftarLayanan = const [
    {
      'nama': 'Surat Pengantar',
      'deskripsi': 'Pengajuan surat pengantar untuk masyarakat.',
      'ikon': Icons.description,
    },
    {
      'nama': 'Surat Domisili',
      'deskripsi': 'Pengajuan surat keterangan domisili.',
      'ikon': Icons.home_work,
    },
    {
      'nama': 'Layanan Kependudukan',
      'deskripsi': 'Layanan administrasi kependudukan.',
      'ikon': Icons.people,
    },
    {
      'nama': 'Surat Keterangan Usaha',
      'deskripsi': 'Pengajuan surat keterangan usaha.',
      'ikon': Icons.store,
    },
    {
      'nama': 'Surat Keterangan Tidak Mampu',
      'deskripsi': 'Pengajuan surat keterangan tidak mampu.',
      'ikon': Icons.volunteer_activism,
    },
  ];

  void _ubahPilihan(String namaLayanan) {
    setState(() {
      if (_layananTerpilih.contains(namaLayanan)) {
        _layananTerpilih.remove(namaLayanan);
      } else {
        _layananTerpilih.add(namaLayanan);
      }
    });
  }

  Future<void> _bukaDetailPengajuan() async {
    if (_layananTerpilih.isEmpty) return;

    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanDetailLayanan(
          daftarNamaLayanan: _layananTerpilih.toList(),
        ),
      ),
    );

    if (!mounted) return;

    if (hasil == true) {
      setState(() {
        _layananTerpilih.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengajuan berhasil dikirim!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final daftarPengajuan =
        context.watch<PengajuanCubit>().state;

    return BlocBuilder<FavoritCubit, Set<String>>(
      builder: (context, daftarFavorit) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Daftar Layanan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih satu atau beberapa layanan yang ingin diajukan. '
              'Kamu juga dapat menandai layanan sebagai favorit.',
            ),
            const SizedBox(height: 16),

            ...daftarLayanan.map((layanan) {
              final String namaLayanan = layanan['nama'];
              final String deskripsi = layanan['deskripsi'];
              final IconData ikon = layanan['ikon'];

              final bool isFavorit =
                  daftarFavorit.contains(namaLayanan);

              final bool sudahDiajukan =
                  daftarPengajuan.contains(namaLayanan);

              final bool isTerpilih =
                  _layananTerpilih.contains(namaLayanan);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(ikon),
                      ),
                      title: Text(namaLayanan),
                      subtitle: Text(
                        sudahDiajukan
                            ? 'Layanan sudah diajukan'
                            : deskripsi,
                      ),
                      trailing: IconButton(
                        tooltip: isFavorit
                            ? 'Hapus dari favorit'
                            : 'Tambahkan ke favorit',
                        icon: Icon(
                          isFavorit
                              ? Icons.star
                              : Icons.star_border,
                          color: isFavorit
                              ? Colors.amber
                              : null,
                        ),
                        onPressed: () {
                          context
                              .read<FavoritCubit>()
                              .toggleFavorit(namaLayanan);
                        },
                      ),
                    ),

                    CheckboxListTile(
                      value: isTerpilih,
                      title: const Text('Pilih untuk diajukan'),
                      controlAffinity:
                          ListTileControlAffinity.leading,
                      onChanged: sudahDiajukan
                          ? null
                          : (_) {
                              _ubahPilihan(namaLayanan);
                            },
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _layananTerpilih.isEmpty
                    ? null
                    : _bukaDetailPengajuan,
                icon: const Icon(Icons.send),
                label: Text(
                  'Ajukan ${_layananTerpilih.length} Layanan',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
