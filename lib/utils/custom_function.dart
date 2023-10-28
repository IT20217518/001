abstract class CustomFunction {
  static bool isValidName(String value) {
    final trimmedValue = value.trim();
    return trimmedValue.isNotEmpty;
  }

  static bool isValidPassword(String value) {
    final trimmedValue = value.trim();
    return trimmedValue.isNotEmpty;
  }

  static bool isValidOtp(String otp) {
    final regex = RegExp(r'^[0-9]{1}$');
    return regex.hasMatch(otp);
  }
}
