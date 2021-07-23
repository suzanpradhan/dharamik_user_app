import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/common_doubts_model.dart';
import 'package:webapp/models/user_doubt_model.dart';
import 'package:webapp/repositories/common_doubts_repository.dart';
import 'package:webapp/utils/service_locator.dart';

part 'common_doubts_event.dart';
part 'common_doubts_state.dart';

class CommonDoubtsBloc extends Bloc<CommonDoubtsEvent, CommonDoubtsState> {
  List<UserDoubtModel> commonDoubts = List();
  CommonDoubtsRepo _commonDoubtsRepo = locator<CommonDoubtsRepo>();
  @override
  CommonDoubtsState get initialState => CommonDoubtsLoading();

  @override
  Stream<CommonDoubtsState> mapEventToState(
    CommonDoubtsEvent event,
  ) async* {
    if(event is GetInitialCommonDoubts){
      yield CommonDoubtsLoading();
      commonDoubts = List();
      var initialDoubts = await _commonDoubtsRepo.getCommonDoubts();
      this.commonDoubts.addAll(initialDoubts);
      yield CommonDoubtsLoaded(this.commonDoubts);
      }else if(event is GetNextCommonDoubts){
        var nextDoubts = await _commonDoubtsRepo.getNextCommonDoubts();
        this.commonDoubts.addAll(nextDoubts);
        yield CommonDoubtsLoaded(this.commonDoubts);
      }
  }
}
