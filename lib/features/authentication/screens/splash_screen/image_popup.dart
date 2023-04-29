// import 'package:flutter/material.dart';
//
// class ImagePopup extends StatefulWidget {
//   final String imagePath;
//   final double height;
//   final double width;
//
//   ImagePopup({
//     required this.imagePath,
//     this.height = 200.0,
//     this.width = 200.0,
//   });
//
//   @override
//   _ImagePopupState createState() => _ImagePopupState();
// }
//
// class _ImagePopupState extends State<ImagePopup>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     print('initState');
//     _controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 900));
//     _animation = _animation =
//         Tween<Offset>(begin: Offset(1.0, 1.0), end: Offset(0.0, 1.0))
//             .animate(CurvedAnimation(
//       reverseCurve: Curves.easeInOut,
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedPositioned(
//         duration: Duration(milliseconds: 2000),
//         right: -10,
//         bottom: 0,
//         child: Container(
//           height: widget.height,
//           width: widget.width,
//           child: Image.asset(
//             widget.imagePath,
//             fit: BoxFit.cover,
//           ),
//         ));
//
//     //   SlideTransition(
//     //   textDirection: TextDirection.rtl,
//     //   position: _animation,
//     //   child: Container(
//     //     height: widget.height,
//     //     width: widget.width,
//     //     child: Image.asset(
//     //       widget.imagePath,
//     //       fit: BoxFit.cover,
//     //     ),
//     //   ),
//     // );
//   }
// }
