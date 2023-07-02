import 'dart:developer';

class QrCodeData {
  final String code;
  final String options;
  final String details_url;
  final int version;
  final String client_id;

  const QrCodeData(
      {required this.code,
      required this.options,
      required this.details_url,
      required this.version,
      required this.client_id});

  factory QrCodeData.fromJson(Map<String, dynamic> json) {
    log('JSON = $json');
    return QrCodeData(
        code: json['code'],
        options: json['options'],
        details_url: json['details_url'],
        version: json['version'],
        client_id: json['client_id']);
  }
}

class VirtualToken {
  final String deviceName;
  final String deviceType;
  final String osVersion;
  final String applicationId;
  final String frontCameraSupport;
  final String fingerprintSupport;
  final String code;

  const VirtualToken({
    required this.deviceName,
    required this.deviceType,
    required this.osVersion,
    required this.applicationId,
    required this.frontCameraSupport,
    required this.fingerprintSupport,
    required this.code,
  });

  factory VirtualToken.fromJson(Map<String, dynamic> json) {
    return VirtualToken(
      deviceName: json['deviceName'],
      deviceType: json['deviceType'],
      osVersion: json['osVersion'],
      applicationId: json['applicationId'],
      frontCameraSupport: json['frontCameraSupport'],
      fingerprintSupport: json['fingerprintSupport'],
      code: json['code'],
    );
  }
}

class DeviceToken {
  final String token;
  final String usuario;
  final String ativo;

  const DeviceToken({
    required this.token,
    required this.usuario,
    required this.ativo,
  });

  factory DeviceToken.fromJson(Map<String, dynamic> json) {
    return DeviceToken(
      token: json['token'],
      usuario: json['usuario'],
      ativo: json['ativo'],
    );
  }
}
