/*
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/events_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/states_on_recordind.dart';


class SendRecordBloc extends Bloc<SendRecordEvent, SendRecordState> {
  final DioConsumer api = DioConsumer(Dio());

  SendRecordBloc() : super(const SendRecordState()) {
    on<SelectSurah>((event, emit) {
      emit(state.copyWith(selectedSurah: event.surah));
    });

    on<SelectFromAya>((event, emit) {
      emit(state.copyWith(fromAya: event.fromAya));
    });

    on<SelectToAya>((event, emit) {
      emit(state.copyWith(toAya: event.toAya));
    });
    on<UploadRecord>((event, emit) async {
      emit(const SendRecordUploading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null) {
          emit(const SendRecordFailure("التوكن غير موجود"));
          return;
        }

        final formData = FormData.fromMap({
          "audio": await MultipartFile.fromFile(
            event.filePath,
            filename: "record.m4a",
          ),
          "surah_id": event.surahId,
          "from_ayah_id": event.fromAya,
          "to_ayah_id": event.toAya,
        });

        final response = await api.post(
          "/api/UserAudio/uploadAudio",
          data: formData,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );
        print("DEBUG: response.data 1111= ${response.data}");
    // emit(SendRecordSuccess(response.data["message"]));
      //  emit(SendRecordSuccess("تم رفع التسجيل بنجاح", audioId: response.data["audio"]["id"]));
        emit(SendRecordSuccess("تم رفع التسجيل بنجاح", audioId: response.data["id"]));

        print("DEBUG: response.data = ${response.data}");
      } catch (e) {
        emit(SendRecordFailure(e.toString()));
      }
    });
  }

}
   on<LoadSurahs>((event, emit) async {
    try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await api.get(
    "/api/SurahAndAyah/AllSurahAndAyah",
    options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final List data = response.data["result"];
       final surahs = data.map((item) {
       return {
         "id": item["surah"]["id"],
             "name": item["surah"]["name"],
              "ayat_counts": item["surah"]["ayat_counts"],
           };
             }).toList();

        emit(state.copyWith(surahs: surahs));
        } catch (e) {
          print("Error loading surahs: $e");
      }
    });
*/

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/events_on_recordind.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recording_on_screen/bloc/states_on_recordind.dart';

class SendRecordBloc extends Bloc<SendRecordEvent, SendRecordState> {
  final DioConsumer api = DioConsumer(Dio());

  SendRecordBloc() : super(const SendRecordState()) {

    on<SelectSurah>((event, emit) {
      emit(state.copyWith(selectedSurah: event.surah));
    });


    on<SelectFromAya>((event, emit) {
      emit(state.copyWith(fromAya: event.fromAya));
    });


    on<SelectToAya>((event, emit) {
      emit(state.copyWith(toAya: event.toAya));
    });


    on<LoadSurahs>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null) {
          print("Error: token not found");
          return;
        }

        final response = await api.get(
          "/api/SurahAndAyah/AllSurahAndAyah",
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );

        final List data = response.data["result"];
        final surahs = data.map((item) {
          return {
            "id": item["surah"]["id"],
            "name": item["surah"]["name"],
            "ayat_counts": item["surah"]["ayat_counts"],
          };
        }).toList();

        emit(state.copyWith(surahs: surahs));
      } catch (e) {
        print("Error loading surahs: $e");
      }
    });


    on<UploadRecord>((event, emit) async {
      emit(const SendRecordUploading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null) {
          emit(const SendRecordFailure("التوكن غير موجود"));
          return;
        }

        final formData = FormData.fromMap({
          "audio": await MultipartFile.fromFile(
            event.filePath,
            filename: "record.m4a",
          ),
          "surah_id": event.surahId,
          "from_ayah_id": event.fromAya,
          "to_ayah_id": event.toAya,
        });

        final response = await api.post(
          "/api/UserAudio/uploadAudio",
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ),
        );

        print("DEBUG: response.data = ${response.data}");

        emit(SendRecordSuccess(
          "تم رفع التسجيل بنجاح",
          audioId: response.data["id"],
        ));
      } catch (e) {
        emit(SendRecordFailure(e.toString()));
      }
    });
  }
}
