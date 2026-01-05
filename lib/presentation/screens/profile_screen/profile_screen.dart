import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
import 'package:vuiphim/core/router/app_router.dart';
import 'package:vuiphim/presentation/blocs/downloaded_manager/downloaded_manager_cubit.dart';
import 'package:vuiphim/presentation/blocs/profile/continue_watching/continue_watching_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 70)),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff161616),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xff2b2b2b),
                        ),
                      ),
                      child: Column(
                        spacing: 20,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 14,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/download_icon.svg',
                                height: 30,
                                width: 30,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const Text(
                                "Phim đã tải xuống",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              // const Spacer(flex: 6),
                              // const Icon(
                              //   CupertinoIcons.forward,
                              //   color: Colors.white,
                              //   size: 28,
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 270,
                            child:
                                BlocBuilder<
                                  DownloadedManagerCubit,
                                  DownloadedManagerState
                                >(
                                  builder: (context, state) {
                                    if (state.downloadedMovieMaps.isEmpty) {
                                      return const Center(
                                        child: Text(
                                          "Chưa có phim nào được tải xuống",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final movieEntity = state
                                              .downloadedMovieMaps
                                              .keys
                                              .elementAt(index);
                                          return InkWell(
                                            onTap: () {
                                              VibrationNative.vibrateWithIntensity(
                                                1,
                                              );
                                              context.push(
                                                '/movie_detail/${movieEntity.id}',
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: movieEntity.posterUrl,
                                                fit: BoxFit.cover,
                                                fadeInDuration: const Duration(
                                                  milliseconds: 10,
                                                ),
                                                fadeOutDuration: const Duration(
                                                  milliseconds: 10,
                                                ),
                                                width: 180,
                                                height: 250,
                                                placeholder: (context, url) =>
                                                    const Shimmer(
                                                      width: 180,
                                                      height: 250,
                                                      borderRadius: 14,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(width: 15);
                                        },
                                        itemCount:
                                            state.downloadedMovieMaps.length,
                                      );
                                    }
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<ContinueWatchingCubit, ContinueWatchingState>(
                    builder: (context, state) {
                      if (state.status == ContinueWatchingStatus.error ||
                          (state.status == ContinueWatchingStatus.loaded &&
                              state.continueWatchingList.isEmpty)) {
                        return const SliverToBoxAdapter(child: SizedBox());
                      } else if (state.status ==
                          ContinueWatchingStatus.loading) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      } else if (state.continueWatchingList.isNotEmpty) {
                        return SliverPadding(
                          padding: const EdgeInsets.only(top: 20.0),
                          sliver: SliverToBoxAdapter(
                            child: SizedBox(
                              height: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 12,
                                children: [
                                  const Text(
                                    "Tiếp tục xem",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.continueWatchingList.length,
                                      physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(),
                                      ),
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(width: 14);
                                      },
                                      itemBuilder: (context, index) {
                                        final item =
                                            state.continueWatchingList[index];
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: SizedBox(
                                            height: 250,
                                            width: 180,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned.fill(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        item.movie.posterUrl,
                                                    fit: BoxFit.cover,
                                                    fadeInDuration:
                                                        const Duration(
                                                          milliseconds: 10,
                                                        ),
                                                    fadeOutDuration:
                                                        const Duration(
                                                          milliseconds: 10,
                                                        ),
                                                    width: 180,
                                                    height: 250,
                                                    placeholder:
                                                        (context, url) =>
                                                            const Shimmer(
                                                              width: 180,
                                                              height: 250,
                                                              borderRadius: 14,
                                                            ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  child: Container(
                                                    height: 3,
                                                    width: 180,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  child: Container(
                                                    height: 3,
                                                    width: item.serverData
                                                        .progress(180),
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.red,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SliverToBoxAdapter(child: SizedBox());
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAnimationAppbar(
              leading: const Text(
                "VuiPhim",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: () {
                      context.push(AppRouter.search);
                    },
                    child: const Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
              scrollController: _scrollController,
              appBarHeight: Platform.isIOS ? 110 : 90,
            ),
          ),
        ],
      ),
    );
  }
}
