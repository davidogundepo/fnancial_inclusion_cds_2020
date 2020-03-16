import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../about_menu_details_pages/about_app.dart';
import '../about_menu_details_pages/about_nysc_rivers.dart';
import '../about_menu_details_pages/acronyms_meanings.dart';
import '../about_menu_details_pages/who_we_are.dart';
import '../api/batch_a_stream_one_api.dart';
import '../bloc_navigation_bloc/navigation_bloc.dart';
import '../details_pages/batch_a_stream_one_details_page.dart';
import '../notifier/batch_a_stream_one_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyBatchAStreamOnePage extends StatefulWidget with NavigationStates {

  MyBatchAStreamOnePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyBatchAStreamOnePageState createState() => _MyBatchAStreamOnePageState();
}

class _MyBatchAStreamOnePageState extends State<MyBatchAStreamOnePage> {

  Widget _buildProductItem(BuildContext context, int index) {
    BatchAStreamOneNotifier batchAStreamOneNotifier = Provider.of<BatchAStreamOneNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),color: Colors.black.withAlpha(50),
        ),

        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blue,
            onTap: () {
              batchAStreamOneNotifier.currentBatchAStreamOne = batchAStreamOneNotifier.batchAStreamOneList[index];
              navigateToBatchAStreamOneDetailsPage(context);
            },

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              batchAStreamOneNotifier.batchAStreamOneList[index].image
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                            batchAStreamOneNotifier.batchAStreamOneList[index].name,
                            style: GoogleFonts.tenorSans(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                            '@'+batchAStreamOneNotifier.batchAStreamOneList[index].twitter,
                            style: GoogleFonts.varela(
                                color: Colors.white70,
                                fontStyle: FontStyle.italic
                            )
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Come on!'),
        content: Text('Do you really really want to?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Oh No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('I Have To'),
          ),
        ],
      ),
    ) ??
        false;
  }

  Future navigateToBatchAStreamOneDetailsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => BatchAStreamOneDetailsPage()));
  }
  Future navigateToAboutAppDetailsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutAppDetails()));
  }
  Future navigateToAcronymsMeaningsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AcronymsMeanings()));
  }
  Future navigateToAboutNYSCRiversState(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutNYSCRiversState()));
  }
  Future navigateToWhoWeArePage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WhoWeAre()));
  }


  @override
  void initState() {
    BatchAStreamOneNotifier batchAStreamOneNotifier = Provider.of<BatchAStreamOneNotifier>(context, listen: false);
    getBatchAStreamOne(batchAStreamOneNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BatchAStreamOneNotifier batchAStreamOneNotifier = Provider.of<BatchAStreamOneNotifier>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(86, 158, 128, 1),
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(MdiIcons.bandage,
                        color: Colors.white,),
                      onPressed: () async {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(46, 137, 112, 1),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Color.fromRGBO(46, 137, 112, 1),
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                          leading: new Icon(MdiIcons.atom, color: Colors.white),
                                          title: new Text('Who We Are',
                                            style: GoogleFonts.zillaSlab(
                                                color: Colors.white
                                            ),),
                                          onTap: () {
                                            navigateToWhoWeArePage(context);
                                          }
                                      ),
                                      ListTile(
                                        leading: new Icon(MdiIcons.chessQueen, color: Colors.white),
                                        title: new Text('About NYSC Rivers State',
                                          style: GoogleFonts.zillaSlab(
                                              color: Colors.white
                                          ),),
                                        onTap: () {
                                          navigateToAboutNYSCRiversState(context);
                                        },
                                      ),
                                      ListTile(
                                          leading: new Icon(MdiIcons.sortAlphabeticalAscending, color: Colors.white),
                                          title: new Text('Acronym Meanings',
                                            style: GoogleFonts.zillaSlab(
                                                color: Colors.white
                                            ),),
                                          onTap: () {
                                            navigateToAcronymsMeaningsPage(context);
                                          }
                                      ),
                                      ListTile(
                                        leading: new Icon(MdiIcons.opacity, color: Colors.white),
                                        title: new Text('About App',
                                          style: GoogleFonts.zillaSlab(
                                              color: Colors.white
                                          ),),
                                        onTap: () {
                                          navigateToAboutAppDetailsPage(context);
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  ],
                  backgroundColor: Color.fromRGBO(46, 137, 112, 1),
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Batch A Stream One Corpers",
                        style: GoogleFonts.amaticSC(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    background: Image.asset('assets/images/hallel_13.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 25, right: 10),
              child: Container(
                margin: new EdgeInsets.only( bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ListView.builder(
                  itemBuilder: _buildProductItem,
                  itemCount: batchAStreamOneNotifier.batchAStreamOneList.length,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}