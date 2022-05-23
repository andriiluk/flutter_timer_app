import 'package:app/models/timer/timer_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_overview_state.dart';

class TimerOverviewCubit extends Cubit<TimerOverviewState> {
  TimerOverviewCubit()
      : super(
          TimerOverviewState(
              timerEntity: TimerEntity(title: 'New timer'),
              seconds: 30,
              minutes: 0,
              hours: 0),
        );

  void updateSeconds(int seconds) {
    emit(
      state.copyWith(
        seconds: seconds,
      ),
    );
  }

  void updateMinutes(int minutes) {
    emit(
      state.copyWith(
        minutes: minutes,
      ),
    );
  }
  void updateHours(int hours) {
    emit(
      state.copyWith(
        hours: hours,
      ),
    );
  }

  void saveTimerItem() {
    final duration = Duration(
      seconds: state.seconds,
      minutes: state.minutes,
      hours: state.hours,
    );

    if (duration.inSeconds == 0 ) {
      return;
    }

    List<TimerItem> newItems = [...state.timerEntity.items, TimerItem(
      title: 'title',
      duration: duration,
    )];

    // state.timerEntity.items.add(item);
    emit(
      state.copyWith(timerEntity: TimerEntity(title: state.timerEntity.title, items: newItems), seconds: 0, minutes: 0, hours: 0)
    );
  }
}
