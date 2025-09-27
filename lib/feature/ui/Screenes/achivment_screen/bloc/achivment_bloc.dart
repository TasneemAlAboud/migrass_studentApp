

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/achivment_Model.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_eventes.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_states.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchivmentBloc extends Bloc<AchivmentEvent, AchivmentState> {
  final DioConsumer api;

  AchivmentBloc(this.api) : super(AchivmentInitial()) {
    on<LoadAchivments>((event, emit) async {
      emit(AchivmentLoading());

      try {

       final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null) {
          emit(AchivmentError("No token found, please login again."));
          return;
        }

        final response = await api.get(
          "/api/quran-recitation/getMySaved",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );

        List<AchivmentModel> achivments = [];


        final List<dynamic> quranData = response.data['quran'] ?? [];
        achivments.addAll(
            quranData.map((e) => AchivmentModel.fromQuran(e)).toList());


        final List<dynamic> hadithData = response.data['hadith'] ?? [];
        achivments.addAll(
            hadithData.map((e) => AchivmentModel.fromHadith(e)).toList());


        final List<dynamic> talkeenData = response.data['talkeen'] ?? [];
        achivments.addAll(
            talkeenData.map((e) => AchivmentModel.fromTalkeen(e)).toList());

        emit(AchivmentLoaded(achivments));
      } catch (e) {
        emit(AchivmentError(e.toString()));
      }
    });
  }
}
