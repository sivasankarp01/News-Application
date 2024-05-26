import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/Models/news_model.dart';
import 'package:newsapplication/Screens/bookmark_screen.dart';
import 'package:newsapplication/Screens/content_screen.dart';
import 'package:newsapplication/cubit/news_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _categories = [
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];
  String _selectedCategory = 'business';
  bool _isLoading = false;
   int _scrollCounter = 0;

  @override
  void initState() {
    super.initState();
    // Fetch articles when the widget is first created
    context.read<NewsCubit>().fetchArticles(_selectedCategory);

    // Add scroll listener for infinite scroll
    _scrollController.addListener(_onScroll);
  }

 void _onScroll() {
  if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
      _scrollCounter < 4) {
    context.read<NewsCubit>().fetchArticles(_selectedCategory, isLoadMore: true);
    _scrollCounter++;
  }
}


  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookMarkPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
              context.read<NewsCubit>().fetchArticles(_selectedCategory);
            },
            items: _categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: BlocConsumer<NewsCubit, List<NewsArticle>>(
              listener: (context, state) {
                _isLoading = false;
              },
              builder: (context, state) {
                if (state.isEmpty && !_isLoading) {
                  return Center(child: Text("No data"));
                } else if (state.isEmpty && _isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.length) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final article = state[index];
                    if (article.title == "[Removed]") {
                      return Container();
                    }
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
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
