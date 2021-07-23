part of 'user_doubts_bloc.dart';

@immutable
abstract class UserDoubtsState {
  UserDoubtsState();
}

class UserDoubtsDialogInitial extends UserDoubtsState{
  final List<DoubtCategory> doubtCategories;
  UserDoubtsDialogInitial(this.doubtCategories);
}

class UserDoubtsDialogLoading extends UserDoubtsState {
  UserDoubtsDialogLoading();
}

class UserDoubtUploaded extends UserDoubtsState{
  UserDoubtUploaded();
}
