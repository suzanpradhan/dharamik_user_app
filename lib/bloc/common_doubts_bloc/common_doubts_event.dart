part of 'common_doubts_bloc.dart';

@immutable
abstract class CommonDoubtsEvent {
  CommonDoubtsEvent();
}

class GetInitialCommonDoubts extends CommonDoubtsEvent{
  GetInitialCommonDoubts();
}

class GetNextCommonDoubts extends CommonDoubtsEvent{
  GetNextCommonDoubts();
}
