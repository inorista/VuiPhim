import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const CustomScrollView(slivers: [

            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAnimationAppbar(
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  "Khám phá",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              scrollController: _scrollController,
              appBarHeight: Platform.isIOS ? 110 : 80,
            ),
          ),
        ],
      ),
    );
  }
}
