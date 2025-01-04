import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom/no_data_found/no_data_found.dart';
import '../../../custom/waveClipper/wave_clipper.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/constant.dart';
import '../../../utils/enums.dart';
import '../../../utils/shimmers.dart';
import '../controller/membership_controller.dart';

/// =================== List View =================== ///
class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipController>(
      id: Constant.idProgressView,
      builder: (logic) {
        return logic.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    width: 450,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background Wave
                        Positioned(
                          bottom: 0,
                          child: ClipPath(
                            clipper: WaveClipper(),
                            child: Container(
                              height: 80,
                              width: 350,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo and Header
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Logo Section
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Any\nTime\nMedical\nAssistance",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  // Main Title
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ATMA PRIME",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Healthcare",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              // User Name and Club Info
                              Text(
                                "RAM",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ATMA ‘SMART’ Club",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Metabolic Health Warrior",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Spacer(),
                              // Footer Info
                              //changed to column from row
                              Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 16),
                                      SizedBox(width: 5),
                                      Text("9167279733",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.web, size: 16),
                                      SizedBox(width: 5),
                                      Text(
                                        "www.atmaprimehealthcare.com",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.email, size: 16),
                                      SizedBox(width: 5),
                                      Text("atmamembership@gmail.com",
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
      },
    );
  }
}
