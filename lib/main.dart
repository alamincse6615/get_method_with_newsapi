import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/details.dart';
import 'package:helloworld/helper/articlehelper.dart';
import 'package:helloworld/model/articles.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  List<Articles> _artcleslist = <Articles>[];
  int a = 0;


  @override
  void initState() {
    articleAllData();
  }

  articleAllData()async{

    ArticleHelper articleHelper = ArticleHelper();
    await articleHelper.getArticles();
    setState(() {
      _artcleslist = articleHelper.articleList;
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 50,
                itemBuilder: (context,index){
                a=index+1;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*.20,
                          width: 170,
                          child: Image.network(

                            "https://www.thehotelguru.com/_images/74/8f/748f7d98635434ad6e25d2e52bb97d21/rio-de-janeiro-s1180x560.jpg",
                            fit: BoxFit.fill,

                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*.20,
                          alignment: Alignment.center,
                          width: 170,
                          child: Text(
                              "$a",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white
                            ),
                          )
                          ),
                      ],
                    ),
                  );
                }
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*.64,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _artcleslist.length,
                itemBuilder: (context,index){
                a=index+1;
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*.25,
                                  color: Colors.black26,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    _artcleslist[index].urlToImage.toString(),
                                    fit: BoxFit.fill,

                                  ),
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height*.25,
                                    width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,

                                  child: Text(
                                  _artcleslist[index].author.toString(),
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white
                                    ),
                                  )
                                  ),
                                Container(
                                    height: MediaQuery.of(context).size.height*.25,
                                    width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.bottomRight,

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _artcleslist[index].publishedAt.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  )
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            _artcleslist[index].title.toString(),
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            _artcleslist[index].description.toString(),                        style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>Details(
                              _artcleslist[index].url.toString(),
                            )
                        )
                      );
                    },
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
