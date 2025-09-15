import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/native/brightness_native.dart';

part 'brightness_state.dart';

class BrightnessCubit extends Cubit<BrightnessState> {
  BrightnessCubit() : super(BrightnessInitial());
  double _brightness = 0.0;

  void getBrightness() async {
    emit(const BrightnessLoading());
    try {
      _brightness = await BrightnessNative.getBrightness();
      emit(BrightnessLoaded(_brightness));
    } catch (e) {
      emit(BrightnessError(e.toString()));
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await BrightnessNative.setBrightness(brightness);
      _brightness = brightness;
      emit(BrightnessLoaded(_brightness));
    } catch (e) {
      emit(BrightnessError(e.toString()));
    }
  }
}
