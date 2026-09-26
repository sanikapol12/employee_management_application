import 'dart:io';
import 'package:flutter/material.dart';

/// Reusable avatar widget that handles network URLs, local files from image_picker, and fallbacks
class AvatarImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final double iconSize;
  final Color fallbackColor;
  final Color iconColor;

  const AvatarImage({
    super.key,
    required this.imageUrl,
    this.size = 100,
    this.iconSize = 54,
    this.fallbackColor = const Color(0xFF1E40AF),
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return Center(
        child: Icon(Icons.person_rounded, size: iconSize, color: iconColor),
      );
    }

    final url = imageUrl!.trim();

    // 1. Network image
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return ClipOval(
        child: Image.network(
          url,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, stack) => Center(
            child: Icon(Icons.person_rounded, size: iconSize, color: iconColor),
          ),
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      );
    }

    // 2. Local file from ImagePicker
    try {
      final file = File(url);
      if (file.existsSync()) {
        return ClipOval(
          child: Image.file(
            file,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, stack) => Center(
              child: Icon(Icons.person_rounded, size: iconSize, color: iconColor),
            ),
          ),
        );
      }
    } catch (_) {}

    // 3. Fallback default
    return Center(
      child: Icon(Icons.person_rounded, size: iconSize, color: iconColor),
    );
  }
}
