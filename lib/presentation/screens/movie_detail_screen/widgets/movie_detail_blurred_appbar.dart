import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/native/instagram_sharing_native.dart';
import 'package:vuiphim/presentation/blocs/movie_infomation/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/presentation/blocs/movie_infomation/movie_source/movie_source_cubit.dart';
import 'package:vuiphim/presentation/blocs/select_movie_episode/select_movie_episode_cubit.dart';
import 'package:vuiphim/presentation/screens/download_manager_screen/widgets/episode_list.dart';
import 'package:vuiphim/presentation/screens/sticker_screen/widgets/blurry_background.dart';
import 'package:vuiphim/presentation/screens/sticker_screen/widgets/sticker_detail.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';
import 'package:vuiphim/presentation/utils/dialog_utils.dart';
import 'package:vuiphim/presentation/utils/option_item.dart';

class MovieDetailBlurredAppBar extends StatelessWidget {
  const MovieDetailBlurredAppBar({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state.status == MovieDetailStatus.success) {
          return CustomAnimationAppbar(
            title: state.movieDetail?.title,
            actions: [
              InkWell(
                onTap: () async {
                  await DialogUtils.showBottomSheetWithCustomChildren(
                    context,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        spacing: 14,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.movieDetail?.title ?? '',
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          OptionItem(
                            imgPath: 'assets/icons/instagram_icon.svg',
                            title: "Chia sẻ lên Instagram",
                            onTap: () async {
                              context.pop();
                              InstagramSharingNative().captureAndShareWidget(
                                context,
                                BlurryBackground(
                                  movieDetail: state.movieDetail!,
                                ),
                                StickerDetail(movieDetail: state.movieDetail!),
                              );
                            },
                          ),

                          if (context.read<MovieSourceCubit>().state.status ==
                                  MovieSourceStatus.success &&
                              context
                                  .read<MovieSourceCubit>()
                                  .state
                                  .sources
                                  .isNotEmpty)
                            OptionItem(
                              imgPath: 'assets/icons/download_icon.svg',
                              title: 'Tải xuống',
                              onTap: () async {
                                context.pop();
                                await DialogUtils.showBluredDialogWithCustomChildren(
                                  context,
                                  child: BlocProvider<SelectMovieEpisodeCubit>(
                                    create: (context) =>
                                        SelectMovieEpisodeCubit()
                                          ..initializeEpisodes(
                                            state.movieDetail!.id,
                                          ),
                                    child: const EpisodeList(),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.share_up,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            scrollController: _scrollController,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
