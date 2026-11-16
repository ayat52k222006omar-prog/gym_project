import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/admin_view/core/model/user_model.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';

class TerminateController extends GetxController {
  final UserModel user;
  TerminateController(this.user);

  var selectedTab = 1.obs; // 0: Contract ended, 1: Before end date
  var isAdminApproved = false.obs;
  var isStaffApproved = false.obs;
  var terminationMessage = ''.obs;

  void toggleTab(int tab) {
    selectedTab.value = tab;
    terminationMessage.value = '';
  }

  void toggleAdminApproval() {
    isAdminApproved.value = !isAdminApproved.value;
  }

  void toggleStaffApproval() {
    isStaffApproved.value = !isStaffApproved.value;
  }

  void terminateAccount() {
    terminationMessage.value = "Done. ${user.name}'s account is removed and the ${user.currentClientsCount} clients wait to be reassigned.";
  }
}

class TerminateContractPage extends StatelessWidget {
  final UserModel user;
  TerminateContractPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final TerminateController controller = Get.put(TerminateController(user));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.plateBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // الهيدر العلوي
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1D2733), size: 18),
                      ),
                    ),
                    const Text(
                      "Terminate",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2733),
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: Color(0xFF1D2733)),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // كارت بيانات المستخدم
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE3ECEA)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: const Color(0xFFFDE0dc),
                            child: Text(
                              _getInitials(user.name),
                              style: const TextStyle(
                                color: Color(0xFFF4877B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1D2733),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${user.role == UserRole.coach ? 'Coach' : 'Bar worker'} · contract ends 31 Dec 2026",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7886),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF3F3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Obx(() => Text(
                              controller.selectedTab.value == 0 ? "Ended" : "76 days left",
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6B7886),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // أزرار التبديل (Tabs)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3ECEA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() => GestureDetector(
                              onTap: () => controller.toggleTab(0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedTab.value == 0 ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: controller.selectedTab.value == 0 ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [],
                                ),
                                child: Text(
                                  "Contract ended",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: controller.selectedTab.value == 0 ? const Color(0xFF1D2733) : const Color(0xFF6B7886),
                                  ),
                                ),
                              ),
                            )),
                          ),
                          Expanded(
                            child: Obx(() => GestureDetector(
                              onTap: () => controller.toggleTab(1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.selectedTab.value == 1 ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: controller.selectedTab.value == 1 ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [],
                                ),
                                child: Text(
                                  "Before end date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: controller.selectedTab.value == 1 ? const Color(0xFF1D2733) : const Color(0xFF6B7886),
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // محتوى التبويب حسب الاختيار
                    Obx(() {
                      if (controller.selectedTab.value == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "The contract end date has passed, so the account is removed normally. No approval is needed.",
                              style: TextStyle(
                                color: Color(0xFF2E7D59),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => controller.terminationMessage.value.isNotEmpty
                                ? Text(
                                    controller.terminationMessage.value,
                                    style: const TextStyle(
                                      color: Color(0xFF2E7D59),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const SizedBox.shrink()),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // تنبيه تحذيري
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3E7),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFFDE8D0)),
                              ),
                              child: Text(
                                "Ending early needs two approvals: yours and ${user.name.split(' ').first}'s. The account stays active until both are done.",
                                style: const TextStyle(
                                  color: Color(0xFFD97706),
                                  fontSize: 13.5,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Reason",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2733),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: const Color(0xFFE3ECEA)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mutual agreement",
                                    style: TextStyle(
                                      color: Color(0xFF1D2733),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7886)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // الموافقة الأولى (Admin)
                            _buildApprovalCard(
                              step: "1",
                              title: "Admin approval",
                              subtitle: controller.isAdminApproved.value ? "Approved just now" : "Waiting for you",
                              isApproved: controller.isAdminApproved.value,
                              buttonText: controller.isAdminApproved.value ? "Undo" : "Approve",
                              onTap: controller.toggleAdminApproval,
                            ),
                            const SizedBox(height: 12),

                            // الموافقة الثانية (Staff/Coach)
                            _buildApprovalCard(
                              step: "2",
                              title: "${user.name.split(' ').first}'s approval",
                              subtitle: controller.isStaffApproved.value ? "Approved by ${user.name.split(' ').first}" : "Request sent to ${user.name.split(' ').first} · pending",
                              isApproved: controller.isStaffApproved.value,
                              buttonText: controller.isStaffApproved.value ? "Undo" : "Simulate",
                              onTap: controller.toggleStaffApproval,
                            ),

                            const SizedBox(height: 15),
                            Obx(() => controller.terminationMessage.value.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      controller.terminationMessage.value,
                                      style: const TextStyle(
                                        color: Color(0xFF2E7D59),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink()),
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),

              // الزر السفلي لإنهاء العقد
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  bool isBeforeEnd = controller.selectedTab.value == 1;

                  return ElevatedButton(
                    onPressed: () => controller.terminateAccount(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9483B),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isBeforeEnd ? "Terminate contract now" : "Remove account",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApprovalCard({
    required String step,
    required String title,
    required String subtitle,
    required bool isApproved,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3ECEA)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF3F3),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              step,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B7886),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1D2733),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isApproved ? const Color(0xFF2E7D59) : const Color(0xFF6B7886),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: isApproved ? const Color(0xFFCFDCD9) : const Color(0xFF56C5B1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: isApproved ? const Color(0xFF1D2733) : const Color(0xFF2E7D59),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : "?";
  }
}