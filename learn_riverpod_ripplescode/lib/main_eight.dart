import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod_ripplescode/counter_demo.dart';

// === Reading the created Provider with ConsumerWidget ====

//state notifier provider = suatu fungsi (notifier) yang digunakan utk merubah nilai ()

//stateprrovider<nama_file_notifier, tipe data>
final counterProvider = StateNotifierProvider<CounterDemo, int>((ref) {
  return CounterDemo();
});

void main() {
  //di riverpod, halaman UInya harus dibungkus dengan providerscope
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "State Provider",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

//consumerwidget (utk ui riverpod) sama aja dengan statelesswidget
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final nama = ref.watch(namaProvider);
    //final count = ref.watch(counterProvider);
    final counter = ref.watch(counterProvider);

    //utk merubah nilai (sebelum, setelah) pada provider
    //dan akan memberikan efek tertentu ketika logic nya terpenuhi
    //seperti bloclistener
    ref.listen(counterProvider, (previous, next) {
      if (next == 10) {
        //snackbarnya dibawah
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Terpenuhi"),
        ));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "State Provider",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        actions: [
          IconButton(
            //utk mereset nilai dari sebuah proovider
            //nilainya kembali ke 0
            onPressed: () {
              //cara 1
              //ref.invalidate(counterProvider);
              //cara 2
              ref.refresh(counterProvider);
            },
            icon: const Icon(
              Icons.refresh,
              size: 24.0,
            ),
          ),
        ],
      ),
      //ref.watch = utk memantau perubahan yang ngelink ke nama providernya
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          //final nama = ref.watch(namaProvider);

          //return nama.toString();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                counter.toString(),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(counterProvider.notifier).decrement();
                },
                icon: const Icon(
                  Icons.access_time,
                  size: 24.0,
                ),
                label: Text(
                  "Kurang",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //notifier utk ngasih tahu
          //cara panggil fungsi
          //ref.read(namaProvider.notifier).nama_fungsi
          //cara 1:
          ref.read(counterProvider.notifier).increment();
          //cara 2 (nilainya diupdate)
          //ref.read(counterProvider.notifier).update((state) => state + 1);
        },
      ),
    );
  }
}
