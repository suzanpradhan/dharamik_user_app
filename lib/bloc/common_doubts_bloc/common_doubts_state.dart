part of 'common_doubts_bloc.dart';

@immutable
abstract class CommonDoubtsState {
  CommonDoubtsState();
}

class CommonDoubtsLoading extends CommonDoubtsState {
  CommonDoubtsLoading();
}

class CommonDoubtsLoaded extends CommonDoubtsState{
  final List<UserDoubtModel> commonDoubts;
  CommonDoubtsLoaded(this.commonDoubts);
}
