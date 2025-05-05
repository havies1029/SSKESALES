import 'package:esalesapp/apis/login/login_api.dart';

class LoginRepository {
  Future<bool> isTokenAktif(String userId, String tokenId) async {
    try {      
      UserLoginApi api = UserLoginApi();
      final isAktif = await api.isTokenAktif(userId, tokenId);
      return isAktif;
    } catch (e) {
      rethrow;
    }
  }
}
