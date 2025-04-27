import 'package:universal_html/html.dart' as html;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class CookieManager {
  static const String cookiePrefix = "esales_";
  static const int defaultDays = 7;

  static final key = encrypt.Key.fromUtf8('12345678901234567890123456789012'); // 32 chars
  static final iv = encrypt.IV.fromUtf8('1234567890123456'); // 16 chars
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static String _formatExpires(DateTime dateTime) {
    final weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][dateTime.weekday % 7];
    final month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][dateTime.month - 1];
    return "${weekday}, ${dateTime.day.toString().padLeft(2, '0')} ${month} ${dateTime.year} "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}:"
        "${dateTime.second.toString().padLeft(2, '0')} GMT";
  }

  static void setCookie(String key, String value, {bool remember = false}) {
    final expires = remember
        ? _formatExpires(DateTime.now().add(Duration(days: defaultDays)).toUtc())
        : null;

    final encrypted = encrypter.encrypt(value, iv: iv).base64;
    String cookieString = "$cookiePrefix$key=${Uri.encodeComponent(encrypted)}; path=/";

    if (expires != null) {
      cookieString += "; expires=$expires";
    }

    html.document.cookie = cookieString;
  }

  static String? getCookie(String key) {
    final cookies = html.document.cookie?.split("; ") ?? [];
    for (var cookie in cookies) {
      if (cookie.startsWith("$cookiePrefix$key=")) {
        final encrypted = Uri.decodeComponent(cookie.substring("$cookiePrefix$key=".length));
        try {
          return encrypter.decrypt64(encrypted, iv: iv);
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  static void deleteCookie(String key) {
    html.document.cookie = "$cookiePrefix$key=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
  }

  static void clearAll() {
    final cookies = html.document.cookie?.split("; ") ?? [];
    for (var cookie in cookies) {
      if (cookie.startsWith(cookiePrefix)) {
        final key = cookie.split("=")[0].substring(cookiePrefix.length);
        deleteCookie(key);
      }
    }
  }
}
