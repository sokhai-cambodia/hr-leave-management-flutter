import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../widgets/admin/admin_crud_view.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import '../controllers/users_admin_controller.dart';

class AdminUsersView extends StatelessWidget {
  const AdminUsersView({super.key});

  Map<String, dynamic> _toFormValues(UserModel item) => {
    'email': item.email,
    'password': null,
    'full_name': item.fullName,
    'username': item.username,
    'phone_number': item.phoneNumber,
    'team_id': item.teamId,
    'is_active': item.isActive,
    'is_superuser': item.isSuperuser,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UsersAdminController>();

    return AdminCrudView<UserModel>(
      title: 'Users',
      controller: controller,
      fields: (isEdit) => [
        const AdminFieldSpec(
          key: 'email',
          label: 'Email',
          type: AdminFieldType.text,
          required: true,
        ),
        AdminFieldSpec(
          key: 'password',
          label: isEdit
              ? 'New Password (leave blank to keep current)'
              : 'Password',
          type: AdminFieldType.text,
          required: !isEdit,
          obscureText: true,
          validator: (value) =>
              (value?.length ?? 0) < 8 ? 'Must be at least 8 characters' : null,
        ),
        const AdminFieldSpec(
          key: 'full_name',
          label: 'Full Name',
          type: AdminFieldType.text,
        ),
        const AdminFieldSpec(
          key: 'username',
          label: 'Username',
          type: AdminFieldType.text,
        ),
        const AdminFieldSpec(
          key: 'phone_number',
          label: 'Phone Number',
          type: AdminFieldType.text,
        ),
        AdminFieldSpec(
          key: 'team_id',
          label: 'Team',
          type: AdminFieldType.relation,
          options: controller.teamOptions,
        ),
        const AdminFieldSpec(
          key: 'is_active',
          label: 'Active',
          type: AdminFieldType.boolean,
        ),
        const AdminFieldSpec(
          key: 'is_superuser',
          label: 'Superuser',
          type: AdminFieldType.boolean,
        ),
      ],
      toFormValues: _toFormValues,
      emptyFormValues: const {
        'email': '',
        'password': '',
        'full_name': null,
        'username': null,
        'phone_number': null,
        'team_id': null,
        'is_active': true,
        'is_superuser': false,
      },
      itemTitle: (item) => item.fullName ?? item.email,
      itemSubtitle: (item) {
        final team = item.team?.name ?? 'No team';
        final flags = [
          if (!item.isActive) 'Inactive',
          if (item.isSuperuser) 'Superuser',
        ];
        final suffix = flags.isEmpty ? '' : ' · ${flags.join(' · ')}';
        final usernameSuffix = item.username != null
            ? ' · @${item.username}'
            : '';
        return '${item.email}$usernameSuffix · $team$suffix';
      },
      searchHint: 'Search by name, email, or username...',
    );
  }
}
