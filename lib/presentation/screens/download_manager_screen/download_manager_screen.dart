import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/presentation/blocs/download_manager/download_manager_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';

class DownloadManagerScreen extends StatefulWidget {
  const DownloadManagerScreen({super.key});

  @override
  State<DownloadManagerScreen> createState() => _DownloadManagerScreenState();
}

class _DownloadManagerScreenState extends State<DownloadManagerScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadManagerCubit>(
      create: (_) => DownloadManagerCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: const [SliverToBoxAdapter(child: SizedBox(height: 200))],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CustomAnimationAppbar(
                leading: Row(
                  spacing: 20,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Text(
                      "Quản lý tải xuống",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                scrollController: _scrollController,
                appBarHeight: Platform.isIOS ? 110 : 90,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
