import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/admin_view/core/model/user_model.dart'; // استوردي ملف الـ UserModel هنا

class UsersController extends GetxController {
  // ==================== تحكم القائمة الجانبية (Drawer) ====================
  var isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  // ==================== متغيرات وشاشة إضافة مستخدم جديد (Add User Form) ====================
  final addPhoneController = TextEditingController();
  final addEmailController = TextEditingController();
  final addPasswordController = TextEditingController(text: 'PLATE-4821');
  final addStartDateController = TextEditingController(text: '16 Oct 2026');
  final addEndDateController = TextEditingController(text: '16 Oct 2027');

  /// دالة إنشاء المستخدم الجديد مباشرة من هذا الكونترولر الموحد
  void createNewUser() {
    if (addPhoneController.text.isEmpty || addEmailController.text.isEmpty) {
      Get.snackbar("Error", "Please fill in the required fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final newUser = UserModel(
      id: DateTime.now().toString(),
      name: addEmailController.text.split('@').first,
      phone: addPhoneController.text,
      email: addEmailController.text,
      role: UserRole.client,
      joinedDate: 'Nov 2026',
      status: AccountStatus.active,
    );

    users.add(newUser);

    // تفريغ الحقول بعد الإضافة الناجحة
    addPhoneController.clear();
    addEmailController.clear();

    Get.snackbar(
      "Success",
      "Account created successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back(); // الرجوع لصفحة إدارة المستخدمين
    update();
  }

  // ==================== الفلاتر والبيانات ====================
  // الفلتر المحدد حالياً في شاشة المستخدمين (All, Coach, Bar worker, Client, Admin)
  var selectedRoleFilter = 'All'.obs;

  // حقل البحث النصي
  var searchQuery = ''.obs;

  // المتدربين المختارين في شاشة تعيين العملاء (Assign clients)
  var selectedClientsForAssign = <String>[].obs;

  // المدرب المحدد حالياً في شاشة التعيين (بنستخدم الـ ID)
  var selectedTargetCoachId = RxnString();

  // قائمة المستخدمين الأساسية (تكون RxList عشان الواجهة تحدث نفسها فوراً عند أي تغيير)
  final RxList<UserModel> users = <UserModel>[
    // 1. مدرب
    UserModel(
      id: 'c1',
      name: 'Hany Salah',
      phone: '010 1234 5678',
      role: UserRole.coach,
      status: AccountStatus.active,
      joinedDate: 'Jan 2024',
      specialization: 'Strength',
      capacity: 20, // السعة القصوى
      clientNames: ['Sara Mahmoud', 'Dina Maher', 'Huda Adel'], // مين هم (3 متدربين)
      clientsCount: 3, // العدد المنفصل للرقم الصريح
      contractStartDate: DateTime(2026, 1, 1),
      contractEndDate: DateTime(2026, 12, 31),
    ),
    // 2. مدرب آخر
    UserModel(
      id: 'c2',
      name: 'Mona Tarek',
      phone: '011 2233 4455',
      role: UserRole.coach,
      status: AccountStatus.active,
      joinedDate: 'Mar 2024',
      specialization: 'Yoga',
      capacity: 20, // السعة القصوى
      clientNames: ['Youssef Ammar', 'Mai Sherif','ayat'], // مين هم (2 متدربين)
      clientsCount: 3, // العدد المنفصل
      contractStartDate: DateTime(2024, 3, 1),
      contractEndDate: DateTime(2027, 3, 1),
    ),
    // 3. مدرب ثالث (لتغطية التصميم تماماً)
    UserModel(
      id: 'c3',
      name: 'Omar Ezzat',
      phone: '012 3344 5566',
      role: UserRole.coach,
      status: AccountStatus.active,
      joinedDate: 'May 2024',
      specialization: 'Fitness',
      capacity: 20,
      clientNames: ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'], // 9 متدربين
      clientsCount: 9, // العدد المنفصل
      contractStartDate: DateTime(2024, 5, 1),
      contractEndDate: DateTime(2027, 5, 1),
    ),
    // 4. عامل بار
    UserModel(
      id: 'b1',
      name: 'Ahmed Fawzy',
      phone: '012 9988 7766',
      role: UserRole.barWorker,
      status: AccountStatus.active,
      joinedDate: 'Jun 2025',
      shift: 'Evening shift',
    ),
    // 5. عميلة
    UserModel(
      id: 'u1',
      name: 'Sara Mahmoud',
      phone: '010 5566 7788',
      role: UserRole.client,
      status: AccountStatus.active,
      joinedDate: 'Oct 2026',
      subscriptionPlan: 'Quarterly',
      subscriptionStartDate: DateTime(2026, 11, 3),
      renewalDate: DateTime(2027, 2, 3),
      daysElapsed: 12,
      coachId: 'c1',
      coachName: 'Hany Salah',
    ),
    // 6. عميل
    UserModel(
      id: 'u2',
      name: 'Youssef Ammar',
      phone: '015 4433 2211',
      role: UserRole.client,
      status: AccountStatus.expiring,
      joinedDate: 'Sep 2026',
      subscriptionPlan: 'Monthly',
      subscriptionStartDate: DateTime(2026, 9, 1),
      renewalDate: DateTime(2026, 10, 1),
      daysElapsed: 17,
      coachId: 'c2',
      coachName: 'Mona Tarek',
    ),
    // 7. أدمن النظام
    UserModel(
      id: 'a1',
      name: 'Dr. Khaled',
      phone: '010 0000 1111',
      role: UserRole.admin,
      status: AccountStatus.active,
      joinedDate: 'Jan 2023',
      permissions: {
        'admins': true,
        'users': true,
        'subs': true,
        'bar': true,
        'prices': true,
        'occ': true,
      },
    ),
  ].obs;

  // ==================== استخراج قوائم مخصصة (Getters) ====================

  /// قائمة المدربين فقط (جاهزة للعرض ومعرفة سعة كل مدرب والمتدربين بتوعه)
  List<UserModel> get coachesList {
    return users.where((user) => user.role == UserRole.coach).toList();
  }

  /// قائمة العملاء غير المخصصين (الذين ليس لديهم مدرب بعد)
  List<UserModel> get unassignedClients {
    return users.where((user) => user.role == UserRole.client && (user.coachId == null || user.coachId!.isEmpty)).toList();
  }

  // ==================== الفلاتر المفلترة للعرض (GetX Computed List) ====================
  List<UserModel> get filteredUsers {
    return users.where((user) {
      // فلتر الدور (Role)
      bool matchesRole = true;
      if (selectedRoleFilter.value != 'All') {
        String targetRoleStr = selectedRoleFilter.value.toLowerCase();
        if (targetRoleStr.contains('coach')) {
          matchesRole = user.role == UserRole.coach;
        } 
        else if (targetRoleStr.contains('bar')) {
          matchesRole = user.role == UserRole.barWorker;
        }
        else if (targetRoleStr.contains('client')) {
          matchesRole = user.role == UserRole.client;
        }
        else if (targetRoleStr.contains('admin')) {
          matchesRole = user.role == UserRole.admin;
        }
      }

      // فلتر البحث بالاسم أو رقم الهاتف
      bool matchesSearch =
          searchQuery.value.isEmpty ||
          user.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          user.phone.contains(searchQuery.value);

      return matchesRole && matchesSearch;
    }).toList();
  }

  // ==================== الوظائف والأحداث (Actions) ====================

  /// تغيير الفلتر عند الضغط على الـ Chips
  void changeRoleFilter(String role) {
    selectedRoleFilter.value = role;
  }

  /// تحديث نص البحث
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// إضافة مستخدم جديد للقائمة مباشرة
  void addUser(UserModel newUser) {
    users.add(newUser);
    update();
  }

  /// تحديد المدرب المستهدف أثناء عملية التعيين (Assign)
  void setTargetCoach(String coachId) {
    selectedTargetCoachId.value = coachId;
  }

  /// اختيار أو إلغاء اختيار عميل في شاشة تعيين العملاء
  void toggleClientSelection(String clientName) {
    if (selectedClientsForAssign.contains(clientName)) {
      selectedClientsForAssign.remove(clientName);
    } else {
      selectedClientsForAssign.add(clientName);
    }
  }

  /// تنفيذ عملية تعيين العملاء المختارين للمدرب المختار وتحديث العدد وقائمة الأسماء معاً
  void assignSelectedClientsToCoach() {
    if (selectedTargetCoachId.value == null || selectedClientsForAssign.isEmpty) {
      Get.snackbar("Notice", "Please select a coach and clients first.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    int coachIndex = users.indexWhere((u) => u.id == selectedTargetCoachId.value && u.role == UserRole.coach);
    if (coachIndex != -1) {
      var coach = users[coachIndex];
      
      // 1. دمج الأسماء الجديدة مع القائمة القديمة للمدرب
      List<String> updatedClients = List.from(coach.clientNames ?? []);
      updatedClients.addAll(selectedClientsForAssign);

      // 2. تحديث بيانات المدرب وإحداث تكامل بين قائمة الأسماء (مين هم) والعدد الصريح (clientsCount)
      users[coachIndex] = UserModel(
        id: coach.id,
        name: coach.name,
        phone: coach.phone,
        email: coach.email,
        role: coach.role,
        status: coach.status,
        joinedDate: coach.joinedDate,
        specialization: coach.specialization,
        capacity: coach.capacity,
        clientNames: updatedClients,           // 👥 مين هم (القائمة المحدثة)
        clientsCount: updatedClients.length,   // 🔢 العدد المنفصل المحدث تلقائياً
        contractStartDate: coach.contractStartDate,
        contractEndDate: coach.contractEndDate,
      );
    }

    // تفريغ الاختيارات بعد التعيين بنجاح
    selectedClientsForAssign.clear();
    selectedTargetCoachId.value = null;

    Get.snackbar(
      "Success",
      "Clients assigned successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
    update();
  }

  /// تحديث مدة اشتراك العميل (لو في فترة الـ 15 يوم)
  void updateClientSubscriptionMonths(String userId, int newMonths) {
    int index = users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      var client = users[index];
      if (client.isSubscriptionEditable) {
        Get.snackbar("Updated", "Subscription duration updated successfully.");
        update();
      } else {
        Get.snackbar(
          "Error",
          "Editing is locked after 15 days.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  void onClose() {
    addPhoneController.dispose();
    addEmailController.dispose();
    addPasswordController.dispose();
    addStartDateController.dispose();
    addEndDateController.dispose();
    super.onClose();
  }
}