import 'package:flutter/material.dart';

class BadgeSection extends StatelessWidget {
  final List<int> badgesEarned;
  final List<String> allBadges = [ "Hello, World!",  "Syntax Master", "Variable Ninja",
    "Function Aficionado",  "Conditional Champion",  "Looping Legend",]
  ;

  BadgeSection({required this.badgesEarned});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Badges Earned',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: allBadges.map((badgeName) {
              int index= allBadges.indexOf(badgeName);
              bool earned = badgesEarned.contains(index);
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: earned ? Colors.greenAccent[100] : Colors.grey[300],
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: earned ? Colors.yellow[700] : Colors.grey[800],
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      badgeName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
