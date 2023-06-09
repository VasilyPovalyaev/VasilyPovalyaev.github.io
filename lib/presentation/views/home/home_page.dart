import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yelwinoo/presentation/configs/configs.dart';
import 'package:yelwinoo/presentation/views/wrapper.dart';
import 'package:yelwinoo/presentation/widgets/widgets.dart';

import 'introduction_page.dart';
import 'showcase_projects_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  // this is like a lock that prevent update the PageView multiple times while is
  // scrolling
  bool pageIsScrolling = false;

  List<Widget> mainPages = [];
  final _key = GlobalKey();
  bool _isDrawerOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainPages = [
      IntroductionPage(
        onTapSeeMyWorks: _onTapSeeMyWorks,
      ),
      const ShowcaseProjectsPage(),
      const FooterPage(),
    ];
  }

  void onMenuTapped() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _onScroll(double offset) {
    if (pageIsScrolling == false) {
      pageIsScrolling = true;
      if (offset > 0) {
        pageController
            .nextPage(
              duration: duration300,
              curve: Curves.easeInOut,
            )
            .then((value) => pageIsScrolling = false);
      } else {
        pageController
            .previousPage(
              duration: duration300,
              curve: Curves.easeInOut,
            )
            .then((value) => pageIsScrolling = false);
      }
    }
  }

  void _onTapSeeMyWorks() {
    pageController
        .animateToPage(
          1,
          duration: duration300,
          curve: Curves.easeInOut,
        )
        .then((value) => pageIsScrolling = false);
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      page: GestureDetector(
        onPanUpdate: (details) {
          _onScroll(details.delta.dy * -1);
        },
        child: Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              _onScroll(pointerSignal.scrollDelta.dy);
            }
          },
          child: PageView(
            key: _key,
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: mainPages,
          ),
        ),
      ),
    );
  }
}
