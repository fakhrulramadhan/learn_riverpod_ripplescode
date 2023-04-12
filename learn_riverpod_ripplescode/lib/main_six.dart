import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// === Reading the created Provider with ConsumerWidget ====

//provider = untuk menaruh sesuatu
//ketik prov teruus enter
final namaProvider = Provider<String>((ref) {
  //parameter nya dari ref
  return "Halo, Saepul";
});

//runningnya langsung klik run aja disini
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

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

//consumer statefulwidget sama aja dengan statefulwidgeet
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  //jika ingin langsung pertama kali baca (read) memantau providernya
  //pakai initstate
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final nama = ref.read(namaProvider); //read utk suatu aksi yang dilakukan
    print(nama);
  }

  @override
  Widget build(BuildContext context) {
    final nama = ref.watch(namaProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reading Provider for (Consumer) Statefulwidget",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${nama}",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
