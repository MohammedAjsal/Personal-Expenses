import 'package:first_app/model/transaction.dart';
import 'package:first_app/widgets/card.dart';
import 'package:first_app/widgets/new_transaction.dart';
import 'package:first_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(fontFamily: 'OpenSans', fontSize: 60),
              ),
        ),
      ),
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [];
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

// It is the new transaction adding funtion to the declared main transaction list(_userTransaction)

  void _addNewTransaction(String newTitle, double newAmount, DateTime newDate) {
    final newTrans = Transaction(
      id: DateTime.now().toString(),
      title: newTitle,
      amount: newAmount,
      date: newDate,
    );

    setState(() {
      _userTransaction.add(newTrans);
    });
  }

// to take only last 7 days(1 week ) list by return list on the basis of date element.
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

//  To show the input sheet to enter data in to list it locates in main class

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildPotraitContent(AppBar appBar, Widget transactionWidget) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height * .35 -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        child: Chart(_recentTransactions),
      ),
      transactionWidget
    ];
  }

  List<Widget> _buildLandscapeContent(AppBar appBar, Widget transactionWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart"),
          Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height * .7 -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top),
              child: Chart(_recentTransactions),
            )
          : transactionWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final transactionWidget = Container(
      height: (MediaQuery.of(context).size.height * 0.65 -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top),
      child: TransactionList(_userTransaction, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(appBar, transactionWidget),
            if (!isLandscape)
              ..._buildPotraitContent(appBar, transactionWidget),
            // if (!isLandscape) transactionWidget,
            // if (isLandscape)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
