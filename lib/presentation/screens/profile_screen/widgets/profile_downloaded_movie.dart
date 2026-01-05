import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDownloadedMovie extends StatefulWidget {
  const ProfileDownloadedMovie({super.key});

  @override
  State<ProfileDownloadedMovie> createState() => _ProfileDownloadedMovieState();
}

class _ProfileDownloadedMovieState extends State<ProfileDownloadedMovie> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: const Color(0xff161616),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(width: 1, color: const Color(0xff2b2b2b)),
        ),
        child: Column(
          spacing: 20,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const Spacer(flex: 1),
                const Text(
                  "Phim đã tải xuống",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(flex: 6),
                const Icon(
                  CupertinoIcons.forward,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return null;
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemCount: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
