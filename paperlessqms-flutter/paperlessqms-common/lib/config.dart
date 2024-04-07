import 'package:flutter/foundation.dart';

const String protocol = kReleaseMode? 'https': 'http';
const String domainName = kReleaseMode? 'sample.co:8080': '127.0.0.1:8080';
const String domainWheref = kReleaseMode? 'wheref.com': '127.0.0.1:9090';