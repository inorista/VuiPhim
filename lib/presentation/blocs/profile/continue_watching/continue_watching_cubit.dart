import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iserver_data_service.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/presentation/screens/profile_screen/widgets/continue_watching_ui_model.dart';

part 'continue_watching_state.dart';

class ContinueWatchingCubit extends Cubit<ContinueWatchingState> {
  ContinueWatchingCubit() : super(const ContinueWatchingState());
  final _serverDataService = locator<IServerDataService>();

  Future<void> loadContinueWatchingList() async {
    List<ContinueWatchingUIModel> continueWatchingUIModels = [];
    try {
      final continueWatchingList = await _serverDataService
          .getContinueWatchingList();

      if (continueWatchingList.isEmpty) {
        emit(
          state.copyWith(
            status: ContinueWatchingStatus.loaded,
            continueWatchingList: [],
          ),
        );
      } else {
        for (final item in continueWatchingList) {
          if (item.episodeId == null) continue;
          final movieEntity = await _serverDataService.getMovieByEpisodeId(
            item.episodeId!,
          );
          if (movieEntity != null) {
            continueWatchingUIModels.add(
              ContinueWatchingUIModel(serverData: item, movie: movieEntity),
            );
          }
        }
        emit(
          state.copyWith(
            status: ContinueWatchingStatus.loaded,
            continueWatchingList: continueWatchingUIModels,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ContinueWatchingStatus.error,
          continueWatchingList: [],
        ),
      );
    }
  }
}
