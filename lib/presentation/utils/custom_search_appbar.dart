import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/presentation/utils/debounced_search_field.dart';

class CustomSearchAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? hintText;
  final double? textFieldHeight;
  final double? appbarHeight;
  final TextEditingController controller;

  const CustomSearchAppbar({
    required this.onChanged,
    required this.controller,
    required this.onFieldSubmitted,
    this.hintText,
    this.textFieldHeight = 45,
    this.appbarHeight = 65,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: SizedBox(
            height: textFieldHeight,
            child: DebouncedSearchField(
              controller: controller,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              hintText: hintText,
            ),
          ),
          leadingWidth: 35,
          leading: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 30,
              ),

              onPressed: () {
                context.pop();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight ?? 65);
}
