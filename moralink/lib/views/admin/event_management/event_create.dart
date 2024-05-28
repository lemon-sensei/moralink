import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/models/event_category.dart';
import 'package:moralink/repositories/event_repository.dart';
import 'event_create_confirmation.dart';

class EventCreateAdmin extends StatefulWidget {
  const EventCreateAdmin({super.key});

  @override
  _EventCreateAdminState createState() => _EventCreateAdminState();
}

class _EventCreateAdminState extends State<EventCreateAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _locationNameController = TextEditingController();
  final _locationAddressController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  EventCategory? _category;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    _locationNameController.dispose();
    _locationAddressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _startDate != null &&
        _endDate != null) {
      final event = Event(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        thumbnail: _thumbnailController.text,
        startDate: _startDate!,
        endDate: _endDate!,
        locationName: _locationNameController.text,
        locationAddress: _locationAddressController.text,
        locationLat: double.parse(_latitudeController.text),
        locationLong: double.parse(_longitudeController.text),
        category: _category!,
        registeredUsers: [],
      );

      final eventRepository = EventRepository();
      await eventRepository.addEvent(event);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConfirmationScreen()),
      );
    } else {
      if (_startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a start date'),
          ),
        );
      }
      if (_endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an end date'),
          ),
        );
      }
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _thumbnailController,
                  decoration: const InputDecoration(
                    labelText: 'Thumbnail image URL',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a URL to thumbnail image';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationNameController,
                  decoration: const InputDecoration(
                    labelText: 'Location Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Location Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _latitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a latitude';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _longitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a longitude';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<EventCategory>(
                  value: _category,
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                  items: EventCategory.values
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  ))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Event Category',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: const Text('Start Date'),
                  subtitle: _startDate != null
                      ? Text(_startDate.toString())
                      : const Text('Select a start date'),
                  onTap: () => _selectStartDate(context),
                ),
                ListTile(
                  title: const Text('End Date'),
                  subtitle: _endDate != null
                      ? Text(_endDate.toString())
                      : const Text('Select an end date'),
                  onTap: () => _selectEndDate(context),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}