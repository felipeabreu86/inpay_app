import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/images/background/bg_login.jpg'),
  fit: BoxFit.cover,
);

var maskTextTelefone = MaskTextInputFormatter(
    mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});