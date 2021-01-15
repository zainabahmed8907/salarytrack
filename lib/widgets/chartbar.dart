import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  //const Chartbar({Key key}) : super(key: key);
  final String label;
  final double spendingAmount;
  final double spendingTotal;

  Chartbar(this.label, this.spendingTotal, this.spendingAmount);
  @override
  Widget build(BuildContext context) {
    Container(
      height: 5,
    child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}')));
    SizedBox(
      height: 20.0,
    );

    Container(
      height: 60,
      width: 30,
      child: Stack(
        children: <Widget>[
          Container(decoration: BoxDecoration(
            border: Border.all(color: Colors.purple[700],width: 1.0),
            color: Colors.purpleAccent[100],
            borderRadius: BorderRadius.circular(10)

          ),
          ),
            FractionallySizedBox(
            heightFactor: spendingTotal,
            child: Container(
              decoration: BoxDecoration(
            border: Border.all(color: Colors.purple[700],width: 1.0),
            color: Colors.purpleAccent[100],
            borderRadius: BorderRadius.circular(10)
            ),
            
          )
        
            ),
        ],
      ),
    );
    
    SizedBox(
      height: 20.0,
    );

  }
}
