import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nmg_assignment/Provider/post_provider.dart';
import 'package:provider/provider.dart';

import '../utils/apputils.dart';

class PostDetailsScreen extends StatefulWidget {
  final String id;
  final String username;
  const PostDetailsScreen({super.key, required this.id, required this.username});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  void initState(){
    final provider = Provider.of<PostProvider>(context, listen: false);
    provider.getSinglePostDataAPI(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<PostProvider>(builder: (BuildContext context, PostProvider value, Widget? child){
          return value.singlePostLoading
              ? getLoadingUI()
              : value.error.isNotEmpty
              ? getErrorUI(value.error)
              : getBodyUI(context);

        },),
      ),
    );
  }
  Widget getBodyUI(BuildContext context){
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Column(
        children: [
          Text("Author Name : ${widget.username!}"),
          Card(
            child: ListTile(
              title: Text(postProvider.singlePostList.title),
              subtitle: Text(postProvider.singlePostList.body),
            ),
          ),
        ],
      ),
    );
  }
  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }
  Widget getLoadingUI() {
    return Center(child: CircularProgressIndicator(),);
  }
}
