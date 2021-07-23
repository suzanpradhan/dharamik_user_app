// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:webapp/bloc/news_screen_bloc/news_screen_bloc.dart';
import 'package:webapp/models/news_model.dart';

import 'package:webapp/utils/screen_utils.dart';

class MajorNews extends StatelessWidget {
  final List<NewsModel> news;
  MajorNews(this.news);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(35),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    bottom: 18.0, top: 15.0, left: 10.0, right: 10.0),
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              Image.network(news[index].newsThumbnail).image,
                          radius: ScreenUtil.getInstance().setHeight(100),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            news[index].newsTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: (context.mdWindowSize ==
                                            MobileWindowSize.large ||
                                        context.mdWindowSize ==
                                            MobileWindowSize.xlarge ||
                                        context.mdWindowSize ==
                                            MobileWindowSize.medium)
                                    ? 18
                                    : 15,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      news[index].newsContent,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: news.length),
      ),
    );
  }
}

class MajorNewsScreen extends StatefulWidget {
  @override
  _MajorNewsScreenState createState() => _MajorNewsScreenState();
}

class _MajorNewsScreenState extends State<MajorNewsScreen> {
  NewsScreenBloc newsScreenBloc = NewsScreenBloc();
  NewsModel selectedNewsModel;
  int _index = 0; // for updating state in xsmall and small view

  @override
  void initState() {
    newsScreenBloc.add(GetInitialNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (context.mdWindowSize == MobileWindowSize.small ||
              context.mdWindowSize == MobileWindowSize.xsmall)
          ? Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 6.0,
                    left: 6.0,
                    right: 6.0,
                  ),
                  child: BlocBuilder<NewsScreenBloc, NewsScreenState>(
                    bloc: newsScreenBloc,
                    builder: (context, state) {
                      if (state is NewsScreenLoaded) {
                        return CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Card(
                                    child: Container(
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: Image.network(state
                                                        .newsList[_index]
                                                        .newsThumbnail)
                                                    .image,
                                                fit: BoxFit.cover)),
                                        height: context.screenHeight * 0.3,
                                        child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            color: Colors.black54,
                                            child: Text(state
                                                .newsList[_index].newsTitle))),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 20.0,
                                          color: Colors.grey.shade700,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (_index == 0)
                                              _index =
                                                  state.newsList.length - 1;
                                            else
                                              _index = _index - 1;
                                          });
                                        }),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.0,
                                          color: Colors.grey.shade700,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (_index ==
                                                state.newsList.length - 1)
                                              _index = 0;
                                            else
                                              _index = _index + 1;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 12.0,
                                  right: 10.0,
                                  left: 10.0,
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  state.newsList[_index].newsTitle,
                                  style: TextStyle(
                                      fontSize: (context.mdWindowSize ==
                                                  MobileWindowSize.large ||
                                              context.mdWindowSize ==
                                                  MobileWindowSize.xlarge ||
                                              context.mdWindowSize ==
                                                  MobileWindowSize.medium ||
                                              context.mdWindowSize ==
                                                  MobileWindowSize.small)
                                          ? 55
                                          : 32,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  state.newsList[_index].newsContent,
                                  style: TextStyle(
                                    fontSize: (context.mdWindowSize ==
                                                MobileWindowSize.large ||
                                            context.mdWindowSize ==
                                                MobileWindowSize.xlarge ||
                                            context.mdWindowSize ==
                                                MobileWindowSize.medium ||
                                            context.mdWindowSize ==
                                                MobileWindowSize.small)
                                        ? 16
                                        : 14,
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                                padding: EdgeInsets.symmetric(vertical: 4)),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _index = index;
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                    leading: Image.network(
                                        state.newsList[index].newsThumbnail),
                                    title:
                                        Text(state.newsList[index].newsTitle),
                                  ),
                                ),
                              );
                            }, childCount: state.newsList.length - 1))
                          ],
                        );
                      } else
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                    },
                  ),
                ),
              ),
            )
          : Row(
              children: <Widget>[
                // getCollapsingSideBar(),
                Expanded(
                    flex: 2,
                    child: (selectedNewsModel == null)
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Container(
                                    child: Image.network(
                                        selectedNewsModel.newsThumbnail),
                                    decoration: BoxDecoration(
                                      //color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                    padding: EdgeInsets.symmetric(vertical: 8)),
                                SliverToBoxAdapter(
                                  child: Text(
                                    selectedNewsModel.newsTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 50,
                                            color: Colors.white),
                                  ),
                                ),
                                SliverPadding(
                                    padding: EdgeInsets.symmetric(vertical: 8)),
                                SliverToBoxAdapter(
                                  child: Text(
                                    selectedNewsModel.newsDesc,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                SliverPadding(
                                    padding: EdgeInsets.symmetric(vertical: 6)),
                                SliverToBoxAdapter(
                                  child: Text(
                                    selectedNewsModel.newsContent,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                )
                              ],
                            ),
                          )),
                Expanded(
                    child: BlocConsumer<NewsScreenBloc, NewsScreenState>(
                        bloc: newsScreenBloc,
                        listener: (context, state) {
                          if (state is NewsScreenLoaded)
                            setState(() {
                              this.selectedNewsModel = state.newsList[0];
                            });
                        },
                        builder: (context, state) {
                          if (state is NewsScreenLoaded) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                children: [
                                  Text(
                                    'More News',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Expanded(
                                    child: CustomScrollView(slivers: <Widget>[
                                      SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                              (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, right: 20, left: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    this.selectedNewsModel =
                                                        state.newsList[index];
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(12.0),
                                                  // width: 450,
                                                  // height: 300,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade900,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                Image.network(state
                                                                        .newsList[
                                                                            index]
                                                                        .newsThumbnail)
                                                                    .image,
                                                            radius: ScreenUtil
                                                                    .getInstance()
                                                                .setHeight(100),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              state
                                                                  .newsList[
                                                                      index]
                                                                  .newsTitle,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 19,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        state.newsList[index]
                                                            .newsDesc,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),

                                                  //Center(child: Text('News Content')),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        );
                                      }, childCount: state.newsList.length))
                                    ]),
                                  ),
                                ],
                              ),
                            );
                          } else
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            );
                        })),
              ],
            ),
    );
  }
}
