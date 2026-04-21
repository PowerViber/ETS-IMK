import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import 'target_provider.dart';

class TargetScreen extends ConsumerStatefulWidget {
  const TargetScreen({super.key});

  @override
  ConsumerState<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends ConsumerState<TargetScreen> {
  DateTime _selectedDate = DateTime.now();

  void _showAddTargetModal(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Target Baru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Target',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Target',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      ref.read(targetProvider.notifier).addTarget(
                            titleController.text,
                            descController.text,
                            _selectedDate,
                          );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Simpan Target', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch derived list directly using provider's function
    final targetNotifier = ref.read(targetProvider.notifier);
    final targets = ref.watch(targetProvider).where((t) {
      return t.date.year == _selectedDate.year &&
             t.date.month == _selectedDate.month &&
             t.date.day == _selectedDate.day;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTargetModal(context),
        backgroundColor: AppTheme.accentGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          // Date Selector Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => setState(() => _selectedDate = _selectedDate.subtract(const Duration(days: 1))),
                ),
                Text(
                  DateFormat('EEEE, d MMM y').format(_selectedDate),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => setState(() => _selectedDate = _selectedDate.add(const Duration(days: 1))),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),

          // Target List
          Expanded(
            child: targets.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada target untuk hari ini.',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: targets.length,
                    itemBuilder: (context, index) {
                      final item = targets[index];
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: GestureDetector(
                            onTap: () => targetNotifier.toggleCompletion(item.id),
                            child: CircleAvatar(
                              backgroundColor: item.isCompleted ? AppTheme.accentGreen : Colors.grey[200],
                              child: Icon(
                                Icons.check,
                                color: item.isCompleted ? Colors.white : Colors.grey[400],
                              ),
                            ),
                          ),
                          title: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          subtitle: item.description.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(item.description),
                                )
                              : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => targetNotifier.deleteTarget(item.id),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
