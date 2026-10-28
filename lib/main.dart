
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(
          create: (_) => FavoritCubit(),
        ),
        BlocProvider<PengajuanCubit>(
          create: (_) => PengajuanCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: const AplikasiNusantaraCerdas(),
    ),
  );
}

class AplikasiNusantaraCerdas extends StatelessWidget {
  const AplikasiNusantaraCerdas({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nusantara Cerdas Mobile',

          // Tema terang dengan warna biru
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),

          // Tema gelap dengan warna biru
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),

          // Tema yang sedang digunakan
          themeMode: mode,

          // Halaman utama aplikasi
          home: const KerangkaNavigasi(),
        );
      },
    );
  }
}
