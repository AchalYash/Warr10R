import 'dart:convert';

import 'package:http/http.dart' as http;

class BlockChain  {

  static String apiURL = 'Warr10r.pythonanywhere.com/api/';

  //Todo: To update getDetails
  static Future<List<Map<String, dynamic>>> getDetails(String vialId, String type) async {
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

  static Future<Map<int, String>> addDetails(String id, String sender, String receiver, String type) async {
    Map<int, String> toReturn = {-1: "Failure"};
    var response;

    try{
      var url = Uri.parse('${apiURL}transaction/new');
      var headers = {
        'Content-Type': 'application/json'
      };
      var body = jsonEncode({"id": id, "sender": sender, "receiver": receiver, "type":type});

      response = await http.post(url, body: body, headers: headers);

      if(response.statusCode == 200)  {
        toReturn = {1 : response.body};
      } else  {
        toReturn = {response.statusCode : response.reasonPhrase};
        // print(resp.reasonPhrase);
        // print(resp.statusCode);
      }

    } catch(e){
      print(e);
    }

    return toReturn;
  }


}