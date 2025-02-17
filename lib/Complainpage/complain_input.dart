import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ComplainInputForm extends StatefulWidget {
  final String initialDescription;
  final String? initialCategory;

  const ComplainInputForm({
    super.key,
    this.initialDescription = '',
    this.initialCategory,
  });

  @override
  State<ComplainInputForm> createState() => _ComplainInputFormState();
}

class _ComplainInputFormState extends State<ComplainInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();
  final _categoryController = TextEditingController();

  String? selectedCategory;
  final List<String> categories = ['Landline', 'Phone/Landline', 'Evo 4G', 'Ptcl Fiber', 'Ptcl Smart TV'];
  XFile? selectedMedia;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _complaintController.text = widget.initialDescription;
    selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _complaintController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedMedia = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Complaint'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Complaint Description
              TextFormField(
                controller: _complaintController,
                decoration: const InputDecoration(
                  labelText: 'Complaint Description',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.green),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.green),
                ),
                value: selectedCategory,
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),

              // Add New Category Button
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Add Category'),
                      content: TextFormField(
                        controller: _categoryController,
                        decoration: const InputDecoration(
                          hintText: 'Enter new category',
                          labelStyle: TextStyle(color: Colors.green),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (_categoryController.text.isNotEmpty) {
                              setState(() {
                                categories.add(_categoryController.text);
                                _categoryController.clear();
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Add New Category'),
                style: TextButton.styleFrom(foregroundColor: Colors.green),
              ),
              const SizedBox(height: 16.0),

              // Image Upload
              Row(
                children: [
                  selectedMedia != null
                      ? Image.file(
                          File(selectedMedia!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Text('No media selected'),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _pickMedia,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Upload Media'),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Complaint Submitted')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
