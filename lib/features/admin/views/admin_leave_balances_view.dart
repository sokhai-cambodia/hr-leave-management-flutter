import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/leave_balance_model.dart';
import '../../../widgets/admin/admin_crud_view.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import '../controllers/leave_balances_admin_controller.dart';

class AdminLeaveBalancesView extends StatelessWidget {
  const AdminLeaveBalancesView({super.key});

  Map<String, dynamic> _toFormValues(LeaveBalanceModel item) => {
    'owner_id': item.ownerId,
    'leave_type_id': item.leaveType.id,
    'year': item.year,
    'balance': item.balance,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaveBalancesAdminController>();

    return AdminCrudView<LeaveBalanceModel>(
      title: 'Leave Balances',
      controller: controller,
      fields: (isEdit) => [
        AdminFieldSpec(
          key: 'owner_id',
          label: 'Employee',
          type: AdminFieldType.relation,
          required: true,
          options: controller.userOptions,
        ),
        AdminFieldSpec(
          key: 'leave_type_id',
          label: 'Leave Type',
          type: AdminFieldType.relation,
          required: true,
          options: controller.leaveTypeOptions,
        ),
        AdminFieldSpec(
          key: 'year',
          label: 'Year',
          type: AdminFieldType.text,
          required: true,
          validator: (value) {
            final v = value?.trim() ?? '';
            if (v.length != 4 || int.tryParse(v) == null) {
              return 'Enter a 4-digit year';
            }
            return null;
          },
        ),
        const AdminFieldSpec(
          key: 'balance',
          label: 'Balance (days)',
          type: AdminFieldType.decimal,
          required: true,
        ),
      ],
      toFormValues: _toFormValues,
      emptyFormValues: const {
        'owner_id': null,
        'leave_type_id': null,
        'year': '',
        'balance': null,
      },
      itemTitle: (item) =>
          item.owner?.fullName ?? item.owner?.email ?? 'Unknown employee',
      itemSubtitle: (item) =>
          '${item.leaveType.name} · ${item.year} · ${item.availableBalance}/${item.balance} available',
      searchHint: 'Search by employee, leave type, or year...',
    );
  }
}
