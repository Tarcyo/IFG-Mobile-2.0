import 'package:flutter/material.dart';

class AllCampiController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool showDownArrow = false;
  bool bannerDismissed = false;

  void initialize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInitialScrollPosition();
    });
    _setupScrollListener();
  }

  void _checkInitialScrollPosition() {
    if (scrollController.hasClients && 
        scrollController.position.maxScrollExtent > 0) {
      showDownArrow = true;
      notifyListeners();
    }
  }

  void _setupScrollListener() {
    scrollController.addListener(_handleScrollUpdate);
  }

  void _handleScrollUpdate() {
    if (!scrollController.hasClients) return;

    final newState = !_shouldHideArrow();
    if (newState != showDownArrow) {
      showDownArrow = newState;
      notifyListeners();
    }
  }

  bool _shouldHideArrow() {
    return scrollController.offset >= scrollController.position.maxScrollExtent ||
        scrollController.position.maxScrollExtent == 0;
  }

  void dismissBanner() {
    bannerDismissed = true;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.removeListener(_handleScrollUpdate);
    scrollController.dispose();
    super.dispose();
  }
}