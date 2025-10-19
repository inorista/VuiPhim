import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vuiphim/core/constants/value_constants.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/igenre_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/genre_entity/genre_entity.dart';

class GenreList extends StatefulWidget {
  const GenreList({super.key});

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  final _genreService = locator<IGenreService>();
  List<GenreEntity> _genres = [];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final allGenres = await _genreService.getAllGenres();
      setState(() {
        _genres = allGenres;
      });
      _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
          SliverList.separated(
            itemCount: _genres.length,
            separatorBuilder: (context, index) => const SizedBox(height: 30),
            itemBuilder: (context, index) {
              final genre = _genres[index];
              final double delay =
                  (index / (_genres.length - 1)) * staggerFraction;
              final double end = min(1.0, delay + animationFraction);
              final animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(delay, end, curve: Curves.easeOut),
                ),
              );

              return GestureDetector(
                onTap: () {},
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 100 * (1 - animation.value)),
                      child: Opacity(opacity: animation.value, child: child),
                    );
                  },
                  child: Text(
                    genre.name,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
