import 'dart:async';

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  void call(Function action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () => action());
  }
}
