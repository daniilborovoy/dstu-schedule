import 'package:dstu_schedule/features/schedule/view/pages/select_group_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchGroupInput extends ConsumerStatefulWidget {
  const SearchGroupInput({super.key});

  @override
  ConsumerState createState() => _SearchGroupInputState();
}

class _SearchGroupInputState extends ConsumerState<SearchGroupInput> {
  final _searchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchInputController.text = ref.read(searchInputProvider);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      placeholder: 'Введите название группы...',
      controller: _searchInputController,
      onChanged: onInputChanged,
    );
  }

  void onInputChanged(String value) {
    ref.read(searchInputProvider.notifier).state = value;
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }
}
