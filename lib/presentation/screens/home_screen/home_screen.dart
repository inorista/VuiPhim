import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/home/popular_movie/popular_movie_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/top_rated_movie/top_rated_movie_cubit.dart';
import 'package:vuiphim/presentation/blocs/home/upcoming_movie/upcoming_movie_cubit.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/backdrop_widget.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/popular_movie_widget.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/top_rated_movie_widget.dart';
import 'package:vuiphim/presentation/screens/home_screen/widgets/up_coming_movie_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMovieCubit()..fetchPopularMovies(),
        ),
        BlocProvider(
          create: (context) => TopRatedMovieCubit()..fetchTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) => UpcomingMovieCubit()..fetchUpcomingMovies(),
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
