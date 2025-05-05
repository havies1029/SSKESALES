import 'package:universal_html/html.dart' as html;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class CookieManager {
  static const String cookiePrefix = "esales_";
  static const int defaultDays = 7;

  static final encrypt.Key _key =
  encrypt.Key.fromUtf8('12345678901234567890123456789012'); // 32 chars
  static final encrypt.IV _iv =
  encrypt.IV.fromUtf8('1234567890123456'); // 16 chars
  static final encrypt.Encrypter _encrypter =
  encrypt.Encrypter(encrypt.AES(_key));

  static String _formatExpires(DateTime dateTimeUtc) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    final weekday = weekdays[dateTimeUtc.weekday % 7];
    final month = months[dateTimeUtc.month - 1];

    return "$weekday, ${dateTimeUtc.day.toString().padLeft(2, '0')} $month ${dateTimeUtc.year} "
        "${dateTimeUtc.hour.toString().padLeft(2, '0')}:"
        "${dateTimeUtc.minute.toString().padLeft(2, '0')}:"
        "${dateTimeUtc.second.toString().padLeft(2, '0')} GMT";
  }

  static void setCookie(String key, String? value, {bool remember = false}) {
    if (value == null || value.trim().isEmpty) {
      print("⛔ Skipping cookie '$key' because value is empty.");
      return;
    }

    try {
      final encrypted = _encrypter.encrypt(value, iv: _iv).base64;
      final expires = remember
          ? "; expires=${_formatExpires(DateTime.now().add(Duration(days: defaultDays)).toUtc())}"
          : "";

      html.document.cookie =
      "$cookiePrefix$key=${Uri.encodeComponent(encrypted)}; path=/$expires";

    } catch (e) {
      print("❌ Error setting cookie '$key': $e");
    }
  }

  static String? getCookie(String key) {
    try {
      final cookies = html.document.cookie?.split("; ") ?? [];
      final searchKey = "$cookiePrefix$key=";

      for (final cookie in cookies) {
        if (cookie.startsWith(searchKey)) {
          final encrypted = Uri.decodeComponent(cookie.substring(searchKey.length));
          return _encrypter.decrypt64(encrypted, iv: _iv);
        }
      }
    } catch (e) {
      print("❌ Error reading cookie '$key': $e");
    }
    return null;
  }

  static void deleteCookie(String key) {
    html.document.cookie =
    "$cookiePrefix$key=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
  }

  static void clearAll() {
    final cookies = html.document.cookie?.split("; ") ?? [];

    for (final cookie in cookies) {
      if (cookie.startsWith(cookiePrefix)) {
        final cookieKey = cookie.split("=")[0].substring(cookiePrefix.length);
        deleteCookie(cookieKey);
      }
    }
  }
}
