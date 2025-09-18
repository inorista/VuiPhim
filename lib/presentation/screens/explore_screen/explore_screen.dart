import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';
import 'package:vuiphim/presentation/utils/custom_form_field.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(height: 1005, color: Colors.black),
                ),
              ],
            ),
          ),
          CustomAnimationAppbar(
            leading: const Text(
              "Khám phá",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Icon(
                CupertinoIcons.arrow_down_to_line,
                color: Colors.white,
                size: 26,
              ),
            ],
            scrollController: scrollController,
            appBarHeight: 110,
          ),
        ], // <-- Add this closing bracket for the Stack's children
      ),
    );
  }
}
