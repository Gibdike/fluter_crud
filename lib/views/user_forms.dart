import 'package:fluter_crud/models/user.dart';
import 'package:fluter_crud/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['email'] = user.email;
      _formData['name'] = user.name;
      _formData['avatarUrl'] = user.avatarUrl;
      _formData['senha'] = user.senha;
      _formData['validade'] = user.validade;
      _formData['armario'] = user.armario;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState.validate();
              if (isValid) {
                setState(() {
                  _isLoading = true;
                });
                _form.currentState.save();
                await Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                    senha: _formData['senha'],
                    validade: _formData['validade'],
                    armario: _formData['armario'],
                  ),
                );
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: _formData['name'],
                          decoration: InputDecoration(
                            labelText: 'nome',
                          ),
                          //validator: (value) {
                          //if (value == null || value.isEmpty) {
                          //return 'Digite um nome valido';
                          //}
                          //},
                          onSaved: (value) => _formData['name'] = value,
                        ),
                        TextFormField(
                          initialValue: _formData['email'],
                          decoration: InputDecoration(
                            labelText: 'email',
                          ),
                          onSaved: (value) => _formData['email'] = value,
                        ),
                        TextFormField(
                          initialValue: _formData['senha'],
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Apenas numeros',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => _formData['senha'] = value,
                        ),
                        TextFormField(
                          initialValue: _formData['validade'],
                          decoration: InputDecoration(
                            labelText: 'Validade',
                            hintText: 'Digite em quatidade de dias',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => _formData['validade'] = value,
                        ),
                        TextFormField(
                          initialValue: _formData['armario'],
                          decoration: InputDecoration(
                            labelText: 'Armario',
                            hintText: 'Separe com " , " caso for mais de um',
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) => _formData['armario'] = value,
                        ),
                        TextFormField(
                          initialValue: _formData['avatarUrl'],
                          decoration: InputDecoration(
                            labelText: 'Url do Avatar',
                          ),
                          onSaved: (value) => _formData['avatarUrl'] = value,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
