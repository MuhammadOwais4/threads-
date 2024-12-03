import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  static Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() async {
    await Supabase.initialize(
      url: "https://dtwtczjbyoedojzlzoad.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR0d3RjempieW9lZG9qemx6b2FkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA0NjI1NTQsImV4cCI6MjA0NjAzODU1NH0.4VETKkdgpPiDcSu8CGwJshT35Kbmxpsu0aQznnlKwgw",
    );
    currentUser.value = client.auth.currentUser;
    listenAuthChanges();
    super.onInit();
  }

  static final SupabaseClient client = Supabase.instance.client;

  void listenAuthChanges() {
    client.auth.onAuthStateChange.listen(
      (data) {
        final AuthChangeEvent event = data.event;
        if (event == AuthChangeEvent.userUpdated) {
          currentUser.value = data.session?.user;
        } else if (event == AuthChangeEvent.signedIn) {
          currentUser.value = data.session?.user;
        }
      },
    );
  }
}
