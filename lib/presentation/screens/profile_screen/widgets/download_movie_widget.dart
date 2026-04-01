import 'package:flutter/material.dart';

class DownloadMovieWidget extends StatefulWidget {
  final String movieId;
  const DownloadMovieWidget({super.key, required this.movieId});

  @override
  State<DownloadMovieWidget> createState() => _DownloadMovieWidgetState();
}

class _DownloadMovieWidgetState extends State<DownloadMovieWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xff161616),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 1, color: const Color(0xff2b2b2b)),
      ),
    );
  }
}
