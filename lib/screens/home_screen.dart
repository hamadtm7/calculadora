import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../widgets/calc_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayText = '0';
  String _historyText = '';
  double? _firstOperand;
  String? _operator;
  bool _shouldResetDisplay = false;

  void _onDigitPressed(String digit) {
    setState(() {
      if (_displayText == '0' || _displayText == 'Error' || _shouldResetDisplay) {
        _displayText = digit;
        _shouldResetDisplay = false;
      } else {
        if (_displayText.length < 14) {
          _displayText += digit;
        }
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_displayText == 'Error' || _shouldResetDisplay) {
        _displayText = '0.';
        _shouldResetDisplay = false;
      } else if (!_displayText.contains('.')) {
        _displayText += '.';
      }
    });
  }

  void _onClearAllPressed() {
    setState(() {
      _displayText = '0';
      _historyText = '';
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = false;
    });
  }

  void _onClearOnePressed() {
    setState(() {
      if (_displayText == 'Error' || _shouldResetDisplay) {
        _displayText = '0';
      } else if (_displayText.length > 1) {
        _displayText = _displayText.substring(0, _displayText.length - 1);
        if (_displayText == '-') {
          _displayText = '0';
        }
      } else {
        _displayText = '0';
      }
    });
  }

  void _onToggleSignPressed() {
    setState(() {
      if (_displayText != '0' && _displayText != 'Error') {
        if (_displayText.startsWith('-')) {
          _displayText = _displayText.substring(1);
        } else {
          _displayText = '-$_displayText';
        }
      }
    });
  }

  void _onOperatorPressed(String op) {
    if (_displayText == 'Error') return;

    setState(() {
      if (_firstOperand == null) {
        _firstOperand = double.tryParse(_displayText) ?? 0.0;
        _operator = op;
        _historyText = '$_displayText $op';
        _shouldResetDisplay = true;
      } else if (!_shouldResetDisplay) {
        _calculateIntermediate();
        _operator = op;
        _historyText = '$_displayText $op';
        _shouldResetDisplay = true;
      } else {
        _operator = op;
        _historyText = '${_formatNumber(_firstOperand!)} $op';
      }
    });
  }

  void _calculateIntermediate() {
    if (_firstOperand == null || _operator == null) return;
    double secondOperand = double.tryParse(_displayText) ?? 0.0;

    if (_operator == '÷' && secondOperand == 0) {
      _displayText = 'Error';
      _firstOperand = null;
      _operator = null;
      return;
    }

    double result = 0.0;
    switch (_operator) {
      case '+':
        result = _firstOperand! + secondOperand;
        break;
      case '-':
        result = _firstOperand! - secondOperand;
        break;
      case '×':
        result = _firstOperand! * secondOperand;
        break;
      case '÷':
        result = _firstOperand! / secondOperand;
        break;
    }

    _displayText = _formatNumber(result);
    _firstOperand = result;
  }

  void _onEqualsPressed() {
    if (_firstOperand == null || _operator == null || _shouldResetDisplay) return;

    setState(() {
      double secondOperand = double.tryParse(_displayText) ?? 0.0;
      _historyText = '${_formatNumber(_firstOperand!)} $_operator $_displayText =';

      if (_operator == '÷' && secondOperand == 0) {
        _displayText = 'Error';
        _firstOperand = null;
        _operator = null;
        _shouldResetDisplay = true;
        return;
      }

      double result = 0.0;
      switch (_operator) {
        case '+':
          result = _firstOperand! + secondOperand;
          break;
        case '-':
          result = _firstOperand! - secondOperand;
          break;
        case '×':
          result = _firstOperand! * secondOperand;
          break;
        case '÷':
          result = _firstOperand! / secondOperand;
          break;
      }

      _displayText = _formatNumber(result);
      _firstOperand = null;
      _operator = null;
      _shouldResetDisplay = true;
    });
  }

  String _formatNumber(double number) {
    if (number.isInfinite || number.isNaN) {
      return 'Error';
    }
    if (number % 1 == 0) {
      return number.toInt().toString();
    }
    String str = number.toStringAsFixed(6);
    while (str.contains('.') && (str.endsWith('0') || str.endsWith('.'))) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    const operatorColor = Color(0xFF2563EB);
    const clearAllColor = Color(0xFFDC2626);
    const clearOneColor = Color(0xFFEA580C);
    const equalsColor = Color(0xFF10B981);
    const numColor = Color(0xFF262833);
    const utilColor = Color(0xFF374151);

    return Scaffold(
      backgroundColor: const Color(0xFF131417),
      appBar: AppBar(
        title: const Text(
          'Calculadora',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B1D22),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Información',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.info);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _historyText,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _displayText,
                        style: const TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Color(0xFF262833), height: 1),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            text: 'CE',
                            backgroundColor: clearAllColor,
                            onTap: _onClearAllPressed,
                          ),
                          CalcButton(
                            text: 'C',
                            backgroundColor: clearOneColor,
                            onTap: _onClearOnePressed,
                          ),
                          CalcButton(
                            text: '+/-',
                            backgroundColor: utilColor,
                            onTap: _onToggleSignPressed,
                          ),
                          CalcButton(
                            text: '÷',
                            backgroundColor: operatorColor,
                            onTap: () => _onOperatorPressed('÷'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            text: '7',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('7'),
                          ),
                          CalcButton(
                            text: '8',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('8'),
                          ),
                          CalcButton(
                            text: '9',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('9'),
                          ),
                          CalcButton(
                            text: '×',
                            backgroundColor: operatorColor,
                            onTap: () => _onOperatorPressed('×'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            text: '4',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('4'),
                          ),
                          CalcButton(
                            text: '5',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('5'),
                          ),
                          CalcButton(
                            text: '6',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('6'),
                          ),
                          CalcButton(
                            text: '-',
                            backgroundColor: operatorColor,
                            onTap: () => _onOperatorPressed('-'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            text: '1',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('1'),
                          ),
                          CalcButton(
                            text: '2',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('2'),
                          ),
                          CalcButton(
                            text: '3',
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('3'),
                          ),
                          CalcButton(
                            text: '+',
                            backgroundColor: operatorColor,
                            onTap: () => _onOperatorPressed('+'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            text: '0',
                            flex: 2,
                            backgroundColor: numColor,
                            onTap: () => _onDigitPressed('0'),
                          ),
                          CalcButton(
                            text: '.',
                            backgroundColor: numColor,
                            onTap: _onDecimalPressed,
                          ),
                          CalcButton(
                            text: '=',
                            backgroundColor: equalsColor,
                            onTap: _onEqualsPressed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
