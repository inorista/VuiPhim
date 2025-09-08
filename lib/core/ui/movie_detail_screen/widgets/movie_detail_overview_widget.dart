import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/blocs/movie_detail/movie_detail_cubit.dart';

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
                const Text(
                  "Nội dung phim",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
