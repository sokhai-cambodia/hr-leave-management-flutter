import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

/// Manual "paste your reset token" flow — no deep-linking in scope
/// (decided in the plan: Task 1.3).
class ResetPasswordView extends GetView<AuthController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      await controller.resetPassword(
        token: tokenController.text.trim(),
        newPassword: passwordController.text,
      );
      if (controller.resetSuccess.value) {
        Get.snackbar(
          'Password updated',
          'You can now log in with your new password.',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(Routes.login);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.password_outlined, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Enter your reset token',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Paste the token from the recovery email, then choose '
                    'a new password.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: tokenController,
                    minLines: 1,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'Reset token'),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Reset token is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New password',
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'New password is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm new password',
                    ),
                    validator: (value) => value != passwordController.text
                        ? 'Passwords do not match'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final message = controller.resetError.value;
                    if (message == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
                  Obx(() {
                    final isLoading = controller.isResetLoading.value;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : submit,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Reset password'),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
