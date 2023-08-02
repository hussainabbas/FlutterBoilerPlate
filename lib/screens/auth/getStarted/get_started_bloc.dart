import 'dart:async';

class GetStartedBloc {
  final StreamController<int> _pageController = StreamController<int>.broadcast();

  Stream<int> get currentPageStream => _pageController.stream;

  void updatePage(int page) {
    _pageController.sink.add(page);
  }

  void dispose() {
    _pageController.close();
  }
}