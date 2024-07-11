import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/alert/alert.dart';
import 'package:mobile/core/services/calendar_service.dart';
import 'package:mobile/signature/bloc/sign_bloc.dart';
import 'package:mobile/signature/bloc/sign_event.dart';
import 'package:mobile/signature/bloc/sign_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key, required this.id});
  final int id;

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  final password = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    password.dispose();
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((scanData) {
        print('Scanned data: ${scanData.code}');
        context.read<SignBloc>().add(
              Sign(scanData.code ?? ''),
            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SignBloc(CalendarService(), widget.id),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(72, 2, 151, 1),
                    Color.fromRGBO(51, 2, 108, 1),
                  ],
                ),
              ),
              child: BlocBuilder<SignBloc, SignState>(
                builder: (context, state) {
                  if (state is SignInitial) {
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: QRView(
                              key: _qrKey,
                              onQRViewCreated: (QRViewController controller) {
                                _onQRViewCreated(context, controller);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SignError) {
                    return const Alert();
                  }

                  if (state is SignLoaded) {
                    GoRouter.of(context).pop('/calendar/${widget.id}');
                  }

                  if (state is SignLoading) {
                    return const Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        SizedBox(
                          height: 48,
                        ),
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      ],
                    );
                  }

                  return Text("AAAA");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
