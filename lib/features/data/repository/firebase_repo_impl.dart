import 'package:sample_project/features/data/data_sources/remote/urls.dart';
import 'package:sample_project/features/domain/repository/firebase_repo.dart';
import '../../../core/utils/enums.dart';
import '../data_sources/remote/base_service.dart';

class FirebaseRepoImpl implements FirebaseRepository {
  FirebaseRepoImpl(this.baseService);

  final BaseService baseService;

  @override
  Future<bool> fcmPushNotification(
      Map body, Map<String, String>? headers) async {
    var status = false;
    var response = await baseService.makeRequest(
        baseUrl: Urls.fcmBaseUrl,
        url: Urls.fcmEndPoint,
        body: body,
        headers: headers,
        method: RequestType.post);
    if (response != null && response["name"] != null) {
      status = true;
    }
    return status;
  }
}
