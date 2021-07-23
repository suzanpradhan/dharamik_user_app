import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:webapp/models/premium_signal_model.dart';
import 'package:webapp/repositories/premium_signals_repository.dart';


part 'premium_signals_event.dart';
part 'premium_signals_state.dart';

class PremiumSignalsBloc extends Bloc<PremiumSignalsEvent, PremiumSignalsState> {
  List<PremiumSignalModel> premiumSignals = List();
  PremiumSignalsRepo _premiumSignalsRepo = PremiumSignalsRepo();
  @override
  PremiumSignalsState get initialState => PremiumSignalsLoading();

  @override
  Stream<PremiumSignalsState> mapEventToState(
    PremiumSignalsEvent event,
  ) async* {
    
    if(event is GetInitialSignals){
      yield PremiumSignalsLoading();
      premiumSignals = List();
      var initialSignals = await _premiumSignalsRepo.getPremiumSignals();
      this.premiumSignals.addAll(initialSignals);
      yield PremiumSignalsLoaded(this.premiumSignals);
    }else if(event is GetNextSignals){
      var nextSignals = await _premiumSignalsRepo.getNextSignals();
      this.premiumSignals.addAll(nextSignals);
      yield PremiumSignalsLoaded(this.premiumSignals);
    }
  }
}
