/*

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/Model_Recorder_Details.dart';
import 'events.dart';
import 'states.dart';

class RecordDetailsBloc extends Bloc<RecordDetailsEvent, RecordDetailsState> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final DioConsumer dio;

  RecordDetailsBloc({required this.dio})
      : super(RecordDetailsState(isPlaying: false, rating: 0)) {
    _player.openPlayer();

    on<FetchRecordDetailsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final response = await dio.get(
          "/api/UserAudio/getAudioById/${event.audioId}",
        );

        final model = AudioDetailsModel.fromJson(response.data);

        emit(state.copyWith(
          isLoading: false,
          audioDetails: model,
          rating: model.comments.isNotEmpty ? model.comments.first.rate : 0,
        ));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<TogglePlayEvent>((event, emit) async {
      if (state.isPlaying) {
        await _player.stopPlayer();
        emit(state.copyWith(isPlaying: false));
      } else {
        if (state.audioDetails != null) {
          final fileUrl =
              "${dio.dio.options.baseUrl}/${state.audioDetails!.filePath}";
          try {
            await _player.startPlayer(
              fromURI: fileUrl,
              codec: Codec.aacMP4,
              whenFinished: () => add(TogglePlayEvent()),
            );
            emit(state.copyWith(isPlaying: true));
          } catch (e) {
            emit(state.copyWith(error: "تعذر تشغيل الصوت: $e"));
          }
        }
      }
    });


    on<UpdateRatingEvent>((event, emit) {
      emit(state.copyWith(rating: event.rating));
    });
  }

  @override
  Future<void> close() {
    _player.closePlayer();
    return super.close();
  }
}
*/


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/Model_Recorder_Details.dart';
import 'events.dart';
import 'states.dart';

class RecordDetailsBloc extends Bloc<RecordDetailsEvent, RecordDetailsState> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final DioConsumer dio;

  RecordDetailsBloc({required this.dio})
      : super(RecordDetailsState(isPlaying: false, rating: 0)) {
    _player.openPlayer();

    on<FetchRecordDetailsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        if (token == null) {
          emit(state.copyWith(isLoading: false, error: "ما في توكن محفوظ"));
          return;
        }

        final response = await dio.get(
            "/api/UserAudio/getAudioById/${event.audioId}",
            options: Options(
              headers: {"Authorization": "Bearer $token"},
            )
        );
        final model = AudioDetailsModel.fromJson(response.data);

        emit(state.copyWith(
          isLoading: false,
          audioDetails: model,
          rating: model.comments.isNotEmpty ? model.comments.first.rate : 0,
        ));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<TogglePlayEvent>((event, emit) async {
      if (state.isPlaying) {
        await _player.stopPlayer();
        emit(state.copyWith(isPlaying: false));
      } else {
        if (state.audioDetails != null) {
          final fileUrl =
              "${dio.dio.options.baseUrl}/${state.audioDetails!.filePath}";
          try {
            await _player.startPlayer(
              fromURI: fileUrl,
              codec: Codec.aacMP4,
              whenFinished: () => add(TogglePlayEvent()),
            );
            emit(state.copyWith(isPlaying: true));
          } catch (e) {
            emit(state.copyWith(error: "تعذر تشغيل الصوت: $e"));
          }
        }
      }
    });


    on<UpdateRatingEvent>((event, emit) {
      emit(state.copyWith(rating: event.rating));
    });
  }

  @override
  Future<void> close() {
    _player.closePlayer();
    return super.close();
  }
}
