import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/main.dart';
import 'package:islami/modules/quran/sura_details_screen.dart';
import 'package:islami/modules/quran/verse_widget.dart';
import 'package:islami/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class SuraView extends StatefulWidget {
  static const String routeName = 'SuraView';

  @override
  State<SuraView> createState() => _SuraViewState();
}

class _SuraViewState extends State<SuraView> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/files/quran.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf",
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    var args = ModalRoute.of(context)!.settings.arguments as SuraDetailsArgs;
    return Stack(children: [
      Image.asset(
        provider.isDarkMode()
            ? 'assets/images/main_background_dark.png'
            : 'assets/images/main_background.png',
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      Scaffold(
          appBar: AppBar(
            title: Text(
              args.name,
              style: TextStyle(
                fontFamily: 'DTHULUT',
              ),
            ),
          ),
          body: Center(
            child: _isLoading
    ? Center(child: CircularProgressIndicator())
        : PDFViewer(
    document: document,
    zoomSteps: 1,
    //uncomment below line to preload all pages
    // lazyLoad: false,
    // uncomment below line to scroll vertically
    // scrollDirection: Axis.vertical,

    //uncomment below code to replace bottom navigation with your own
    /* navigationBuilder:
                          (context, page, totalPages, jumpToPage, animateToPage) {
                        return ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                jumpToPage()(page: 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                animateToPage(page: page - 2);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                animateToPage(page: page);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.last_page),
                              onPressed: () {
                                jumpToPage(page: totalPages - 1);
                              },
                            ),
                          ],
                        );
                      }, */
    ),
          ))
    ]);
  }

  // void readSura(int index) async {
  //   String fileName = 'assets/files/${index + 1}.txt';
  //   String fileContent = await rootBundle.loadString(fileName);
  //   // print(fileContent);
  //   List<String> verses = fileContent.split('\n');
  //   ayat = verses;
  //   setState(() {});
  // }

}


