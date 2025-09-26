/*
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/bloc/bloc.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/bloc/events.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/bloc/states.dart';

class RecordDetailsScreen extends StatelessWidget {
  final int audioId;

  const RecordDetailsScreen({super.key, required this.audioId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordDetailsBloc(dio: DioConsumer(Dio()))..add(FetchRecordDetailsEvent(audioId)),
      child: Scaffold(
        backgroundColor: ColorManager.successBackgroundLight,
        body: SafeArea(
          child: BlocBuilder<RecordDetailsBloc, RecordDetailsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.error != null) {
                return Center(child: Text("خطأ: ${state.error}"));
              }
              if (state.audioDetails == null) {
                return const Center(child: Text("لا توجد بيانات"));
              }

              final audio = state.audioDetails!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 🔹 العنوان و زر الرجوع
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            IconImageManager.blackBack,
                            width: 35,
                            height: 35,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        const Text(
                          "تفاصيل التسجيل",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // 🔹 كارد التسجيل
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    state.isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: ColorManager.successLight,
                                    size: 32,
                                  ),
                                  onPressed: () => context.read<RecordDetailsBloc>().add(TogglePlayEvent()),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(audio.surahName),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          Text(
                            "الكمية : ${audio.surahName} من ${audio.fromAyahId} الى ${audio.toAyahId}",
                            style: const TextStyle(fontSize: 16),
                          ),

                          const SizedBox(height: 20),
                          const Text(
                            "الملاحظات :",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              audio.comments.isNotEmpty ? audio.comments.first.text : "لا توجد ملاحظات",
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Text(
                            "التقييم",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<RecordDetailsBloc>().add(UpdateRatingEvent(index + 1));
                                },
                                child: Icon(
                                  Icons.star,
                                  color: index < state.rating ? Colors.amber : Colors.grey,
                                  size: 30,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
*/

import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/api/dio_consumer.dart';
import 'package:student/core/resource/colors_manager.dart';
import 'package:student/core/resource/icon_image_manager.dart';
import 'package:student/core/widgets/green_container.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/bloc/bloc.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/bloc/events.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/Recorder_Screen/recorder_details/bloc/states.dart';

class RecordDetailsScreen extends StatelessWidget {
  final int audioId;

  const RecordDetailsScreen({super.key, required this.audioId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordDetailsBloc(dio: DioConsumer(Dio()))..add(FetchRecordDetailsEvent(audioId)),
      child: Scaffold(
        backgroundColor: ColorManager.successBackgroundLight,
        body: SafeArea(
          child: BlocBuilder<RecordDetailsBloc, RecordDetailsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.error != null) {
                return Center(child: Text("خطأ: ${state.error}"));
              }
              if (state.audioDetails == null) {
                return const Center(child: Text("لا توجد بيانات"));
              }

              final audio = state.audioDetails!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            IconImageManager.blackBack,
                            width: 35,
                            height: 35,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        const Text(
                          "تفاصيل التسجيل",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              /*
                              Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 23,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: ColorManager.gray,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              state.isPlaying &&
                                                  state.currentPlayingPath ==
                                                      rec.filePath
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              size: 18,
                                              color: ColorManager.accentGreen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                               */
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 23,
                                      height: 23,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: ColorManager.gray,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: Icon(
                                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                                            color: ColorManager.successLight,
                                            size: 18,
                                          ),
                                          onPressed: () => context.read<RecordDetailsBloc>().add(TogglePlayEvent()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: WaveformWidget(
                                        waveData: List.generate(
                                            60,
                                                (i) => Random().nextDouble() * (30 + i % 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          Text(
                            "الكمية : ${audio.surahName} من ${audio.fromAyahId} الى ${audio.toAyahId}",
                            style: const TextStyle(fontSize: 16),
                          ),

                          const SizedBox(height: 20),
                          const Text(
                            "الملاحظات :",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                       /*   Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              audio.comments.isNotEmpty ? audio.comments.first.text : "لا توجد ملاحظات",
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),*/

                          Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                audio.comments.isNotEmpty ? audio.comments.first.text : "لا توجد ملاحظات",
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 14, height: 1.5),
                              ),
                            ),
                          ),


                          const SizedBox(height: 20),
                          const Text(
                            "التقييم",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<RecordDetailsBloc>().add(UpdateRatingEvent(index + 1));
                                },
                                child: Icon(
                                  Icons.star,
                                  color: index < state.rating ? Colors.amber : Colors.grey,
                                  size: 30,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
