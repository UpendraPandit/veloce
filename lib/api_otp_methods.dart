import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpMethods {
  Future<int> postOtp(
      {required int pilot, required int passenger, required int otp}) async {
    final Uri url = Uri.parse("http://209.38.239.190/otp/postOTP");
    final body = jsonEncode({
      "pilot": pilot,
      "passenger": passenger,
      "otp": otp,
    });
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, body: body, headers: headers);

    return response.statusCode;
  }

  Future<http.Response> validateOtp(
      {required int pilot, required int passenger, required int otp}) async {
    final Uri url = Uri.parse(
        "http://209.38.239.190/otp/validateOTP?pilot=${pilot}&passenger=${passenger}&otp=${otp}");
    var response = await http.get(url);
    return response;
  }

  void deleteOtp(
      {required int pilot, required int passenger, required int otp}) async {
    final Uri url = Uri.parse(
        "http://209.38.239.190/otp/deleteOTP?pilot=${pilot}&passenger=${passenger}&otp=${otp}");
    await http.delete(url);
  }
}
