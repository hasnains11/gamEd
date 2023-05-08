class Classroom {
  final String joiningCode;
  final String name;
  final List<Map<String, dynamic>> students;
  final String teacherEmail;
  final String teacherName;
  final String id;

  Classroom({
    required this.id,
    required this.joiningCode,
    required this.name,
    required this.students,
    required this.teacherEmail,
    required this.teacherName,
  });

}