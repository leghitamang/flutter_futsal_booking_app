import 'package:flutter/material.dart';
import 'package:nepsal/components/searchModalName.dart';
import 'package:nepsal/components/searchModalPrice.dart';
import 'package:nepsal/models/search.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.search),
      onSelected: (String choice) {
        if (choice == Search.searchByName) {          
          showModalBottomSheet(
              context: (context),
              builder: (context) => SearchModalName(),
            );
        } else if (choice == Search.searchByPrice) {
          showModalBottomSheet(
              context: (context),
              builder: (context) => SearchModalPrice(),
            );
        }
      },
      itemBuilder: (BuildContext context) {
        return Search.choices.map((String choice) {
          return PopupMenuItem(value: choice, child: Text(choice));
        }).toList();
      },
    );
  }

  choiceAction(String choice) {
    if (choice == Search.searchByName) {
      print('Search By Name');
      // showModalBottomSheet(
      //     context: (context),
      //     builder: (context) => SearchModal(),
      //   );
    } else if (choice == Search.searchByPrice) {
      print('Search By Price');
    }
  }
}
