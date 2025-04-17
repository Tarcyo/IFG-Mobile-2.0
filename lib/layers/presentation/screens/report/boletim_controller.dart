import 'package:flutter/material.dart';

class BoletimController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final Map<String, List<Map<String, String>>> reportData;
  String selectedYear;
  bool showScrollHint = false;
  bool bannerDismissed = false;

  BoletimController({
    required this.reportData,
  }) : selectedYear = reportData.keys.first {
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (!scrollController.hasClients) return;
      
      final newState = !_shouldHideArrow();
      if (newState != showScrollHint) {
        showScrollHint = newState;
        notifyListeners();
      }
    });
  }

  bool _shouldHideArrow() {
    return scrollController.offset >= scrollController.position.maxScrollExtent ||
        scrollController.position.maxScrollExtent == 0;
  }

  void selectYear(String year) {
    if (year != selectedYear) {
      selectedYear = year;
      notifyListeners();
    }
  }

  void dismissBanner() {
    bannerDismissed = true;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}