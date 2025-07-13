import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static final String supabaseUrl = 'https:your-url';
  static final String supabaseAnonKey = 'anon-key';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }
}
