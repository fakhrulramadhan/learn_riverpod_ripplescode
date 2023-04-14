import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_riverpod_ripplescode/counter.dart';

import 'home.dart';

// === Reading the created Provider with ConsumerWidget ====

//provider = untuk menaruh sesuatu
//ketik prov teruus enter
final namaProvider = Provider<String>((ref) {
  //parameter nya dari ref
  return "Halo, Saepul";
});

void main() {
  //di riverpod, halaman UInya harus dibungkus dengan providerscope
  runApp(const ProviderScope(child: const MyApp()));
}

//atur route nya disini
final GoRouter _router = GoRouter(routes: [
  GoRoute(
    path: "/", //inisiasi halaman awal
    builder: (context, state) => const Home(),
  ),
  GoRoute(
    path: "/counter",
    builder: (context, state) => const Counter(),
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Read Created Provider",
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}
