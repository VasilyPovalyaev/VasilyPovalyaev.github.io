import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:yelwinoo/presentation/configs/configs.dart';
import 'package:yelwinoo/presentation/views/wrapper.dart';

import 'subviews/project_list_page.dart';
import 'subviews/project_title_page.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      page: ListView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: const [
          ProjectTitlePage(),
          ProjectListPage(),
        ],
      ),
    );
  }
}
