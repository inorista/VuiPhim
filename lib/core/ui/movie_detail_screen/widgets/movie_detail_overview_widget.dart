import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/core/ui/utils/shimmer.dart';
import 'package:intl/intl.dart';

class MovieDetailOverviewWidget extends StatefulWidget {
  const MovieDetailOverviewWidget({super.key});

  @override
  State<MovieDetailOverviewWidget> createState() =>
      _MovieDetailOverviewWidgetState();
}

class _MovieDetailOverviewWidgetState extends State<MovieDetailOverviewWidget> {
  bool isExpanded = false;

  void changeExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(color: Colors.black),
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ngày phát hành',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${DateFormat('dd/MM/yyyy').format(DateTime.parse(state.movieDetail.releaseDate))}',
                            style: const TextStyle(
                              color: Color(0xff9198a1),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thể loại',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 10,
                            children: state.movieDetail.genres
                                .map(
                                  (genre) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: const Color(0xFFbe2b27),
                                      ),
                                    ),
                                    child: Text(
                                      genre.name.replaceAll('Phim', ""),
                                      style: const TextStyle(
                                        color: Color(0xFFbe2b27),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // const Divider(color: Color(0xffaaaaaa), thickness: 0.5),
                const SizedBox(height: 30),
                const Text(
                  "Nội dung phim",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: isExpanded
                            ? state.movieDetail.overview
                            : (state.movieDetail.overview.length > 150
                                  ? "${state.movieDetail.overview.substring(0, 150)}... "
                                  : "${state.movieDetail.overview} "),
                        style: const TextStyle(
                          height: 1.5,
                          color: Color(0xffebebeb),
                          fontSize: 16,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          onTap: changeExpanded,
                          child: Text(
                            isExpanded ? "Thu gọn" : "Xem thêm",
                            style: const TextStyle(
                              color: Color(0xFFbe2b27),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MovieDetailLoading) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(height: 20, width: 120),
                SizedBox(height: 15),
                Shimmer(height: 60, width: double.infinity),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
