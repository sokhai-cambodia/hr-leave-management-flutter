import 'dart:async';

import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/notifications_repository.dart';
import '../../auth/controllers/auth_controller.dart';

/// Registered globally (permanent, `InitialBinding`) rather than per-route -
/// the unread badge (shown via `AppShellScaffold` on every authenticated
/// screen) needs to poll and stay live regardless of which screen is open,
/// not just while the Notifications screen itself is on-screen.
class NotificationsController extends GetxController {
  NotificationsController({required this.notificationsRepository});

  final NotificationsRepository notificationsRepository;
  final _authController = Get.find<AuthController>();

  static const _pollInterval = Duration(seconds: 30);
  static const int _pageSize = 20;

  final unreadCount = 0.obs;

  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final hasMore = true.obs;
  final errorMessage = RxnString();
  int _skip = 0;

  Timer? _pollTimer;

  @override
  void onInit() {
    super.onInit();
    ever<UserModel?>(_authController.currentUser, _onUserChanged);
    _onUserChanged(_authController.currentUser.value);
  }

  @override
  void onClose() {
    _pollTimer?.cancel();
    super.onClose();
  }

  /// Starts/stops polling with the session lifecycle - login (or session
  /// bootstrap) begins polling, logout stops it and clears local state so a
  /// stale badge/list doesn't survive into the next login.
  void _onUserChanged(UserModel? user) {
    if (user != null) {
      fetchUnreadCount();
      _pollTimer?.cancel();
      _pollTimer = Timer.periodic(_pollInterval, (_) => fetchUnreadCount());
    } else {
      _pollTimer?.cancel();
      _pollTimer = null;
      unreadCount.value = 0;
      notifications.clear();
    }
  }

  /// Silent on failure - a badge refresh failing shouldn't surface an error
  /// toast on every screen every 30 seconds.
  Future<void> fetchUnreadCount() async {
    try {
      unreadCount.value = await notificationsRepository.fetchUnreadCount();
    } on ApiException {
      // Ignored - see doc comment above.
    }
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      hasMore.value = true;
      notifications.clear();
      isLoading.value = true;
      errorMessage.value = null;
    } else {
      if (isMoreLoading.value || !hasMore.value) return;
      isMoreLoading.value = true;
    }

    try {
      final page = await notificationsRepository.fetchNotifications(
        skip: _skip,
        limit: _pageSize,
      );
      notifications.addAll(page.data);
      _skip += page.data.length;
      unreadCount.value = page.unreadCount;
      if (page.data.length < _pageSize || notifications.length >= page.count) {
        hasMore.value = false;
      }
    } on ApiException catch (e) {
      if (isRefresh) errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  /// Optimistic - flips locally immediately so the tap feels instant; if
  /// the server call fails, the next poll/refresh reconciles the count.
  Future<void> markAsRead(NotificationModel notification) async {
    if (notification.isRead) return;
    final index = notifications.indexWhere((n) => n.id == notification.id);
    if (index != -1) {
      notifications[index] = notification.copyWith(isRead: true);
    }
    if (unreadCount.value > 0) unreadCount.value--;
    try {
      await notificationsRepository.markRead(notification.id);
    } on ApiException {
      // Ignored - see doc comment above.
    }
  }

  Future<void> markAllAsRead() async {
    if (unreadCount.value == 0) return;
    notifications.assignAll(
      notifications.map((n) => n.copyWith(isRead: true)).toList(),
    );
    unreadCount.value = 0;
    try {
      await notificationsRepository.markAllRead();
    } on ApiException catch (e) {
      Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
