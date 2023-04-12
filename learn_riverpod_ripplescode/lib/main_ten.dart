import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// === Reading the created Provider with ConsumerWidget ====

//provider = untuk menaruh sesuatu
//ketik prov teruus enter
final namaProvider = Provider<String>((ref) {
  //parameter nya dari ref
  return "Halo, Saepul";
});

final streamProvider = StreamProvider<int>((ref) {
  //angka state akan bertambah 1 setiap 2 detik
  return Stream.periodic(
    const Duration(seconds: 2),
    (computationCount) => computationCount,
  );
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
      title: "Read Created Provider",
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
    final streamData = ref.watch(streamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stream Provider Counter",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      //ref.watch = utk memantau perubahan yang ngelink ke nama providernya

      //kalauu ketergantungan sama data, nama variabel datanya dipanggil duluan
      body: streamData.when(
        data: (data) {
          return Center(
            child: Text(
              "${data.toString()}",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Text(
            "${error.toString()}",
            style: TextStyle(
              fontSize: 16.0,
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
