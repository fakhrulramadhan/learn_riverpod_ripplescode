import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//consumerwidget (utk ui riverpod) sama aja dengan statelesswidget
class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final nama = ref.watch(namaProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Auto Dispose Modifier Provider",
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
      ),
      //ref.watch = utk memantau perubahan yang ngelink ke nama providernya
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //atau pakai nav.push
            context.push("/counter"); //cara dengan go router
          },
          child: Text(
            "To Counter Page",
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
        ),
      ),
    );
  }
}
