import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_request_model.dart';
import '../controllers/leave_requests_controller.dart';

class LeaveRequestFormView extends StatefulWidget {
  const LeaveRequestFormView({super.key, this.request});

  final LeaveRequestModel? request;

  @override
  State<LeaveRequestFormView> createState() => _LeaveRequestFormViewState();
}

class _LeaveRequestFormViewState extends State<LeaveRequestFormView> {
  final LeaveRequestsController controller =
      Get.find<LeaveRequestsController>();
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  String? _selectedLeaveTypeId;
  DateTime? _startDate;
  DateTime? _endDate;

  bool get _isEdit => widget.request != null;

  @override
  void initState() {
    super.initState();
    _selectedLeaveTypeId = widget.request?.leaveType.id;
    _startDate = widget.request?.startDate;
    _endDate = widget.request?.endDate;
    _descriptionController.text = widget.request?.description ?? '';

    // Load active leave types for the dropdown selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchLeaveTypes();
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        // Adjust end date if it is before start date
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate:
          _startDate ?? DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      Get.snackbar(
        'Validation Error',
        'Please select both start and end dates.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      Get.snackbar(
        'Validation Error',
        'End date cannot be before start date.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    bool success;
    if (_isEdit) {
      success = await controller.updateRequest(
        widget.request!.id,
        startDate: _startDate!,
        endDate: _endDate!,
        description: _descriptionController.text.trim(),
        leaveTypeId: _selectedLeaveTypeId!,
      );
    } else {
      success = await controller.createRequest(
        startDate: _startDate!,
        endDate: _endDate!,
        description: _descriptionController.text.trim(),
        leaveTypeId: _selectedLeaveTypeId!,
      );
    }

    if (success) {
      Get.back(); // close form screen
      Get.snackbar(
        'Success',
        _isEdit
            ? 'Leave request updated successfully.'
            : 'Leave request created as draft.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Leave Request' : 'New Leave Request'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      // Without this, the bottom-most action button can end up rendered
      // behind the system gesture-nav bar on some devices (unclickable) -
      // Scaffold.body isn't safe-area-wrapped by default.
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoadingLeaveTypes.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Error block
                if (controller.formErrorMessage.value != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.danger.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: AppColors.danger),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.formErrorMessage.value!,
                            style: TextStyle(
                              color: AppColors.danger,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Leave Type field
                const Text(
                  'Leave Type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedLeaveTypeId,
                  decoration: const InputDecoration(
                    hintText: 'Select a leave type',
                  ),
                  items: controller.leaveTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type.id,
                      child: Text(type.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLeaveTypeId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a leave type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Date pickers row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _selectStartDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                  color: AppColors.lightBorder,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppShapes.fieldRadius,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDate(_startDate),
                                    style: TextStyle(
                                      color: _startDate != null
                                          ? Colors.black87
                                          : Colors.grey[500],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _selectEndDate(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                  color: AppColors.lightBorder,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppShapes.fieldRadius,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDate(_endDate),
                                    style: TextStyle(
                                      color: _endDate != null
                                          ? Colors.black87
                                          : Colors.grey[500],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description field
                const Text(
                  'Description / Reason',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Enter reason or extra notes (optional)...',
                  ),
                ),
                const SizedBox(height: 36),

                // Save Button
                Obx(
                  () => controller.isSubmitting.value
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _save,
                          child: Text(
                            _isEdit ? 'Update Request' : 'Save as Draft',
                          ),
                        ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
