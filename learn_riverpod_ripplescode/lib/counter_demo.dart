import 'package:flutter_riverpod/flutter_riverpod.dart';

//state notifier provider = suatu fungsi (notifier) yang digunakan utk merubah nilai ()
class CounterDemo extends StateNotifier<int> {
  CounterDemo() : super(0); // kasih nilai awalan 0

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}
