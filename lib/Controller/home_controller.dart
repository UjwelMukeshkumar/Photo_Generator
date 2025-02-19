import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  Uint8List? imageData;

  bool isLoading = false;
  bool searchChanging = false;

  void loadingUpdate(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void searchUpdate(bool val) {
    searchChanging = val;
    notifyListeners();
  }

  TextEditingController textController = TextEditingController();
  Future<void> textToImage(String textController, BuildContext context) async {
    String engineid = "stable-diffusion-v1-6";
    String apihost = 'https://api.stability.ai';
    String apikey = "sk-TYekrZ4mVpcdxr5I8nBy5tkcoHBkBd8yrSjb3vRRFPq70fAG";

    final response = await http.post(
        Uri.parse('$apihost/v1/generation/$engineid/text-to-image'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'image/png',
          'Authorization': 'Bearer $apikey'
        },
        body: jsonEncode({
          "text_prompts": [
            {"text": textController, "weight": 1},
          ],
          "cfg_scale": 7,
          "height": 1024,
          "width": 1024,
          "samples": 1,
          "steps": 30,
        }));

    if (response.statusCode == 200) {
      imageData = response.bodyBytes;
      loadingUpdate(false);
      searchUpdate(true);
      notifyListeners();
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}
