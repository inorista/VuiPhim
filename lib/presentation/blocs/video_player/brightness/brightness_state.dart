part of 'brightness_cubit.dart';

enum BrightnessStatus { initial, loading, success, failure }

class BrightnessState extends Equatable {
  const BrightnessState({
    this.status = BrightnessStatus.initial,
    this.brightness = 0.5,
    this.errorMessage,
  });

  final BrightnessStatus status;
  final double brightness;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, brightness, errorMessage];

  BrightnessState copyWith({
    BrightnessStatus? status,
    double? brightness,
    String? errorMessage,
  }) {
    return BrightnessState(
      status: status ?? this.status,
      brightness: brightness ?? this.brightness,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
