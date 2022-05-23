import 'dart:developer';

import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_running_state.dart';

class TimerRunningCubit extends Cubit<TimerRunningState> {
  TimerRunningCubit({required this.timerEntity})
      : super(TimerRunningState(
            status: TimerStatus.initial,
            currentItem: 0,
            itemCountdown: timerEntity.items[0].duration,
            overallCountdown:
                timerEntity.summaryDuration(timerEntity.items.length),
            overallCount: Duration.zero));

  final TimerEntity timerEntity;

  doTick() {
    if (state.isWaiting() || state.isFinished()) {
      return;
    }

    final overallCountdown = state.overallCountdown - Duration(seconds: 1);
    final overallCount = state.overallCount + Duration(seconds: 1);
    final itemCountdown = state.itemCountdown - Duration(seconds: 1);

    if (overallCountdown <= Duration.zero) {
      emit(state.copyWith(
        status: TimerStatus.completed,
        itemCountdown: itemCountdown,
        overallCountdown: overallCountdown,
        overallCount: overallCount,
      ));

      return;
    }

    if (itemCountdown == Duration.zero &&
        state.currentItem < (timerEntity.items.length - 1)) {
      emit(state.copyWith(
        currentItem: state.currentItem + 1,
        itemCountdown: timerEntity.items[state.currentItem + 1].duration,
        overallCountdown: overallCountdown,
        overallCount: overallCount,
      ));

      return;
    }

    // current item stays the same
    if (state.itemCountdown > Duration.zero) {
      emit(state.copyWith(
        itemCountdown: itemCountdown,
        overallCountdown: overallCountdown,
        overallCount: overallCount,
      ));

      return;
    }
  }

  refresh() {
    emit(TimerRunningState(
      status: TimerStatus.initial,
      currentItem: 0,
      itemCountdown: timerEntity.items[0].duration,
      overallCountdown: timerEntity.summaryDuration(timerEntity.items.length),
      overallCount: Duration.zero,
    ));
  }

  setStatus(TimerStatus status) {
    emit(state.copyWith(status: TimerStatus.canceled));
  }

  toggleStatus() {
    if (state.isWaiting()) {
      emit(state.copyWith(status: TimerStatus.running));
      return;
    }

    if (state.isRunning()) {
      emit(state.copyWith(status: TimerStatus.paused));
      return;
    }
  }
}
