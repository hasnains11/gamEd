import 'package:flutter/material.dart';

class DashboardGrid extends StatelessWidget {
  final List<DashboardGridItem> items;

  DashboardGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      // gradient: LinearGradient(
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      //   colors: [
      //     Color(0xff5D5FEF),
      //     Color(0xffB857FF),
      //   ],
      // ),
      // ),
      child: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: items,
        ),
      ),
    );
  }
}

class DashboardGridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  DashboardGridItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        padding: EdgeInsets.only(left: 3,right: 3),
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 45,
              color: Colors.white,
            ),
            SizedBox(height: 13),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
