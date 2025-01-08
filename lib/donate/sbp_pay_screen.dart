import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class SbpPayScreen extends StatefulWidget {
  const SbpPayScreen({
 //   required this.paymentUrl,
    super.key,
  });
  final _paymentUrl =
      'https://sub.nspk.ru/';
     // 'https://b2b.cbrpay.ru/';
     // 'https://qr.nspk.ru/type=01';
    //  'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000007&crc=0C8A';

 // final String paymentUrl;

  @override
  State<SbpPayScreen> createState() => _SbpPayScreenState();
}

class _SbpPayScreenState extends State<SbpPayScreen>
    with WidgetsBindingObserver {
  late final ValueNotifier<Map<String, bool>> _statesMapNotifier;
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _statesMapNotifier = ValueNotifier<Map<String, bool>>(
      {'wasRestarted': false, 'wasTransited': false},
    );

    _lifecycleListener = AppLifecycleListener(
      onRestart: () {
        _statesMapNotifier.value = {
          'wasRestarted': true,
          'wasTransited': _statesMapNotifier.value['wasTransited'] ?? false,
        };
      },
    );

    _statesMapNotifier.addListener(() {
      final wasRestarted = _statesMapNotifier.value['wasRestarted'] ?? false;
      final wasTransited = _statesMapNotifier.value['wasTransited'] ?? false;
      if (wasRestarted && wasTransited) {
        Future.delayed(
          const Duration(seconds: 4),
              () {
            _statesMapNotifier.value = {
              'wasRestarted': false,
              'wasTransited': false,
            };
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _statesMapNotifier.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _statesMapNotifier,
          builder: (_, statesMap, __) {
            final wasRestarted = statesMap['wasRestarted'] ?? false;
            final wasTransited = statesMap['wasTransited'] ?? false;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Свернуто и открыто: $wasRestarted',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Переход в банк: $wasTransited',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            );
          },
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _statesMapNotifier,
          builder: (_, statesMap, __) {
            final wasRestarted = statesMap['wasRestarted'] ?? false;
            final wasTransited = statesMap['wasTransited'] ?? false;
            if (wasRestarted && wasTransited) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Имитация запроса для проверки оплаты заказа...',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 21),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }

            return FutureBuilder<List<BankItem>>(
              future: _getBankList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data ?? [];

                if (data.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Ошибка получения списка банков',
                          style: TextStyle(fontSize: 21),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _getBankList,
                          child: const Text(
                            'Повторить',
                            style: TextStyle(fontSize: 21),
                          ),
                        )
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: data.length,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final bank = data[index];

                    return InkWell(
                      onTap: () => _openBank(context, schema: bank.schema),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Image.network(
                                  bank.logoURL,
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    bank.bankName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _openBank(BuildContext context, {required String schema}) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

   final paymentUrl = widget._paymentUrl.replaceAll(RegExp('https://'), '');
   final link = '$schema://$paymentUrl';
    //final link = schema;

    try {
      final wasLaunched = await launchUrlString(
        link,
        mode: LaunchMode.externalApplication,
      );

      if (!mounted) return;
      _statesMapNotifier.value = {
        'wasRestarted': false,
        'wasTransited': wasLaunched,
      };
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Такого банка нет')),
      );
    }
  }

  Future<List<BankItem>> _getBankList() async {
    try {
      final response = await http.get(
        Uri.parse('https://qr.nspk.ru/proxyapp/c2bmembers.json'),
      );

      final decodedMap = jsonDecode(response.body) as Map<String, dynamic>;
      final bankList = decodedMap['dictionary'] as List;
      final mappedList = <BankItem>[];

      for (final item in bankList) {
        final bankName = item['bankName'] as String?;
        final logoURL = item['logoURL'] as String?;
        final schema = item['schema'] as String?;

        if (schema == null || logoURL == null || bankName == null) continue;
        if (schema.isEmpty || logoURL.isEmpty || bankName.isEmpty) continue;

        mappedList.add(
          BankItem(
            bankName: utf8.decode(bankName.codeUnits),
            logoURL: logoURL,
            schema: schema,
          ),
        );
      }

      return mappedList;
    } on Object {
      return <BankItem>[];
    }
  }
}

class BankItem {
  const BankItem({
    required this.bankName,
    required this.logoURL,
    required this.schema,
  });

  final String bankName;
  final String logoURL;
  final String schema;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BankItem &&
              runtimeType == other.runtimeType &&
              bankName == other.bankName &&
              logoURL == other.logoURL &&
              schema == other.schema;

  @override
  int get hashCode => bankName.hashCode ^ logoURL.hashCode ^ schema.hashCode;
}