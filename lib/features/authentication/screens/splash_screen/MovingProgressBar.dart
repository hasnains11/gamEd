// import 'package:flutter/material.dart';
//
// class MovingProgressBar extends StatefulWidget {
//   final double targetValue;
//   final double height;
//   final double borderRadius;
//   final Color color;
//   final Color backgroundColor;
//   final int durationMs;
//
//   MovingProgressBar({
//     required this.targetValue,
//     this.height = 10.0,
//     this.borderRadius = 20.0,
//     this.color = Colors.blue,
//     this.backgroundColor = Colors.grey,
//     this.durationMs = 1000,
//   });
//
//   @override
//   _MovingProgressBarState createState() => _MovingProgressBarState();
// }
//
// class _MovingProgressBarState extends State<MovingProgressBar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   double _currentValue = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         vsync: this, duration: Duration(milliseconds: widget.durationMs));
//     _animation = Tween(begin: _currentValue, end: widget.targetValue)
//         .animate(_controller)
//       ..addListener(() {
//         setState(() {
//           _currentValue = _animation.value;
//         });
//       });
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
//     return AnimatedContainer(
//       duration: Duration(milliseconds: widget.durationMs),
//       height: widget.height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(widget.borderRadius),
//         color: widget.backgroundColor,
//       ),
//       child: FractionallySizedBox(
//         widthFactor: _currentValue,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.borderRadius),
//             color: widget.color,
//           ),
//         ),
//       ),
//     );
//   }
// }
