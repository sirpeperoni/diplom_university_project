import 'package:the_movie_db/domain/api_client/account_api_client.dart';
import 'package:the_movie_db/domain/api_client/auth_api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';

class AuthService{
  final _sessionDataProvider = SessionDataProvider();
  final _authApiClient = AuthApiClient();
  final _acountApiClient =AccountApiClient();
  
  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  Future<void> login(String login, String password) async {
    final sessionId = await _authApiClient.auth(
        username: login,
        password: password,
      );
    final accountId = await _acountApiClient.getAccountInfo(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }

  Future<void> logout() async {
    await _sessionDataProvider.deleteSessionId();
    await _sessionDataProvider.deleteAccountId();
  }

}