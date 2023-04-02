import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/view/widgets/group_card.dart';
import 'package:dstu_schedule/features/schedule/view/pages/select_group_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupsList extends ConsumerStatefulWidget {
  final List<Group> groups;

  const GroupsList(this.groups, {super.key});

  @override
  ConsumerState createState() => _GroupsListState();
}

class _GroupsListState extends ConsumerState<GroupsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onGroupsListRefresh,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final Group group = widget.groups[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GroupCard(group: group),
                );
              },
              childCount: widget.groups.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onGroupsListRefresh() async {
    ref.invalidate(groupsProvider);
  }
}
