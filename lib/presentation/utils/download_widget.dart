import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vuiphim/presentation/blocs/download_manager/download_manager_cubit.dart';
import 'package:vuiphim/presentation/blocs/download_manager/download_manager_state.dart';

class DownloadButtonWidget extends StatelessWidget {
  final int movieId;
  final String videoId;
  final String m3u8Url;

  const DownloadButtonWidget({
    super.key,
    required this.movieId,
    required this.videoId,
    required this.m3u8Url,
  });

  @override
  Widget build(BuildContext context) {
    // Dùng BlocSelector để chỉ build lại widget này
    // khi state của *chỉ videoId này* thay đổi
    return BlocSelector<
      DownloadManagerCubit,
      DownloadManagerState,
      DownloadItemState
    >(
      selector: (state) =>
          state.downloads[videoId] ??
          DownloadItemState(videoId: videoId, movieId: movieId),
      builder: (context, itemState) {
        switch (itemState.status) {
          case DownloadStatus.idle:
            return InkWell(
              onTap: () {
                context.read<DownloadManagerCubit>().startDownload(
                  videoId,
                  movieId,
                  m3u8Url,
                );
              },
              child: SvgPicture.asset(
                'assets/icons/download_cloud_icon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            );
          case DownloadStatus.downloading:
            return _buildProgressIndicator(itemState.progress);
          case DownloadStatus.success:
            return IconButton(
              icon: const Icon(Icons.check_circle, color: Colors.green),
              onPressed: () {},
            );
          case DownloadStatus.failure:
            return InkWell(
              onTap: () {
                context.read<DownloadManagerCubit>().startDownload(
                  videoId,
                  movieId,
                  m3u8Url,
                );
              },
              child: SvgPicture.asset(
                'assets/icons/download_cloud_fail_icon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFbe2b27),
                  BlendMode.srcIn,
                ),
              ),
            );
        }
      },
    );
  }

  Widget _buildProgressIndicator(double progress) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 3.0,
            backgroundColor: Colors.grey.shade300,
            color: const Color(0xFFbe2b27),
          ),
          Text(
            "${(progress * 100).toInt()}%",
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
