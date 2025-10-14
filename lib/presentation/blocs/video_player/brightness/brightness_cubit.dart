import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/native/brightness_native.dart';

part 'brightness_state.dart';

class BrightnessCubit extends Cubit<BrightnessState> {
  BrightnessCubit() : super(const BrightnessState());
  Future<void> getBrightness() async {
    try {
      emit(state.copyWith(status: BrightnessStatus.loading));
      final currentBrightness = await BrightnessNative.getBrightness();
      emit(
        state.copyWith(
          status: BrightnessStatus.success,
          brightness: currentBrightness,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BrightnessStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setBrightness(double brightness) async {
    final clampedBrightness = brightness.clamp(0.0, 1.0);
    try {
      await BrightnessNative.setBrightness(clampedBrightness);
      emit(
        state.copyWith(
          status: BrightnessStatus.success,
          brightness: clampedBrightness,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BrightnessStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
