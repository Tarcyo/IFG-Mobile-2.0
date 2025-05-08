import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/core/utils/scroll_hint_banner.dart';
import 'lesson_card.dart';


class DayTabContent extends StatefulWidget {
  final List<Map<String, String>> lessons;
  final bool bannerDismissed;
  final VoidCallback onBannerDismissed;

  const DayTabContent({
    Key? key,
    required this.lessons,
    required this.bannerDismissed,
    required this.onBannerDismissed,
  }) : super(key: key);

  @override
  _DayTabContentState createState() => _DayTabContentState();
}

class _DayTabContentState extends State<DayTabContent> {
  final ScrollController _dayScrollController = ScrollController();
  bool _showScrollHint = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_dayScrollController.hasClients &&
          _dayScrollController.position.maxScrollExtent > 0) {
        setState(() {
          _showScrollHint = true;
        });
      }
    });
    _dayScrollController.addListener(() {
      if (_dayScrollController.hasClients) {
        final isAtBottom = _dayScrollController.offset >=
                _dayScrollController.position.maxScrollExtent ||
            _dayScrollController.position.maxScrollExtent == 0;
        setState(() {
          _showScrollHint = !isAtBottom;
        });
      }
    });
  }

  @override
  void dispose() {
    _dayScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: _dayScrollController,
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          itemCount: widget.lessons.length,
          itemBuilder: (context, index) {
            return LessonCard(lesson: widget.lessons[index]);
          },
        ),
        if (_showScrollHint && !widget.bannerDismissed)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: ScrollHintBanner(
                onDismissed: widget.onBannerDismissed,
              ),
            ),
          ),
      ],
    );
  }
}
