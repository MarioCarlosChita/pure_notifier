import 'package:pure_notifier/pure_failure.dart';
import 'package:pure_notifier/pure_notifier.dart';

class Counter extends PureNotifier<int> {
  Counter() : super(0);

  void increment() {
    notify(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (state.value >= 3) throw const PureFailure('The counter has reached the maximum.');
      return state.value + 1;
    });
  }
}
