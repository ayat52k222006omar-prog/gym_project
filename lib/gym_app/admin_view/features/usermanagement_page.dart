import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/admin_view/features/add_user_page.dart';
import 'package:myfirstapp/gym_app/admin_view/features/gym&bar_page.dart';
import 'package:myfirstapp/gym_app/admin_view/features/overview_page.dart';
import 'package:myfirstapp/gym_app/admin_view/core/user_controller.dart';
import 'package:myfirstapp/gym_app/admin_view/core/model/user_model.dart';
import 'package:myfirstapp/gym_app/admin_view/features/terminate_contract_page.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';

class UsersManagementPage extends StatelessWidget {
  UsersManagementPage({super.key});

  final UsersController controller = Get.put(UsersController());

  final List<String> filterChips = [
    'All',
    'Coachs',
    'Bar workers',
    'Clients',
    'Admins',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // المحتوى الأساسي للصفحة
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.plateBackground,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // 1. الهيدر العلوي (زر القائمة + العنوان + عدد الناس)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        // 🎯 زر القائمة الجانبية
                        GestureDetector(
                          onTap: () => controller.toggleDrawer(),
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
                            child: const Icon(
                              Icons.menu,
                              color: Color(0xFF1D2733),
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Users",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D2733),
                            ),
                          ),
                        ),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF3F3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${controller.users.length} people",
                              style: const TextStyle(
                                color: Color(0xFF6B7886),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. شريط الفلاتر الأفقية
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filterChips.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final chipLabel = filterChips[index];
                        return Obx(() {
                          final isSelected =
                              controller.selectedRoleFilter.value == chipLabel;
                          return GestureDetector(
                            onTap: () => controller.changeRoleFilter(chipLabel),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF56C5B1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.transparent
                                      : const Color(0xFFCFDCD9),
                                ),
                              ),
                              child: Text(
                                chipLabel,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF1D2733),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 3. مربع البحث
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (val) => controller.updateSearchQuery(val),
                      decoration: InputDecoration(
                        hintText: "Search by name or phone",
                        hintStyle: const TextStyle(
                          color: Color(0xFF8C98A4),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFCFDCD9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFCFDCD9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFF56C5B1),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 4. قائمة المستخدمين
                  Expanded(
                    child: Obx(() {
                      final list = controller.filteredUsers;
                      if (list.isEmpty) {
                        return const Center(
                          child: Text(
                            "No users found.",
                            style: TextStyle(
                              color: Color(0xFF6B7886),
                              fontSize: 15,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final user = list[index];
                          return _buildUserCard(context, user);
                        },
                      );
                    }),
                  ),

                  // 5. زر إضافة مستخدم (+ Add user)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() => AddUserPage());
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 22,
                      ),
                      label: const Text(
                        "Add user",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4877B),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🎯 القائمة الجانبية (Drawer Menu)
          Obx(() {
            if (!controller.isDrawerOpen.value) return const SizedBox.shrink();
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => controller.toggleDrawer(),
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 300,
                    height: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 52, 16, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Inter',
                            ),
                            children: [
                              TextSpan(
                                text: "PLATE ",
                                style: TextStyle(color: Color(0xFF1D2733)),
                              ),
                              TextSpan(
                                text: "Admin",
                                style: TextStyle(color: Color(0xFFF4877B)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE3ECEa)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDE0dc),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "DK",
                                  style: TextStyle(
                                    color: Color(0xFFF4877B),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dr. Khaled",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Zamalek Club · Admin",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF6B7886),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDrawerItem(
                          icon: Icons.dashboard_outlined,
                          title: "Overview",
                          isSelected: false,
                          onTap: () {
                            controller.toggleDrawer();
                            Get.to(() => AdminOverviewPage());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.group_outlined,
                          title: "User Management",
                          isSelected: true,
                          onTap: () {
                            controller.toggleDrawer();
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.person_outline,
                          title: "Gym Occupancy",
                          isSelected: false,
                          onTap: () {},
                        ),
                        _buildDrawerItem(
                          icon: Icons.local_bar_outlined,
                          title: "Gym & Bar",
                          isSelected: false,
                          onTap: () {
                            controller
                                .toggleDrawer(); // لإغلاق القائمة الجانبية أولاً
                            Get.to(() => GymBarPage());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.local_offer_outlined,
                          title: "Price History",
                          isSelected: false,
                          onTap: () {},
                        ),
                        _buildDrawerItem(
                          icon: Icons.credit_card_outlined,
                          title: "Subscriptions & Policies",
                          isSelected: false,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  /// النص الفرعي المخصص: لو كوتش بيعرض معاه كام كلاينت وباقي كام مكان فاضي
  String _getUserSubtitle(UserModel user) {
    if (user.role == UserRole.coach) {
      return '${user.specialization ?? "Coach"} · ${user.currentClientsCount} clients · ${user.remainingCapacity} spots left';
    }
    return user.summarySubtitle;
  }

  /// كارت المستخدم الواحد
  Widget _buildUserCard(BuildContext context, UserModel user) {
    final bool isExpiring = user.status == AccountStatus.expiring;

    return GestureDetector(
      onTap: () => _showUserActionBottomSheet(context, user),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE3ECEA)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFEEF3F3),
              child: Text(
                _getInitials(user.name),
                style: const TextStyle(
                  color: Color(0xFFF4877B),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D2733),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _getUserSubtitle(user),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7886),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF3F3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getRoleDisplayName(user.role),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7886),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isExpiring
                        ? const Color(0xFFFDE9C9)
                        : const Color(0xFFD6F3EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user.statusLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isExpiring
                          ? const Color(0xFFBF7414)
                          : const Color(0xFF1F9A85),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom Sheet للتعديل (بدون زرار Change coach للعميل)
  void _showUserActionBottomSheet(BuildContext context, UserModel user) {
    final bool isStaff =
        user.role == UserRole.coach || user.role == UserRole.barWorker;
    final bool isClient = user.role == UserRole.client;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCFDCD9),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFEEF3F3),
                    child: Text(
                      _getInitials(user.name),
                      style: const TextStyle(
                        color: Color(0xFFF4877B),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D2733),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${_getRoleDisplayName(user.role)} · ${_getUserSubtitle(user)}",
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF6B7886),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE3ECEA)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phone",
                          style: TextStyle(
                            color: Color(0xFF6B7886),
                            fontSize: 13.5,
                          ),
                        ),
                        Text(
                          user.phone,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF1D2733),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: Color(0xFFE3ECEA)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Joined",
                          style: TextStyle(
                            color: Color(0xFF6B7886),
                            fontSize: 13.5,
                          ),
                        ),
                        Text(
                          user.joinedDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF1D2733),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4877B),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Edit data",
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (isStaff) ...[
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // 👈 إغلاق الـ Bottom Sheet أولاً
                    Get.to(
                      () => TerminateContractPage(user: user),
                    ); // 👈 الانتقال لصفحة الترمينيت مع تمرير بيانات المستخدم
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: Color(0xFFD9483B)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Terminate contract",
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD9483B),
                    ),
                  ),
                ),
              ],
              if (isClient) ...[
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B5563),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Edit subscription",
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: Color(0xFFCFDCD9)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2733),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// دالة عنصر القائمة الجانبية
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF56C5B1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF1D2733),
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF1D2733),
              ),
            ),
          ],
        ),
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

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.coach:
        return "Coach";
      case UserRole.barWorker:
        return "Bar worker";
      case UserRole.client:
        return "Client";
      case UserRole.admin:
        return "Admin";
    }
  }
}
