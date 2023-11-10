/*import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { personal, work, shopping, others }

class Task {
  Task({
    required this.title,
    required this.description,
    this.date,
    this.category, required String id,
  }) : id = uuid.v4();

  final String id;
  late late final String title;
  final String description;
  final /* DateTime */ date;
  final /* category*/ category;
}
*/

import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { personal, work, shopping, others }

class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  final String id;
  String title;
  String description;
  DateTime date;
  Category category;

  toJson() {}
}
