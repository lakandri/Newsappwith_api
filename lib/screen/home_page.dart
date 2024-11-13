import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapiapp/model/newschannelheadklinemodel.dart';
import 'package:newsapiapp/screen/view_model/news_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, alJazzera }

class _HomePageState extends State<HomePage> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/category_icon.png',
            ),
          ),
          centerTitle: true,
          title: Center(
            child: Text(
              'News',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedMenu,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (FilterList item) {
                  if (FilterList.bbcNews.name == item.name) {
                    name = 'bbc-news';
                  }
                  if (FilterList.aryNews.name == item.name) {
                    name = 'ary-news';
                  }
                  if (FilterList.alJazzera.name == item.name) {
                    name = 'alJazzera';
                  }
                  setState(() {
                    selectedMenu = item;
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      const PopupMenuItem(
                        value: FilterList.bbcNews,
                        child: Text('BBC News'),
                      ),
                      const PopupMenuItem(
                        value: FilterList.aryNews,
                        child: Text('Ary'),
                      ),
                      const PopupMenuItem(
                        value: FilterList.independent,
                        child: Text('independent'),
                      ),
                      const PopupMenuItem(
                        value: FilterList.bbcNews,
                        child: Text('alJazzera'),
                      ),
                    ])
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: 30,
              child: FutureBuilder<NewsChannelHeadlineModel>(
                  future: newsViewModel.fetchNewChannelHeadlinesApi(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 40,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * .97,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: height * .02,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: spinKit2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 8,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.all(15),
                                        height: height * .22,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * .7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
