import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './models/user_model.dart';
import './services/api_service.dart';

//apiProvider
final apiProvider = Provider<ApiService>((ref) => ApiService());

//userdataProvider pakai Future Provider
//tipe datanya list (banyak data)
final userDataProvider = FutureProvider<List<UserModel>>((ref) async {
  //panggil nama fungsinya pakai ref.read
  return ref.read(apiProvider).getUser();
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
    //memantau data dari useerdata
    //datanya juga dari reqres.ins
    final userData = ref.watch(userDataProvider);

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
            },
            icon: const Icon(
              Icons.refresh,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: userData.when(
        //kalau datanya ada, tampilkan listview.builder,
        //userdatanya sudah di convert menjadi variabel data
        data: (data) {
          return ListView.builder(
            itemCount: data.length, //supaya tidak ada error rang error
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Image.network(
                    "${data[index].avatar}",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  "${data[index].firstName} ${data[index].lastName}",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                subtitle: Text(
                  "${data[index].email}",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Text(
            error.toString(),
            style: TextStyle(
              fontSize: 15.0,
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
