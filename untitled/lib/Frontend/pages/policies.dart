import 'package:flutter/material.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/policy_model.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class Policies extends StatelessWidget {
  final String token;
  const Policies({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return PolicyScreen(
      token: token,
    );
  }
}

class PolicyScreen extends StatefulWidget {
  final String token;
  const PolicyScreen({super.key, required this.token});

  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Policy> _policies = [];
  List<Policy> _filteredPolicies = [];
  bool _isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchPolicy();
    _searchController.addListener(_filterPolicies);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPolicies);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPolicy() async {
    try {
      final List<Policy> data = await apiService.fetchPolicies(widget.token);
      setState(() {
        _policies = data;
        _filteredPolicies = data;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading policy data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterPolicies() {
    setState(() {
      _filteredPolicies = _policies
          .where((policy) => policy.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  // void _filterPolicies() {
  //   setState(() {
  //     _filteredPolicies = _policies
  //         .where((policy) => policy
  //             .toLowerCase()
  //             .contains(_searchController.text.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Policies',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(token: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Policies...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount: _filteredPolicies.length,
            //       itemBuilder: (context, index) {
            //         return PolicyItem(
            //           policyName: _filteredPolicies[index],
            //           onTap: () {
            //             Navigator.pushNamed(context, '/leavePolicy');
            //           },
            //         );
            //       },
            //     ),
            //   ),
            // ],
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _filteredPolicies.length,
                      itemBuilder: (context, index) {
                        return PolicyItem(
                          policyName: _filteredPolicies[index].name,
                          onTap: () {
                            Navigator.pushNamed(context, '/leavePolicy');
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class PolicyItem extends StatelessWidget {
  final String policyName;
  final VoidCallback onTap;

  const PolicyItem({
    Key? key,
    required this.policyName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              policyName,
              style: TextStyle(fontSize: 18),
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
