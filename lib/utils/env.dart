import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String supaBaseProjectUrl = dotenv.env["SUPABASE_PROJECT_URL"]!;
  static final String supaBaseApiKey = dotenv.env["SUPABASE_API_KEY"]!;
  static final String supaBaseBucketName = dotenv.env["SUPABASE_BUCKET_NAME"]!;
}
