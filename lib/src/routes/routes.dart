import 'package:flutter/material.dart';

import 'package:challenge_03/src/pages/home.dart';
import 'package:challenge_03/src/pages/search.dart';


Map<String, WidgetBuilder> getAplicationRoutes(){

  return <String, WidgetBuilder> {
        'home'                  : (BuildContext context) => const HomePage(),
        'search'                  : (BuildContext context) => const SearchPage(),

      };

}
