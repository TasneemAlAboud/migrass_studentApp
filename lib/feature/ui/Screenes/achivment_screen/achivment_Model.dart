

class AchivmentModel {
  final String date;
  final String day;
  final String title;
  final String isCounted;
  final String type;


  AchivmentModel({
    required this.date,
    required this.day,
    required this.title,
    required this.isCounted,
    required this.type,

  });


  factory AchivmentModel.fromQuran(Map<String, dynamic> json) {
    return AchivmentModel(
      date: json['date'] ?? '',
      day: json['day'] ?? '',
      title: "${json['fromSurahName']} (${json['fromAyah']}) → ${json['toSurahName']} (${json['toAyah']})",
      isCounted: json['is_counted'] ?? '', type: "قرآن", ); }

  factory AchivmentModel.fromHadith(Map<String, dynamic> json) {
    return AchivmentModel(
      date: json['date'] ?? '',
      day: json['day'] ?? '',
      title: "${json['bookName']} (${json['fromHadith']} → ${json['toHadith']})",
      isCounted: json['is_counted'] ?? '', type: "حديث", ); }

  factory AchivmentModel.fromTalkeen(Map<String, dynamic> json) {
    return AchivmentModel(
      date: json['date'] ?? '',
      day: json['day'] ?? '',
      title: "${json['fromSurahName']} (${json['fromAyah']}) → ${json['toSurahName']} (${json['toAyah']})",
      isCounted: json['is_counted'] ?? '', type: "تلقين", ); } }