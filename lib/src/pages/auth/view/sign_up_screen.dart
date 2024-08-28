import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/validator.dart.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

                  //Formulário

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                            validator: emailValidator,
                            textInputType: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                            validator: passwordValidator,
                            isSecret: true,
                          ),
                          CustomTextField(
                            icon: Icons.person,
                            validator: nameValidator,
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                            label: 'Nome',
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            validator: phoneValidator,
                            inputFormatters: [phoneFormatter],
                            textInputType: TextInputType.phone,
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                            validator: cpfValidator,
                            inputFormatters: [cpfFormatter],
                            textInputType: TextInputType.number,
                          ),

                          // Botão Cadastrar Usuário
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            authController.signUp();
                                          }
                                        },
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Cadastrar Usuário',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
