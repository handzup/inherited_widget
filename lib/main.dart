import 'package:flutter/material.dart';

void main() {
  // runApp(MaterialApp(home: MyTree()));
  runApp(MyApp());
}

// class Item {
//   String reference;

//   Item(this.reference);
// }

// class _MyInherited extends InheritedWidget {
//   _MyInherited({
//     Key? key,
//     required Widget child,
//     required this.data,
//   }) : super(key: key, child: child);

//   final MyInheritedWidgetState data;

//   @override
//   bool updateShouldNotify(_MyInherited oldWidget) {
//     return true;
//   }
// }

// class MyInheritedWidget extends StatefulWidget {
//   MyInheritedWidget({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   final Widget child;

//   @override
//   MyInheritedWidgetState createState() => new MyInheritedWidgetState();

//   static MyInheritedWidgetState of(BuildContext context) {
//     return (context.dependOnInheritedWidgetOfExactType<_MyInherited>() as _MyInherited).data;
//   }
// }

// class MyInheritedWidgetState extends State<MyInheritedWidget> {
//   /// List of Items
//   List<Item> _items = <Item>[];

//   /// Getter (number of items)
//   int get itemsCount => _items.length;

//   /// Helper method to add an Item
//   void addItem(String reference) {
//     setState(() {
//       _items.add(new Item(reference));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new _MyInherited(
//       data: this,
//       child: widget.child,
//     );
//   }
// }

// class MyTree extends StatefulWidget {
//   @override
//   _MyTreeState createState() => new _MyTreeState();
// }

// class _MyTreeState extends State<MyTree> {
//   @override
//   Widget build(BuildContext context) {
//     return new MyInheritedWidget(
//       child: new Scaffold(
//         appBar: new AppBar(
//           title: new Text('Title'),
//         ),
//         body: new Column(
//           children: <Widget>[
//             new WidgetA(),
//             new Container(
//               child: new Row(
//                 children: <Widget>[
//                   new Icon(Icons.shopping_cart),
//                   new WidgetB(),
//                   new WidgetC(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WidgetA extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final MyInheritedWidgetState state = MyInheritedWidget.of(context);
//     return new Container(
//       child: new RaisedButton(
//         child: new Text('Add Item'),
//         onPressed: () {
//           state.addItem('new item');
//         },
//       ),
//     );
//   }
// }

// class WidgetB extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final MyInheritedWidgetState state = MyInheritedWidget.of(context);
//     return new Text('${state.itemsCount}');
//   }
// }

// class WidgetC extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Text('I am Widget C');
//   }
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyStateApp(),
      );
}

class MyStateApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyStateApp> {
  int _counter = 0;

  int get count => _counter;
  void updateCount() {
    _counter++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: MyInheritedWidgetWrapper(
          child: Column(
            children: [
              WidgetA(),
              const SizedBox(height: 12),
              WidgetC(),
              const SizedBox(height: 12),
              WidgetB(),
            ],
          ),
        ),
      );
}

class _Inherited extends InheritedWidget {
  _Inherited({required this.state, required Widget child}) : super(child: child);
  final MyInheritedWidgetWrapperState state;
  @override
  bool updateShouldNotify(_Inherited oldWidget) => true;
  static MyInheritedWidgetWrapperState ofState(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_Inherited>()!.state;
}

class MyInheritedWidgetWrapper extends StatefulWidget {
  final Widget child;
  static MyInheritedWidgetWrapperState of(BuildContext context) {
    return context.findAncestorStateOfType<MyInheritedWidgetWrapperState>()!;
  }

  const MyInheritedWidgetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  MyInheritedWidgetWrapperState createState() => MyInheritedWidgetWrapperState();
}

class MyInheritedWidgetWrapperState extends State<MyInheritedWidgetWrapper> {
  int _counter = 0;

  int get count => _counter;
  void updateCount() {
    _counter++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('set State $_counter');
    return _Inherited(
      state: this,
      child: widget.child,
    );
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('widget a');

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ColoredBox(
        color: Colors.red,
        child: Text('${_Inherited.ofState(context).count}'),
      ),
    );
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('widget c');
    return Container(color: Colors.black, height: 200, width: double.infinity);
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('widget b');

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ColoredBox(
          color: Colors.yellow,
          child: IconButton(
              onPressed: () {
                _Inherited.ofState(context).updateCount();
              },
              icon: Icon(Icons.ac_unit))),
    );
  }
}
