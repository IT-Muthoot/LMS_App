class ServerURL {
  static String baseurl2 = "http://34.93.248.148/api/";
  static String baseurl = "http://43.205.71.83:7010/api/";
  static String hostKey = "c6968br70b.execute-api.ap-south-1.amazonaws.com";
  static String baseurlLogin = "http://10.85.207.85:8080/api/";
  static String baseurlDashboard = "http://10.85.207.85:8080/api/Dashboard/";

  static getUrl(RequestType RequestTypes) {
    switch (RequestTypes) {
      case RequestType.base:
        return baseurlLogin;

      case RequestType.SendOTP:
        return baseurl2 + RequestType.SendOTP.name;



    }
  }
}

enum RequestType {
  base,

  SendOTP,





}
