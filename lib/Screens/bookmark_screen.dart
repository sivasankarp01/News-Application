import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/Models/news_model.dart';
import 'package:newsapplication/cubit/news_cubit.dart';

import 'content_screen.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookmark"),),
      body:  BlocBuilder<NewsCubit, List<NewsArticle>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Center(child: Text("No data"));
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final article = state[index];
              if(article.bookmark){
                return Card(
                      child: ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ContentPage(article: article,))),
                      
                        title: Text(article.title.toString()),
                        subtitle: Text(article.description.toString() ?? ""),
                        trailing: IconButton(
                          icon: Icon(
                            article.bookmark ? Icons.bookmark : Icons.bookmark_border,
                          ),
                          onPressed: () {
                            setState(() {
                              context.read<NewsCubit>().toggleBookmark(article);
                            });
                          },
                        ),
                      ),
                    );
              }
              else{
                return Container();
              }
              
            },
          );
        },
      ),
    );
  }
}