import 'package:flutter/material.dart';

class RandomCocktail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: Expanded(
        child: ListView.separated(
          physics: PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {},
        ),
      ),
    );
  }
}
