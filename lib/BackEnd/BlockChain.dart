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

  static Future<Map<int, String>> addVialDetails(String id, String sender, String receiver, DateTime timeStamp) async {
    Map<int, String> toReturn = {-1: "Failure"};
    var response;

    try{
      var url = Uri.parse('http://achalapoorvashutosh.pythonanywhere.com/transactions/new');
      var headers = {
        'Content-Type': 'application/json'
      };
      var body = jsonEncode({"v_id": id,"p_id": receiver,"d_id": sender,"block_index": "0","time": timeStamp.toIso8601String()});

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