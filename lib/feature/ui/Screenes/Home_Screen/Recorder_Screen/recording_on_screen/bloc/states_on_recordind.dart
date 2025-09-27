
import 'package:equatable/equatable.dart';

class SendRecordState extends Equatable {
  final List<Map<String, dynamic>> surahs;
  final String? selectedSurah;
  final int? fromAya;
  final int? toAya;

  const SendRecordState({
    this.surahs = const [],
    this.selectedSurah,
    this.fromAya,
    this.toAya,
  });

  SendRecordState copyWith({
    List<Map<String, dynamic>>? surahs,
    String? selectedSurah,
    int? fromAya,
    int? toAya,
  }) {
    return SendRecordState(
      surahs: surahs ?? this.surahs,
      selectedSurah: selectedSurah ?? this.selectedSurah,
      fromAya: fromAya ?? this.fromAya,
      toAya: toAya ?? this.toAya,
    );
  }

  @override
  List<Object?> get props => [surahs, selectedSurah, fromAya, toAya];
}


class SendRecordUploading extends SendRecordState {
  const SendRecordUploading();
}

class SendRecordSuccess extends SendRecordState {
  final String message;
  final int audioId;
  const SendRecordSuccess(this.message, {required this.audioId});

  @override
  List<Object?> get props => [message, audioId];
}

class SendRecordFailure extends SendRecordState {
  final String error;
  const SendRecordFailure(this.error);

  @override
  List<Object?> get props => [error];
}
