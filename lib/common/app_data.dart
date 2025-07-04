import 'package:esalesapp/models/user/user_model.dart';

class AppData {
  static String userName = "";
  static String userid = "";
  static String userCabang = "";
  static String userToken = "";
  static String personId = "";
  static String personName = "";
  static bool hasDownline = false;
  static int chatRefresh = 10;
  static bool kIsWeb = false;
  static User user = User();
  static var uriHtpp = useSSL ? Uri.https : Uri.http;
  static String version = "1.0.2";


  static bool useSSL = false;
  static String apiDomain = "http://10.0.2.2/eSalesAPI/";
  static String prefixEndPoint = "/eSalesAPI";
  static String httpAuthority = "10.0.2.2";



/*
static bool useSSL = false;
static String apiDomain = "http://localhost/eSalesAPI/";
static String prefixEndPoint = "/eSalesAPI";
static String httpAuthority = "localhost";
*/

/*
static bool useSSL = false;
static String apiDomain = "http${useSSL ? "s" : ""}://216.172.109.8/esalesapi/";
static String prefixEndPoint = "/esalesapi";
static String httpAuthority = "216.172.109.8";
*/


/*
  static bool useSSL = true;
  static String apiDomain =
      "http${useSSL ? "s" : ""}://eplannerdevapi.smartsoft-id.com/";
  static String prefixEndPoint = "";
  static String httpAuthority = "eplannerdevapi.smartsoft-id.com";
*/


  /*
  static bool useSSL = true;
  static String apiDomain = "http${useSSL ? "s" : ""}://esalesapi.smartsoft-id.com/";
  static String prefixEndPoint = "";
  static String httpAuthority = "esalesapi.smartsoft-id.com";
  */

  static Map<String, String> httpHeaders = <String, String>{
    'Content-Type': 'application/json; odata=verbos',
    'Accept': 'application/json; odata=verbos',
    'Authorization': 'Bearer ${AppData.userToken}'
  };

  static String endPointDownloadPolisFile = "api/polis/polisview/getfile/";
  static String endPointViewJobRealImage = "api/jobreal/jobrealcrud/download/";
}
