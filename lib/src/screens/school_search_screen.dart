import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/models/school.dart';
import 'package:skooleo/src/providers/school_provider.dart';

import '../routes.dart';

class SchoolSearchScreen extends StatefulWidget {
  @override
  _SchoolSearchScreenState createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolSearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Schools',
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => SchoolProvider(),
        child: Consumer<SchoolProvider>(
          builder: (context, model, child) => SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: SvgPicture.asset(
                      'assets/svgs/search.svg',
                      height: 100,
                    ),
                  ),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'School Name',
                        hintText: 'e.g ABC School',
                        helperText:
                            'Enter 3 or more characters to begin search',
                      ),
                    ),
                    suggestionsCallback: (String pattern) async {
                      if (pattern.length >= 3)
                        return await model.searchSchools(pattern);
                      return null;
                    },
                    onSuggestionSelected: (suggestion) {
                      _searchController.text = suggestion?.text;
                      Navigator.of(context).pushNamed(
                        SCHOOL_FEE_SCREEN,
                        arguments: suggestion?.id?.toString(),
                      );
                    },
                    itemBuilder: (BuildContext context, School school) {
                      return ListTile(
                        leading: Icon(Icons.school),
                        title: Text(school.text),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
