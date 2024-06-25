import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/models/event_category.dart';
import 'package:moralink/repositories/event_repository.dart';
import '../../../models/user_role.dart';
import '../../../shared/widgets/responsive_layout.dart';
import '../../../themes/text_styles.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import 'event_create_confirmation.dart';

class EventEditAdmin extends StatefulWidget {
  final String eventId;

  const EventEditAdmin({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventEditAdminState createState() => _EventEditAdminState();
}

class _EventEditAdminState extends State<EventEditAdmin> {
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

  bool _isLoading = true;
  bool _isSubmitting = false;
  late Event _event;

  @override
  void initState() {
    super.initState();
    _checkAdmin();
    _loadEventData();
  }

  Future<void> _checkAdmin() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.currentUser?.role != UserRole.admin) {
      context.go('/home');
    }
  }

  Future<void> _loadEventData() async {
    final eventRepository = EventRepository();
    _event = await eventRepository.fetchEventById(widget.eventId);

    _titleController.text = _event.title;
    _descriptionController.text = _event.description;
    _thumbnailController.text = _event.thumbnail;
    _locationNameController.text = _event.locationName;
    _locationAddressController.text = _event.locationAddress;
    _latitudeController.text = _event.locationLat.toString();
    _longitudeController.text = _event.locationLong.toString();
    _startDate = _event.startDate;
    _endDate = _event.endDate;
    _category = _event.category;

    setState(() {
      _isLoading = false;
    });
  }

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
      setState(() {
        _isSubmitting = true;
      });

      final updatedEvent = Event(
        id: _event.id,
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
        registeredUsers: _event.registeredUsers,
        attendedUsers: _event.attendedUsers,
      );

      final eventRepository = EventRepository();
      await eventRepository.updateEvent(updatedEvent);

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event updated successfully')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ConfirmationScreen()),
      );
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
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
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ResponsiveLayout(
              mobileBody: _buildMobileBody(textTheme),
              tabletBody: _buildTabletBody(textTheme),
              desktopBody: _buildDesktopBody(textTheme),
            ),
    );
  }

  Widget _buildMobileBody(TextTheme textTheme) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                minLines: 5,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _thumbnailController,
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Thumbnail image URL',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL to thumbnail image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationNameController,
                decoration: InputDecoration(
                  labelText: 'Location Name',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationAddressController,
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Location Address',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                          child: Text(
                            category.name,
                            style: textTheme.bodyLarge,
                          ),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Event Category',
                  labelStyle: textTheme.bodyMedium,
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(
                  'Start Date',
                  style: textTheme.bodyLarge,
                ),
                subtitle: _startDate != null
                    ? Text(
                        _startDate.toString(),
                        style: textTheme.bodyMedium,
                      )
                    : Text(
                        'Select a start date',
                        style: textTheme.bodyMedium,
                      ),
                onTap: () => _selectStartDate(context),
              ),
              ListTile(
                title: Text(
                  'End Date',
                  style: textTheme.bodyLarge,
                ),
                subtitle: _endDate != null
                    ? Text(
                        _endDate.toString(),
                        style: textTheme.bodyMedium,
                      )
                    : Text(
                        'Select an end date',
                        style: textTheme.bodyMedium,
                      ),
                onTap: () => _selectEndDate(context),
              ),
              const SizedBox(
                height: 30,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return _isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(
                            'Submit',
                            style: textTheme.bodyLarge,
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletBody(TextTheme textTheme) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                minLines: 5,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _thumbnailController,
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Thumbnail image URL',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL to thumbnail image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationNameController,
                decoration: InputDecoration(
                  labelText: 'Location Name',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationAddressController,
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                  labelText: 'Location Address',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: textTheme.bodyMedium,
                ),
                style: textTheme.bodyLarge,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                          child: Text(
                            category.name,
                            style: textTheme.bodyLarge,
                          ),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Event Category',
                  labelStyle: textTheme.bodyMedium,
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(
                  'Start Date',
                  style: textTheme.bodyLarge,
                ),
                subtitle: _startDate != null
                    ? Text(
                        _startDate.toString(),
                        style: textTheme.bodyMedium,
                      )
                    : Text(
                        'Select a start date',
                        style: textTheme.bodyMedium,
                      ),
                onTap: () => _selectStartDate(context),
              ),
              ListTile(
                title: Text(
                  'End Date',
                  style: textTheme.bodyLarge,
                ),
                subtitle: _endDate != null
                    ? Text(
                        _endDate.toString(),
                        style: textTheme.bodyMedium,
                      )
                    : Text(
                        'Select an end date',
                        style: textTheme.bodyMedium,
                      ),
                onTap: () => _selectEndDate(context),
              ),
              const SizedBox(
                height: 30,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return _isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(
                            'Submit',
                            style: textTheme.bodyLarge,
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBody(TextTheme textTheme) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Event',
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _titleController,
                      minLines: 2,
                      maxLines: 100,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 5,
                      maxLines: 100,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _thumbnailController,
                      minLines: 2,
                      maxLines: 100,
                      decoration: InputDecoration(
                        labelText: 'Thumbnail image URL',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a URL to thumbnail image';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location Details',
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _locationNameController,
                      decoration: InputDecoration(
                        labelText: 'Location Name',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _locationAddressController,
                      minLines: 2,
                      maxLines: 100,
                      decoration: InputDecoration(
                        labelText: 'Location Address',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _latitudeController,
                      decoration: InputDecoration(
                        labelText: 'Latitude',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a latitude';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _longitudeController,
                      decoration: InputDecoration(
                        labelText: 'Longitude',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      style: textTheme.bodyLarge,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a longitude';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date and Category',
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16.0),
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
                                child: Text(
                                  category.name,
                                  style: textTheme.bodyLarge,
                                ),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Event Category',
                        labelStyle: textTheme.bodyMedium,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Start Date',
                        style: textTheme.bodyLarge,
                      ),
                      subtitle: _startDate != null
                          ? Text(
                              _startDate.toString(),
                              style: textTheme.bodyMedium,
                            )
                          : Text(
                              'Select a start date',
                              style: textTheme.bodyMedium,
                            ),
                      onTap: () => _selectStartDate(context),
                    ),
                    ListTile(
                      title: Text(
                        'End Date',
                        style: textTheme.bodyLarge,
                      ),
                      subtitle: _endDate != null
                          ? Text(
                              _endDate.toString(),
                              style: textTheme.bodyMedium,
                            )
                          : Text(
                              'Select an end date',
                              style: textTheme.bodyMedium,
                            ),
                      onTap: () => _selectEndDate(context),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return _isSubmitting
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _submitForm,
                                child: Text(
                                  'Submit',
                                  style: textTheme.bodyLarge,
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
