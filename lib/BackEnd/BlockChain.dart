import 'dart:convert';

import 'package:http/http.dart' as http;

class BlockChain  {

  static Future<List<Map<String, dynamic>>> getVialDetails(String vialId) async {
    List<Map<String, dynamic>> vialDetails = [];

    //TODO: Update URL and dataType Names
    String endPoint = 'http://achalapoorvashutosh.pythonanywhere.com/get_vial_info/$vialId';

    try{
      var fetchedDetails = await http.get(Uri.parse(endPoint));
      print(fetchedDetails.body);
      for(Map<String, dynamic> x in jsonDecode(fetchedDetails.body) ) {
        vialDetails.add(x);
      }
    }
    catch(e){
      vialDetails = null;
      print(e);
    }
    return vialDetails;
  }

  static int addVialDetails() {
   return 0;
  }


}