// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Mock binary message handler control test', () async {
    // Initialize all bindings because defaultBinaryMessenger.send() needs a window.
    TestWidgetsFlutterBinding.ensureInitialized();

    final List<ByteData> log = <ByteData>[];

    defaultBinaryMessenger.setMockMessageHandler('test1', (ByteData message) async {
      log.add(message);
      return null;
    });

    final ByteData message = ByteData(2)..setUint16(0, 0xABCD);
    await defaultBinaryMessenger.send('test1', message);
    expect(log, equals(<ByteData>[message]));
    log.clear();

    defaultBinaryMessenger.setMockMessageHandler('test1', null);
    await defaultBinaryMessenger.send('test1', message);
    expect(log, isEmpty);
  });
}
