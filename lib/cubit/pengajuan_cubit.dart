
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(<String>[]);

  // Menambahkan layanan ke daftar pengajuan.
  // Layanan yang sama tidak ditambahkan dua kali.
  void tambahPengajuan(String namaLayanan) {
    if (state.contains(namaLayanan)) return;

    emit([...state, namaLayanan]);
  }

  // Menghapus layanan dari daftar pengajuan.
  void hapusPengajuan(String namaLayanan) {
    final pengajuanBaru = List<String>.from(state);
    pengajuanBaru.remove(namaLayanan);

    emit(pengajuanBaru);
  }

  // Menghapus seluruh daftar pengajuan.
  void kosongkan() {
    emit(<String>[]);
  }

  // Jumlah seluruh layanan yang diajukan.
  int get totalPengajuan => state.length;

  // Memeriksa apakah layanan sudah diajukan.
  bool sudahDiajukan(String namaLayanan) {
    return state.contains(namaLayanan);
  }
}
