enum UserRole { client, coach, barWorker, admin }

enum AccountStatus { active, expiring, terminated }

class UserModel {
  // ==================== بيانات أساسية لكل الناس ====================
  final String id;
  final String name;
  final String phone;
  final String? email;
  final UserRole role;
  final AccountStatus status; // active (ساري) | expiring (قرب يخلص) | terminated (منتهي)
  final String joinedDate;

  // ==================== بيانات الـ Client (العميل) ====================
  final String? subscriptionPlan;      // 'Monthly', 'Quarterly', 'Half-yearly', 'Yearly'
  final DateTime? subscriptionStartDate; // تاريخ بداية الاشتراك
  final DateTime? renewalDate;           // تاريخ تجديد الاشتراك القادم
  final int? daysElapsed;                // عدد الأيام اللي عدت من الاشتراك (لقاعدة الـ 15 يوم)
  final String? coachId;                 // ID المدرب المسؤول عنه
  final String? coachName;               // اسم المدرب المسؤول عنه

  // ==================== بيانات الـ Coach (المدرب) ====================
  final String? specialization;          // التخصص (Strength, Yoga, etc.)
  final int? capacity;                   // أقصى عدد متدربين يقدر يمسكهم (السعة القصوى)
  final List<String>? clientIds;         // IDs المتدربين
  final List<String>? clientNames;       // 👥 مين هم (قائمة الأسماء التفصيلية)
  final int? clientsCount;               // 🔢 العدد لوحده (متغير منفصل للرقم الصريح)

  // ==================== بيانات الموظفين (Coach / Bar Worker) ====================
  final String? shift;                   // الشيفت (Morning shift, Evening shift)
  final DateTime? contractStartDate;     // بداية العقد
  final DateTime? contractEndDate;       // نهاية العقد (للتجديد أو الفسخ المبكر)

  // ==================== صلاحيات الـ Admin ====================
  final Map<String, bool>? permissions;  // صلاحيات الأدمن الفرعي

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.role,
    this.status = AccountStatus.active,
    required this.joinedDate,
    // Client
    this.subscriptionPlan,
    this.subscriptionStartDate,
    this.renewalDate,
    this.daysElapsed,
    this.coachId,
    this.coachName,
    // Coach
    this.specialization,
    this.capacity,
    this.clientIds,
    this.clientNames,
    int? clientsCount,
    // Staff
    this.shift,
    this.contractStartDate,
    this.contractEndDate,
    // Admin
    this.permissions,
  }) : clientsCount = clientsCount ?? clientNames?.length ?? clientIds?.length ?? 0;

  // ==================== دوال مساعدة واختصارات للشاشات ====================

  /// هل العميل لسه في فترة الـ 15 يوم المسموح فيها بتعديل أو إلغاء الاشتراك؟
  bool get isSubscriptionEditable =>
      role == UserRole.client && (daysElapsed ?? 0) <= 15;

  /// العدد الحالي للمتدربين (من المتغير المنفصل)
  int get currentClientsCount => clientsCount ?? 0;

  /// باقيله كام عشان يكتمل العدد للحد الأقصى (Capacity)
  int get remainingCapacity {
    if (capacity == null) return 0;
    return (capacity! - currentClientsCount).clamp(0, capacity!);
  }

  /// نسبة امتلاء المدرب (من 0.0 إلى 1.0) عشان شريط التقدم (Progress Indicator)
  double get coachCapacityProgress {
    if (capacity == null || capacity == 0) return 0.0;
    return (currentClientsCount / capacity!).clamp(0.0, 1.0);
  }

  /// حالة السعة نصياً للـ Badge (تطبع تلقائياً: Almost full أو Full أو Available)
  String get coachStatusLabel {
    if (capacity == null) return 'Available';
    final ratio = currentClientsCount / capacity!;
    if (currentClientsCount >= capacity!) {
      return 'Full';
    } else if (ratio >= 0.8) {
      // لو وصل 80% أو أكتر يعتبر قرب يمتلئ
      return 'Almost full';
    } else {
      return 'Available';
    }
  }

  /// هل المدرب قرب يمتلئ؟
  bool get isAlmostFull {
    if (capacity == null || capacity == 0) return false;
    return (currentClientsCount / capacity!) >= 0.8 && currentClientsCount < capacity!;
  }

  /// نص جاهز يظهر تحت اسم المستخدم في قوائم الأدمن
  String get summarySubtitle {
    switch (role) {
      case UserRole.coach:
        return '${specialization ?? "Coach"} · $currentClientsCount clients';
      case UserRole.barWorker:
        return shift ?? 'Bar Staff';
      case UserRole.client:
        return '${subscriptionPlan ?? "Member"} · day ${daysElapsed ?? 1}';
      case UserRole.admin:
        return (permissions?['admins'] == true)
            ? 'Owner · all permissions'
            : 'Limited permissions';
    }
  }

  /// نص حالة الحساب جاهز للعرض في الـ Badge
  String get statusLabel {
    switch (status) {
      case AccountStatus.active:
        return 'Active';
      case AccountStatus.expiring:
        return 'Expiring';
      case AccountStatus.terminated:
        return 'Terminated';
    }
  }
}