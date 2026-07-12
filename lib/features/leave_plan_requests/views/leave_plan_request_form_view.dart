import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../../../data/models/leave_plan_request_model.dart';
import '../controllers/leave_plan_requests_controller.dart';
import 'leave_plan_request_detail_view.dart';

class LeavePlanRequestFormView extends StatefulWidget {
  const LeavePlanRequestFormView({
    super.key,
    this.request,
    this.initialDates,
    this.initialLeaveTypeId,
  });

  final LeavePlanRequestModel? request;
  final List<DateTime>? initialDates;
  final String? initialLeaveTypeId;

  @override
  State<LeavePlanRequestFormView> createState() => _LeavePlanRequestFormViewState();
}

class _LeavePlanRequestFormViewState extends State<LeavePlanRequestFormView> {
  final LeavePlanRequestsController controller = Get.find<LeavePlanRequestsController>();
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  String? _selectedLeaveTypeId;
  final _selectedDates = <DateTime>[].obs;

  bool get _isEdit => widget.request != null;

  /// The recommendation flow ("6.2 Selection UI") is the only caller that
  /// pre-populates dates on a *new* request, so its presence doubles as the
  /// signal to offer the one-tap "Submit Now" action (6.3) alongside the
  /// plain draft save.
  bool get _isFromRecommendation =>
      !_isEdit && (widget.initialDates?.isNotEmpty ?? false);

  @override
  void initState() {
    super.initState();

    // Populate initial values
    if (_isEdit) {
      _selectedLeaveTypeId = widget.request!.leaveType.id;
      _selectedDates.addAll(widget.request!.details.map((d) => d.leaveDate));
      _descriptionController.text = widget.request!.description ?? '';
    } else {
      _selectedLeaveTypeId = widget.initialLeaveTypeId;
      if (widget.initialDates != null) {
        _selectedDates.addAll(widget.initialDates!);
      }
    }

    _selectedDates.sort();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchLeaveTypes();
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addPlannedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (picked != null) {
      // Direct call to the pure, testable controller method
      if (LeavePlanRequestsController.isDuplicateDate(_selectedDates, picked)) {
        Get.snackbar(
          'Duplicate Date',
          '${_formatDate(picked)} is already selected.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withValues(alpha: 0.1),
          colorText: Colors.orange[800],
        );
        return;
      }

      _selectedDates.add(picked);
      _selectedDates.sort();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) return false;
    if (_selectedDates.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select at least one planned date.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  Future<void> _save() async {
    if (!_validateForm()) return;

    bool success;
    if (_isEdit) {
      success = await controller.updateRequest(
        widget.request!.id,
        description: _descriptionController.text.trim(),
        leaveTypeId: _selectedLeaveTypeId!,
        dates: _selectedDates,
      );
    } else {
      success = await controller.createRequest(
        description: _descriptionController.text.trim(),
        leaveTypeId: _selectedLeaveTypeId!,
        dates: _selectedDates,
      );
    }

    if (success) {
      Get.back();
      Get.snackbar(
        'Success',
        _isEdit
            ? 'Leave plan updated successfully.'
            : 'Leave plan created as draft.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
      );
    }
  }

  Future<void> _saveAndSubmit() async {
    if (!_validateForm()) return;

    final result = await controller.createAndSubmitRequest(
      description: _descriptionController.text.trim(),
      leaveTypeId: _selectedLeaveTypeId!,
      dates: _selectedDates,
    );

    // Non-null even on submit failure (draft was still created) - route to
    // its detail either way so the draft is never silently lost; the detail
    // view already offers a Submit action for a still-draft request.
    if (result != null) {
      Get.back();
      Get.to(() => LeavePlanRequestDetailView(requestId: result.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Leave Plan' : 'New Leave Plan'),
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
                    border: Border.all(color: AppColors.danger.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: AppColors.danger),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.formErrorMessage.value!,
                          style: TextStyle(color: AppColors.danger, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),

              // Leave Type selection
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
              const SizedBox(height: 24),

              // Planned Dates section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Planned Dates',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  TextButton.icon(
                    onPressed: () => _addPlannedDate(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Date'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(minHeight: 80),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(color: AppColors.lightBorder),
                  borderRadius: BorderRadius.circular(AppShapes.fieldRadius),
                ),
                child: Obx(() {
                  if (_selectedDates.isEmpty) {
                    return Center(
                      child: Text(
                        'No dates added yet. Tap "Add Date" above.',
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    );
                  }

                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedDates.map((date) {
                      return InputChip(
                        label: Text(_formatDate(date)),
                        onDeleted: () {
                          _selectedDates.remove(date);
                        },
                        avatar: const Icon(Icons.calendar_today_outlined, size: 14),
                      );
                    }).toList(),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Description
              const Text(
                'Description / Reason',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Enter reason or notes...',
                ),
              ),
              const SizedBox(height: 36),

              // Action button(s)
              Obx(() {
                if (controller.isSubmitting.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_isFromRecommendation) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: _saveAndSubmit,
                        child: const Text('Submit Now'),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: _save,
                        child: const Text('Save as Draft'),
                      ),
                    ],
                  );
                }
                return ElevatedButton(
                  onPressed: _save,
                  child: Text(_isEdit ? 'Update Plan' : 'Save as Draft'),
                );
              }),
            ],
          ),
        );
        }),
      ),
    );
  }
}
