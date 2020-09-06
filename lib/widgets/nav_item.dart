import 'package:flutter/material.dart';
import 'package:mobizil_app/pojo/navigation_item.dart';

class BuildNavItem extends StatelessWidget {
  
  final NavigationItem item;
  final bool isSelected;

  BuildNavItem(this.item, this. isSelected);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 45,
      margin: EdgeInsets.only(right: 5),
      width: isSelected ? MediaQuery.of(context).size.width / 3 : 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      padding:
          isSelected ? EdgeInsets.symmetric(horizontal: 20) : EdgeInsets.all(0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                    color: isSelected
                        ? Theme.of(context).textSelectionColor
                        : Colors.black,
                    size: 30),
                child: item.icon,
              ),
              SizedBox(width: 10),
              isSelected
                  ? DefaultTextStyle(
                      style: TextStyle(color: Colors.white),
                      child: item.title,
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
