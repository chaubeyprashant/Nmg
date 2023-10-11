import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nmg_assignment/Provider/post_provider.dart';
import 'package:nmg_assignment/View/post_details_screen.dart';
import 'package:nmg_assignment/utils/apputils.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    final provider = Provider.of<PostProvider>(context, listen: false);
    provider.getPostDataAPI();
    provider.getAuthorDataAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<PostProvider>(builder: (context, postProvider, child) {
      print(postProvider.postList.toString());
      return postProvider.postLoading
          ? getLoadingUI()
          : postProvider.error.isNotEmpty
              ? getErrorUI(postProvider.error)
              : getBodyUI();
    }));
  }

  Widget getLoadingUI() {
    return const Center(
      child: CircularProgressIndicator(),
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

  Widget getBodyUI() {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return ListView.builder(
      itemCount: postProvider.postList.length,
      itemBuilder: (context, index) {
        String userId = postProvider.postList[index].userId.toString();
        String? userName = AppUtils.getUsername(userId);
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PostDetailsScreen(
                          id: postProvider.postList[index].id.toString(), username: userName ,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Text("Author Name : ${userName!}"),
                Card(
                  child: ListTile(
                    title: Text(postProvider.postList[index].title),
                    subtitle: Text(postProvider.postList[index].body),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
