import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: TextFormField(
            style: const TextStyle(
              color: Color(0xff7f7f7f),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Tìm kiếm phim, TV show...',
              hintStyle: const TextStyle(
                color: Color(0xff7f7f7f),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),

              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Color(0xff7f7f7f),
                size: 28,
              ),
              filled: true,
              fillColor: const Color(0xff323232),
              contentPadding: const EdgeInsets.all(2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
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
  Size get preferredSize => const Size.fromHeight(65);
}
