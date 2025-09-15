part of 'brightness_cubit.dart';

abstract class BrightnessState extends Equatable {
  const BrightnessState();

  @override
  List<Object> get props => [];
}

class BrightnessInitial extends BrightnessState {}

class BrightnessLoading extends BrightnessState {
  const BrightnessLoading();
  @override
  List<Object> get props => [];
}

class BrightnessLoaded extends BrightnessState {
  final double brightness;

  const BrightnessLoaded(this.brightness);

  @override
  List<Object> get props => [brightness];
}

class BrightnessError extends BrightnessState {
  final String message;

  const BrightnessError(this.message);

  @override
  List<Object> get props => [message];
}
