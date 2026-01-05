import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vuiphim/core/services/interfaces/ipath_provider_service.dart';

@LazySingleton(as: IPathProviderService)
class PathProviderService implements IPathProviderService {
  @override
  Future<String> getDownloadedEpisodePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
}
