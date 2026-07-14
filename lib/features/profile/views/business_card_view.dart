import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/user_model.dart';
import '../../auth/controllers/auth_controller.dart';

/// Shows a QR code that opens a Telegram chat with this user, so someone
/// else can scan it (e.g. off another phone's camera) and message them
/// directly - the QR encodes a `t.me` deep link, not a vCard, per the
/// user's explicit choice for this feature. The card face is captured via
/// [RepaintBoundary] so it can be saved to the gallery or shared as an
/// image alongside a text summary.
class BusinessCardView extends StatefulWidget {
  const BusinessCardView({super.key});

  @override
  State<BusinessCardView> createState() => _BusinessCardViewState();
}

class _BusinessCardViewState extends State<BusinessCardView> {
  final _authController = Get.find<AuthController>();
  final _boundaryKey = GlobalKey();
  bool _isSaving = false;
  bool _isSharing = false;

  /// Strips everything but digits, since a Telegram `t.me/+<phone>` link
  /// needs E.164-ish formatting to resolve correctly - users may have typed
  /// spaces/dashes/parens into the phone field.
  static String _normalizePhone(String raw) =>
      raw.replaceAll(RegExp(r'[^0-9]'), '');

  Future<Uint8List?> _captureCard() async {
    final boundary =
        _boundaryKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) return null;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _saveCard() async {
    setState(() => _isSaving = true);
    try {
      final bytes = await _captureCard();
      if (bytes == null) return;
      await Gal.putImageBytes(bytes, name: 'business_card');
      Get.snackbar(
        'Saved',
        'Business card saved to your gallery.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );
    } on GalException catch (e) {
      Get.snackbar(
        'Save Failed',
        e.type.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red[800],
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _shareCard(UserModel? user, String phone) async {
    setState(() => _isSharing = true);
    try {
      final bytes = await _captureCard();
      final name = user?.fullName ?? 'My';
      final teamLine = user?.team?.name != null ? ' · ${user!.team!.name}' : '';
      final text =
          "$name's business card$teamLine\n"
          'Telegram: https://t.me/+${_normalizePhone(phone)}';
      await SharePlus.instance.share(
        ShareParams(
          text: text,
          files: bytes == null
              ? null
              : [
                  XFile.fromData(
                    bytes,
                    mimeType: 'image/png',
                    name: 'business_card.png',
                  ),
                ],
        ),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: const Text('My Business Card')),
      body: Obx(() {
        final user = _authController.currentUser.value;
        final phone = user?.phoneNumber;
        final hasPhone = phone != null && phone.trim().isNotEmpty;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: hasPhone
                  ? [
                      RepaintBoundary(
                        key: _boundaryKey,
                        child: _CardFace(user: user, phone: phone),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _isSaving ? null : _saveCard,
                              icon: _isSaving
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.download_outlined),
                              label: const Text('Save'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _isSharing
                                  ? null
                                  : () => _shareCard(user, phone),
                              icon: _isSharing
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.share_outlined),
                              label: const Text('Share'),
                            ),
                          ),
                        ],
                      ),
                    ]
                  : const [_MissingPhonePrompt()],
            ),
          ),
        );
      }),
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({required this.user, required this.phone});

  final UserModel? user;
  final String phone;

  static String _initials(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? '?' : trimmed[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppShapes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  child: Text(
                    _initials(user?.fullName ?? user?.email),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.fullName ?? 'Unnamed user',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (user?.team?.name != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    user!.team!.name,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                QrImageView(
                  data:
                      'https://t.me/+${_BusinessCardViewState._normalizePhone(phone)}',
                  version: QrVersions.auto,
                  size: 180,
                  gapless: false,
                ),
                const SizedBox(height: 12),
                Text(
                  'Scan to chat on Telegram',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MissingPhonePrompt extends StatelessWidget {
  const _MissingPhonePrompt();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.phone_disabled_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            const Text(
              'Add your phone number first',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your business card needs a phone number to generate a '
              'Telegram QR code. Add one from your profile, then come '
              'back here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text('Back to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
