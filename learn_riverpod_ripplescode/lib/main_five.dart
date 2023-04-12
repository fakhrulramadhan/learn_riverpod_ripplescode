import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reading Created Provider with consumer",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      //ref.watch = utk memantau perubahan yang ngelink ke nama providernya
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          final nama = ref.watch(namaProvider);

          //return nama.toString();
          return Text(
            "${nama}",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      )),
    );
  }
}
