
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final List<String> daftarNamaLayanan;

  const HalamanDetailLayanan({
    super.key,
    required this.daftarNamaLayanan,
  });

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState
    extends State<HalamanDetailLayanan> {
  bool _isLoading = false;

  Future<void> _kirimPengajuan() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulasi proses pengajuan.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    final pengajuanCubit =
        context.read<PengajuanCubit>();

    // Menambahkan semua layanan yang dipilih.
    for (final namaLayanan in widget.daftarNamaLayanan) {
      pengajuanCubit.tambahPengajuan(namaLayanan);
    }

    // Mengembalikan hasil pengajuan ke halaman sebelumnya.
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengajuan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.description,
              size: 60,
            ),
            const SizedBox(height: 20),

            const Text(
              'Layanan yang Dipilih',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Periksa kembali daftar layanan sebelum '
              'mengirimkan pengajuan.',
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: widget.daftarNamaLayanan.length,
                itemBuilder: (context, index) {
                  final namaLayanan =
                      widget.daftarNamaLayanan[index];

                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_circle_outline,
                      ),
                      title: Text(namaLayanan),
                      subtitle: const Text(
                        'Siap diajukan',
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading
                    ? null
                    : _kirimPengajuan,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _isLoading
                      ? 'Mengirim Pengajuan...'
                      : 'Kirim Semua Pengajuan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
