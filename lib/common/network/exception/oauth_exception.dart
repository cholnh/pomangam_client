enum OauthExceptionType { networkError, serverMaintenance, serverClosed, badCredentials }

class OauthNetworkException implements Exception {
  OauthExceptionType type;
  OauthNetworkException(this.type);
}