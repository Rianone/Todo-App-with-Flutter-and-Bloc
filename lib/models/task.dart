import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable{
  final String title;
  final String description;
  final String id;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  Task({required this.title,required this.description,required this.id, this.isDone, this.isDeleted, this.isFavorite}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({String? title, String? description, String? id, bool? isDone, bool? isDeleted, bool? isFavorite}) {
    return Task(
        title: title ?? this.title,
        description: description ?? this.description,
        id: id ?? this.id,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  }

  Map<String, dynamic> toMap() {
    return {'title': title,'description': description, 'isDone': isDone, 'isDeleted': isDeleted, 'isFavorite': isFavorite};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        id: map['id'] ?? '',
        isDone: map['isDone'] ?? '',
        isDeleted: map['isDeleted'] ?? '',
        isFavorite: map['isFavorite'] ?? ''
      );
  }
  
  @override
  List<Object?> get props => [title,description,id,isDone,isDeleted, isFavorite];
}
