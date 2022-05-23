part of 'timer_running_cubit.dart';

enum TimerStatus {initial, running, paused, canceled, completed}

class TimerRunningState extends Equatable {
  TimerRunningState({
    required this.status,
    required this.currentItem,
    required this.itemCountdown,
    required this.overallCountdown,
    required this.overallCount,
  });

  final TimerStatus status;
  final int currentItem;
  final Duration overallCount;
  final Duration overallCountdown;
  final Duration itemCountdown;

  TimerRunningState copyWith({
    TimerStatus? status,
    int? currentItem,
    Duration? overallCount,
    Duration? overallCountdown,
    Duration? itemCountdown,
  }) {
    return TimerRunningState(
      status: status ?? this.status,
      currentItem: currentItem ?? this.currentItem,
      overallCount: overallCount ?? this.overallCount,
      overallCountdown: overallCountdown ?? this.overallCountdown,
      itemCountdown: itemCountdown ?? this.itemCountdown,
    );
  }

  bool isRunning() {
    return status == TimerStatus.running;
  }

  bool isWaiting() {
    return (status == TimerStatus.initial || status == TimerStatus.paused);
  }

  bool isFinished() {
    return (status == TimerStatus.completed || status == TimerStatus.canceled);
  }

  @override
  List<Object?> get props =>
      [currentItem, overallCount, itemCountdown, overallCountdown, status];
}
