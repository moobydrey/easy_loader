library easy_loader;

import 'package:flutter/material.dart';

class EasyLoader extends StatefulWidget {
  const EasyLoader(
      {Key? key,
      this.backgroundColor,
      this.animation,
      required this.image,
      this.iconSize = 120.0,
      this.iconColor = Colors.black})
      : super(key: key);

  //// The background color of the loader. It is automatically transparent.
  final Color? backgroundColor;
  //// Changes the default animation
  final Animation<Offset>? animation;
  //// Sets the image for the icon
  final String image;
  //// Changes the size of the default icon image
  final double iconSize;
  //// Changes the color of the icon
  final Color iconColor;

  @override
  _EasyLoaderState createState() => _EasyLoaderState();
}

class _EasyLoaderState extends State<EasyLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Color _backgroundColor = Colors.black;
  late String _image;
  late double _iconSize;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = widget.animation ??
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.0, -0.3),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ));
    _backgroundColor = widget.backgroundColor ?? Colors.black;
    _image = widget.image;
    _iconSize = widget.iconSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: _backgroundColor.withAlpha(100),
        ),
        Center(
            child: SlideTransition(
          position: _offsetAnimation,
          child: Image.asset(_image, height: _iconSize, fit: BoxFit.contain,)
        ))
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
