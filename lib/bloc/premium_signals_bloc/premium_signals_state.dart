part of 'premium_signals_bloc.dart';

@immutable
abstract class PremiumSignalsState {
  PremiumSignalsState();
}

class PremiumSignalsLoading extends PremiumSignalsState {
  PremiumSignalsLoading();
}

class PremiumSignalsLoaded extends PremiumSignalsState{
  final List<PremiumSignalModel> premiumSignals;
  PremiumSignalsLoaded(this.premiumSignals);
}