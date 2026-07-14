import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';

class ChangePasswordView extends GetView<AuthController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      final success = await controller.changePassword(
        currentPassword: currentController.text,
        newPassword: newController.text,
      );
      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          'Password changed successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.1),
          colorText: Colors.green[800],
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      // Without this, the bottom-most action button can end up rendered
      // behind the system gesture-nav bar on some devices (unclickable) -
      // Scaffold.body isn't safe-area-wrapped by default.
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Current Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              _ObscurableField(
                controller: currentController,
                hintText: 'Current password',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Current password is required'
                    : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'New Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              _ObscurableField(
                controller: newController,
                hintText: 'New password',
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Must be at least 8 characters';
                  }
                  if (value == currentController.text) {
                    return 'New password cannot be the same as the '
                        'current one';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Confirm New Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              _ObscurableField(
                controller: confirmController,
                hintText: 'Confirm new password',
                validator: (value) => value != newController.text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 36),
              Obx(() {
                final message = controller.changePasswordError.value;
                if (message == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
              Obx(
                () => controller.isChangePasswordLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: submit,
                        child: const Text('Change Password'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ObscurableField extends StatefulWidget {
  const _ObscurableField({
    required this.controller,
    required this.hintText,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<_ObscurableField> createState() => _ObscurableFieldState();
}

class _ObscurableFieldState extends State<_ObscurableField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black45,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
    );
  }
}
