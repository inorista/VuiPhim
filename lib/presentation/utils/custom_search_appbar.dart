import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? hintText;
  final TextEditingController controller;
  final double? textFieldHeight;
  final double? appbarHeight;

  const CustomSearchAppbar({
    required this.onChanged,
    required this.onFieldSubmitted,
    required this.controller,
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
            child: TextFormField(
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              style: const TextStyle(
                color: Color(0xff7f7f7f),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: hintText ?? 'Tìm kiếm...',
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
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
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
  Size get preferredSize => Size.fromHeight(appbarHeight ?? 65);
}
