part of 'premium_signals_bloc.dart';

@immutable
abstract class PremiumSignalsEvent {
  PremiumSignalsEvent();
}

class GetInitialSignals extends PremiumSignalsEvent{
  
  GetInitialSignals();
}

class GetNextSignals extends PremiumSignalsEvent{
  
  GetNextSignals(); 
}
