import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/team_model.dart';
import '../../../widgets/admin/admin_crud_view.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import '../controllers/teams_admin_controller.dart';

class AdminTeamsView extends StatelessWidget {
  const AdminTeamsView({super.key});

  Map<String, dynamic> _toFormValues(TeamModel item) => {
    'name': item.name,
    'description': item.description,
    'team_owner_id': item.teamOwnerId,
    'is_active': item.isActive,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TeamsAdminController>();

    return AdminCrudView<TeamModel>(
      title: 'Teams',
      controller: controller,
      fields: (isEdit) => [
        const AdminFieldSpec(key: 'name', label: 'Name', type: AdminFieldType.text, required: true),
        const AdminFieldSpec(
          key: 'description',
          label: 'Description',
          type: AdminFieldType.multilineText,
        ),
        AdminFieldSpec(
          key: 'team_owner_id',
          label: 'Team Owner',
          type: AdminFieldType.relation,
          required: true,
          options: controller.userOptions,
        ),
        const AdminFieldSpec(key: 'is_active', label: 'Active', type: AdminFieldType.boolean),
      ],
      toFormValues: _toFormValues,
      emptyFormValues: const {
        'name': '',
        'description': null,
        'team_owner_id': null,
        'is_active': true,
      },
      itemTitle: (item) => item.name,
      itemSubtitle: (item) {
        final owner = item.teamOwner?.fullName ?? item.teamOwner?.email ?? 'Unassigned';
        final members = item.teamMembers.length;
        return 'Owner: $owner · $members member${members == 1 ? '' : 's'}'
            '${item.isActive ? '' : ' · Inactive'}';
      },
      searchHint: 'Search by name...',
    );
  }
}
