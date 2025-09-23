import 'package:flutter/material.dart';
import 'package:vuiphim/presentation/utils/custom_search_appbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomSearchAppbar(),
    );
  }
}
