part of 'timer_entity.dart';

class TimerItem {
  TimerItem({required this.title, required this.duration});

  factory TimerItem.fromJson(Map<String, dynamic> data) {
    final seconds = data['duration'] as int;

    return TimerItem(
      title: data['title'] as String,
      duration: Duration(seconds: seconds),
    );
  }

  String title;
  Duration duration;

  String formattedDuration() {
    return trimNulls(duration);
  }


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'duration': duration.inSeconds,
    };
  }
}
