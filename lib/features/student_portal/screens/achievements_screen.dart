import 'package:flutter/material.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  List<Achievement> _achievements = [
    Achievement(
      name: 'Perfect Attendance',
      description: 'Attended all classes this semester!',
      icon: Icons.calendar_today,
      earned: true,
    ),
    Achievement(
      name: '100% on Final Exam',
      description: 'Aced the final exam!',
      icon: Icons.school,
      earned: true,
    ),
    Achievement(
      name: 'Class President',
      description: 'Elected as class president!',
      icon: Icons.star,
      earned: false,
    ),
    Achievement(
      name: 'Volunteer of the Year',
      description: 'Recognized as volunteer of the year!',
      icon: Icons.favorite,
      earned: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Achievements'),
      ),
      body: ListView.builder(
        itemCount: _achievements.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildAchievementCard(_achievements[index]);
        },
      ),
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Card(
      child: ListTile(
        leading: Icon(
          achievement.icon,
          size: 48.0,
        ),
        title: Text(
          achievement.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          achievement.description,
        ),
        trailing: achievement.earned
            ? Icon(
          Icons.check_circle,
          color: Colors.green,
        )
            : Text(
          'Not earned',
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class Achievement {
  final String name;
  final String description;
  final IconData icon;
  final bool earned;

  Achievement({
    required this.name,
    required this.description,
    required this.icon,
    required this.earned,
  });
}
