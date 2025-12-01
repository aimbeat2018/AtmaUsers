import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/appointment_request.dart';

class AppointmentListScreen extends StatefulWidget {
  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {



  // Example controller data
  final List<Map<String, dynamic>> appointmentList = [
    {
      "_id": "6927fd8bf72a87ee06209019",
      "note": "Testing Request",
      "appointmentDate": "26-11-2025",
      "status": "pending",
      "kiosk": {
        "hospital_name": "ATMA 4 You Metabolic Clinics- Kandivali",
        "flat_no": "4/5 A",
        "lane_road": "SHIVAJI ROAD",
        "near_by": "THAKUR INTERNATIONAL SCHOOL",
        "pincode": 400067
      }
    },
    {
      "_id": "6927fd8bf72a87ee06209020",
      "note": "Follow-up Check",
      "appointmentDate": "30-11-2025",
      "status": "approved",
      "kiosk": {
        "hospital_name": "City Health Hospital",
        "flat_no": "12-B",
        "lane_road": "MG Road",
        "near_by": "City Park",
        "pincode": 400012
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("میری درخواست", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: appointmentList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final item = appointmentList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Hospital Name
                  Row(
                    children: [
                      Icon(Icons.local_hospital, color: Colors.blue, size: 28),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item['kiosk']['hospital_name'] ?? "",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  /// Address
                  Text(
                    "${item['kiosk']['flat_no']}, ${item['kiosk']['lane_road']}, ${item['kiosk']['near_by']}, ${item['kiosk']['pincode']}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),

                  SizedBox(height: 12),

                  /// Appointment Date
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "تاریخ: ${item['appointmentDate']}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  /// Note
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.notes, color: Colors.orange),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "نوٹ: ${item['note']}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// Status Chip
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: item['status'] == "pending"
                            ? Colors.orange.shade100
                            : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['status'] == "pending" ? "زیرِ التواء" : "منظور شدہ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: item['status'] == "pending"
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
