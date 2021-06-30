import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/screens/jobSeekerApp/contractsTab/contract_viewmodel.dart';
import 'package:workampus/screens/profile/profile_view.dart';
import 'pending/pendingContract_tab.dart';
import 'ongoing/ongoingContract_tab.dart';
import 'completed/completedContract_tab.dart';
import 'package:workampus/shared/colors.dart';

class ContractJSView extends StatefulWidget {
  const ContractJSView({this.tab, this.initialIndex});
  final int tab;
  final int initialIndex;
  @override
  _ContractJSViewState createState() => _ContractJSViewState();
}

class _ContractJSViewState extends State<ContractJSView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  // List<Contract> _contracts;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 3,
        initialIndex: widget.initialIndex != null ? widget.initialIndex : 1,
        vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContractViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ContractViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          title:
              Text('Contracts', style: TextStyle(fontWeight: FontWeight.w500)),
          leading: Row(
            children: <Widget>[
              SizedBox(width: 15.0),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileView()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 37,
                    width: 37,
                    color: Colors.blue,
                    child: model.currentUser.photoUrl == ''
                        ? Icon(
                            FontAwesomeIcons.user,
                            color: black,
                          )
                        : CachedNetworkImage(
                            imageUrl: model.currentUser.photoUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            unselectedLabelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            labelColor: accentColor,
            unselectedLabelColor: tabBarColor,
            controller: tabController,
            tabs: <Widget>[
              Tab(child: Text("Pending")),
              Tab(child: Text("Ongoing")),
              Tab(child: Text("Completed"))
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: <Widget>[
          PendingContract(),
          OngoingContract(),
          CompletedContract(),
        ]),
      ),
    );
  }
}
