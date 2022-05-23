part 'timer_item.dart';

String trimTrailingNulls(Duration duration) {
  final durationStr = duration.toString();
  final ind = durationStr.indexOf('.');
  if (ind == -1) {
    return "";
  }

  return durationStr.substring(0, ind);

}

String trimLeadingNulls(Duration duration) {
  final durationStr = duration.toString();
  final ind = durationStr.indexOf(RegExp(r'[1-9]'));
  if (ind == -1) {
    return "";
  }

  return durationStr.substring(ind, durationStr.length);
}

String trimNulls(Duration duration) {
  String durationStr = duration.toString();
  int ind = durationStr.indexOf(RegExp(r'[1-9]'));
  if (ind != -1) {
    durationStr = durationStr.substring(ind, durationStr.length);
  }

  ind = durationStr.indexOf('.');
  if (ind != -1) {
    durationStr = durationStr.substring(0, ind);
  }

  return durationStr;
}


class TimerEntity {
  TimerEntity({required this.title, this.items = const []});

  factory TimerEntity.fromJson(Map<String, dynamic> data) {
    final itemsData = data['items'] as List<dynamic>?;

    final items = itemsData != null
        ? itemsData.map((dynamic e) {
            return TimerItem.fromJson(e as Map<String, dynamic>);
          }).toList()
        : <TimerItem>[];

    return TimerEntity(
      title: data['title'] as String,
      items: items,
    );
  }

  String title;
  List<TimerItem> items;

  Duration summaryDuration(int? end) {
    Duration sumDuration = Duration();
    for (int i = 0; i < items.length; i++) {
      if (end != null && i <= end) {
        sumDuration += items[i].duration;
      }
    }

    return sumDuration;
  }

  String summaryDurationString(int? end) {
    return trimTrailingNulls(summaryDuration(end)) ;
  }

  Map toJson() => <String, dynamic>{
        'title': title,
        'items': items,
      };
}
