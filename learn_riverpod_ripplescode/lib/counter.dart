import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_riverpod_ripplescode/counter_demo.dart';

//enggak pakai autodispose, datanya tetap ada
// final counterProvider = StateNotifierProvider<CounterDemo, int>((ref) {
//   return CounterDemo();
// });

//pakai autodispose agar data cachingnya kebuang datanya balik lg ke awal
//pasang autodispose
final counterProvider =
    StateNotifierProvider.autoDispose<CounterDemo, int>((ref) {
  //meskipun ke-autodispose, tapi datanya tetap ada
  //pakai ref.keepalive
  //ref.keepAlive();
  final link = ref.keepAlive();

  //tutup data cachingnya dalam waktu 10 detik
  //data angknya angka kembali lagi ke 0 setelah 10 dettik
  final timer = Timer(Duration(seconds: 10), () {
    link.close();
  });

  //dispose (hapus data) cachingnya setelah 10 detik
  ref.onDispose(() => timer.cancel());

  return CounterDemo();
});

//consumerwidget (utk ui riverpod) sama aja dengan statelesswidget
class Counter extends ConsumerWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final nama = ref.watch(namaProvider);
    //memantau data angka
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Counter Autodispose riverpod",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      //ref.watch = utk memantau perubahan yang ngelink ke nama providernya
      body: Center(
        child: Text(
          "${counter}",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //
          ref.read(counterProvider.notifier).increment();
        },
      ),
    );
  }
}
