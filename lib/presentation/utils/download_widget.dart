import 'dart:async';

import 'package:flutter/material.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({super.key});

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  final StreamController<double> _progressStream =
      StreamController<double>.broadcast();
  double _downloadPercent = 0.0;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _progressStream.stream.listen(
      (percentage) {
        setState(() {
          _downloadPercent = percentage;
          if (percentage == 100.0) {
            _isDownloading = false;
          }
        });
      },
      onError: (error) {
        setState(() {
          _isDownloading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _progressStream.close();
    super.dispose();
  }

  void _startDownload() {
    setState(() {
      _isDownloading = true;
      _downloadPercent = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
