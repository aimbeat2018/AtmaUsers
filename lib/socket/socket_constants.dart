class SocketConstants {
  /// =================== Default  =================== ///
  static const String eventConnect = "connect";
  static const String eventDisconnect = "disconnect";
  static const String eventConnectTimeout = "connect_timeout";
  static const String onSocketError = "onSocketError";
  static const String websocket = "websocket";
  static const String globalRoom = "globalRoom";

  /// =================== Message Event =================== ///
  static const String message = "message";

  /// =================== Video Call Event =================== ///
  static const String makeCall = "makeCall";
  static const String callRequest = "callRequest";
  static const String callAnswer = "callAnswer";
  static const String callCancel = "callCancel";
  static const String callDisconnect = "callDisconnect";
}
