import 'package:bnotes/models/note.dart';
import 'package:bnotes/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class CardNote extends StatefulWidget {
  final List<String>? categoryList;
  final bool isEdit;
  final Note? noteModel;

  const CardNote(
      {Key? key,
      required this.isEdit,
      this.categoryList,
      this.noteModel})
      : super(key: key);

  @override
  _CardNoteState createState() => _CardNoteState();
}

class _CardNoteState extends State<CardNote> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  final _noteModel = Note();
  final _noteService = NoteService();

  // ignore: prefer_typing_uninitialized_variables
  late var _selectedItem;
  final DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    _setInitialValue();
    super.initState();
  }

  void _setInitialValue() {
    if(widget.isEdit) {
      _titleController.text = widget.noteModel!.title.toString();
      _descriptionController.text = widget.noteModel!.description.toString();
      _dateController.text = widget.noteModel!.dateTime.toString();
      _selectedItem = widget.noteModel!.isFinished.toString();
      debugPrint(_selectedItem);
    } else {
      _dateController.text = DateFormat("yyyy-MM-dd").format(_dateTime);
      _selectedItem = "Category";
    }
  }

  _selectDate(BuildContext context) async {
    var _pickDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickDate != null) {
      setState(() {
        // _dateController.text = DateFormat("d MMMM yyyy").format(_pickDate);
        _dateController.text = DateFormat("yyyy-MM-dd").format(_pickDate);
        debugPrint(_pickDate.toString());
      });
    }
  }

  bool _isNullField(String text) {
    if (text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  _saveNote() {
    _noteModel.title = _isNullField(_titleController.text) ? "no title" : _titleController.text;
    _noteModel.description = _isNullField(_descriptionController.text) ? "no description" : _descriptionController.text;
    _noteModel.category = _selectedItem.toString();
    _noteModel.dateTime = _dateController.text;
    _noteModel.isFinished = 0;
    _noteModel.isPrivate = 1;

    return _noteService.saveNote(_noteModel);
  }
  
  _updateNote() {
    _noteModel.id = widget.noteModel!.id;
    _noteModel.title = _isNullField(_titleController.text) ? "no title" : _titleController.text;
    _noteModel.description = _isNullField(_descriptionController.text) ? "no description" : _descriptionController.text;
    _noteModel.category = _selectedItem;
    _noteModel.dateTime = _dateController.text;
    _noteModel.isFinished = 0;
    _noteModel.isPrivate = 1;

    return _noteService.updateNote(_noteModel);
  }

  _showSnackBarMessage(message) {
    var snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.title),
            labelText: "Title",
            hintText: "Write the title",
          ),
        ),

        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            showSearchBox: true,
            items: widget.categoryList,
            label: "Category",
            hint: "Select Category",
            selectedItem: _selectedItem,
            onChanged: (val) {
              _selectedItem = val;
              debugPrint(_selectedItem);
            },
            dropdownSearchDecoration: const InputDecoration(
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.view_list),
            )
            // selectedItem: _selectedItem,
            ),

        //
        TextField(
          controller: _dateController,
          decoration: const InputDecoration(
            // prefixIcon: Icon(Icons.calendar_today),
            prefixIcon: Icon(Icons.calendar_today),
            labelText: "Pick a date",
            hintText: "YYYY-MM-DD",
          ),
          onTap: () {
            _selectDate(context);
          },
        ),
        TextField(
          controller: _descriptionController,
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 10,
          decoration: const InputDecoration(
            labelText: "Description",
            hintText: "Write the description",
          ),
        ),
        ElevatedButton(
          child: const Text("Save"),
          onPressed: () async {
            // ignore: prefer_typing_uninitialized_variables
            late var result;
            if (widget.isEdit) {
              result = await _updateNote();
            } else {
              result = await _saveNote();
            }

            if (result > 0) {
              _showSnackBarMessage(Text(widget.isEdit ? "Edited successfully!" : "Created successfully!"));
              await Future.delayed(const Duration(seconds: 1));
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
