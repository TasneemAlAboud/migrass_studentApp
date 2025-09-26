import 'package:student/core/widgets/Models.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int circleId;
  final List<LessonHomeScreenModel> lessons;
  final List<achivmenHomeScreenModel> achievements;
  final String studentFirstName;
  final String studentLastName;

  HomeLoaded({required this.lessons, required this.achievements,  required this.circleId,   required this.studentFirstName,
    required this.studentLastName,});

  @override
  List<Object?> get props => [circleId, lessons, achievements];
}


class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
