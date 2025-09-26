
import 'package:student/feature/ui/Screenes/achivment_screen/achivment_Model.dart';

abstract class AchivmentState {}

class AchivmentInitial extends AchivmentState {}

class AchivmentLoading extends AchivmentState {}

class AchivmentLoaded extends AchivmentState {
  final List<AchivmentModel> achivments;

  AchivmentLoaded(this.achivments);
}

class AchivmentError extends AchivmentState {
  final String message;

  AchivmentError(this.message);
}
