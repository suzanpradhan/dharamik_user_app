part of 'user_doubts_bloc.dart';

@immutable
abstract class UserDoubtsEvent {
  UserDoubtsEvent();
}

class GetUserDoubtDialogInfo extends UserDoubtsEvent{
  GetUserDoubtDialogInfo();
}

class ImageChangedEvent extends UserDoubtsEvent{
  File file;
  ImageChangedEvent(this.file);
}

class CreateDoubtEvent extends UserDoubtsEvent{
  final UserDoubtModel userDoubtModel;
  CreateDoubtEvent(this.userDoubtModel);
}
