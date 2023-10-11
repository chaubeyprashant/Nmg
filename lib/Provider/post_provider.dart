import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nmg_assignment/Model/posts_model.dart';
import 'package:nmg_assignment/Services/api_endpoints.dart';
import '../Model/authers_model.dart';
class PostProvider extends ChangeNotifier {

  bool postLoading = true;
  late bool singlePostLoading;
  bool authorLoading = true;
  String error = '';
  List<PostsModel> postList = [];
  late PostsModel singlePostList;
  List<AuthorsModel> authorList = [];
  String searchText = '';
  
  getPostDataAPI() async {
    try {
      Response response = await http.get(Uri.parse(AppUrl.post));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for(Map i in data){
          postList.add(PostsModel.fromJson(i));
        }
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    postLoading = false;
    notifyListeners();
  }
  getSinglePostDataAPI(String id) async {
    singlePostLoading = true;
    notifyListeners();

    try {
      Response response = await http.get(Uri.parse("${AppUrl.post}/$id"), headers: {'Cache-Control': 'no-cache'},);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        singlePostList = PostsModel.fromJson(data);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    singlePostLoading = false;
    notifyListeners();
  }
  getAuthorDataAPI() async {
    try {
      Response response = await http.get(Uri.parse(AppUrl.users));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for(Map i in data){
          authorList.add(AuthorsModel.fromJson(i));
        }
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    authorLoading = false;
    notifyListeners();
  }


}