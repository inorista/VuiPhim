import 'package:flutter/material.dart';

import 'package:vuiphim/presentation/screens/home_screen/widgets/backdrop_widget.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/popular_movie_widget.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/top_rated_movie_widget.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/up_coming_movie_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Stack(
          alignment: Alignment.topCenter,
          children: [
            BackdropWidget(),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: PopularMovieWidget()),
                SliverToBoxAdapter(child: SizedBox(height: 30)),
                SliverToBoxAdapter(child: TopRatedMovieWidget()),
                SliverToBoxAdapter(child: UpComingMovieWidget()),
                SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
