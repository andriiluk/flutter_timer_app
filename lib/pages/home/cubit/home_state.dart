part of 'home_cubit.dart';

enum HomeTab { timer, settings }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.timer,
  });

  final HomeTab tab;

  @override
  List<Object?> get props => [tab];
}
