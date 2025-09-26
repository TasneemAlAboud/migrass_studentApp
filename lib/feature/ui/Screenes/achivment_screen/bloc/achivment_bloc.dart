/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/widgets/Models.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_eventes.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/bloc/achivment_states.dart';

class AchivmentBloc extends Bloc<AchivmentEvent, AchivmentState> {
  AchivmentBloc() : super(AchivmentInitial()) {
    on<LoadAchivments>((event, emit) async {
      emit(AchivmentLoading());

      try {
        await Future.delayed(Duration(seconds: 1)); // محاكاة تحميل

        final data = [
          achivmentModel(
            date: "2025_ 01 _ 01",
            doneMyAchivment: " سورة الإسراء من 1 \nإلى 50 من سورة الإسراء ",
          ),
          achivmentModel(
            date: "2024_ 05 _ 07",
            doneMyAchivment: " سورة البقرة من 100 \nإلى 50 من سورة آل عمران ",
          ),
          achivmentModel(
            date: "2025_ 2 _ 06",
            doneMyAchivment: " سورة الإسراء من 1 \nإلى 50 من سورة الإسراء ",
          ),
        ];

        emit(AchivmentLoaded(data));
      } catch (_) {
        emit(AchivmentError("فشل تحميل الإنجازات"));
      }
    });
  }
}
*/

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
