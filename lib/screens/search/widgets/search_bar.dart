import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class SearchBar extends StatefulWidget {
  final Function onChange;
  SearchBar({this.onChange});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool hasValue;
  final txtSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    hasValue = false;
  }

  @override
  void dispose() {
    super.dispose();
    txtSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 50.0,
      child: TextFormField(
        controller: txtSearch,
        autofocus: true,
        onChanged: (value) {
          widget.onChange(txtSearch.text);
          if (value != '') {
            setState(() {
              hasValue = true;
            });
          } else {
            setState(() {
              hasValue = false;
            });
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            hintText: 'Search...',
            suffixIcon: InkWell(
              onTap: () {
                if (hasValue == true) {
                  txtSearch.clear();
                  setState(() {
                    hasValue = false;
                  });
                }
              },
              child: hasValue ? LineIcon.times() : LineIcon.search(),
            )),
      ),
    );
  }
}
