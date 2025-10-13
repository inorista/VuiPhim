import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DebouncedSearchField extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? hintText;
  final TextEditingController controller;
  const DebouncedSearchField({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    required this.controller,
  });

  @override
  State<DebouncedSearchField> createState() => _DebouncedSearchFieldState();
}

class _DebouncedSearchFieldState extends State<DebouncedSearchField> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      widget.onChanged?.call(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: _onSearchChanged,
      style: const TextStyle(
        color: Color(0xff7f7f7f),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Tìm kiếm...',
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
    );
  }
}
