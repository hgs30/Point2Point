
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE SCHEMA IF NOT EXISTS "task";

ALTER SCHEMA "task" OWNER TO "postgres";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  insert into public.profiles (id, full_name, avatar_url)
  values (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  return new;
end;
$$;

ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."country" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "offical_name" "text" NOT NULL,
    "code" "text" NOT NULL,
    "currency" bigint NOT NULL
);

ALTER TABLE "public"."country" OWNER TO "postgres";

ALTER TABLE "public"."country" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."country_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."currency" (
    "id" bigint NOT NULL,
    "code" "text" NOT NULL,
    "name" "text" NOT NULL,
    "symbol" "text" NOT NULL
);

ALTER TABLE "public"."currency" OWNER TO "postgres";

ALTER TABLE "public"."currency" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."currency_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "updated_at" timestamp with time zone,
    "username" "text",
    "full_name" "text",
    "avatar_url" "text",
    "website" "text",
    CONSTRAINT "username_length" CHECK (("char_length"("username") >= 3))
);

ALTER TABLE "public"."profiles" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "task"."tblScheduledTask" (
    "id" bigint NOT NULL,
    "params" "json",
    "scheduledAt" timestamp with time zone NOT NULL,
    "lastErrorMessage" "text",
    "taskType" bigint NOT NULL
);

ALTER TABLE "task"."tblScheduledTask" OWNER TO "postgres";

ALTER TABLE "task"."tblScheduledTask" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "task"."tblScheduledTask_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "task"."tblTaskType" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL
);

ALTER TABLE "task"."tblTaskType" OWNER TO "postgres";

ALTER TABLE "task"."tblTaskType" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "task"."tblTaskType_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY "public"."country"
    ADD CONSTRAINT "country_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."currency"
    ADD CONSTRAINT "currency_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_username_key" UNIQUE ("username");

ALTER TABLE ONLY "task"."tblScheduledTask"
    ADD CONSTRAINT "tblScheduledTask_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "task"."tblTaskType"
    ADD CONSTRAINT "tblTaskType_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."country"
    ADD CONSTRAINT "country_currency_fkey" FOREIGN KEY ("currency") REFERENCES "public"."currency"("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;

CREATE POLICY "Public profiles are viewable by everyone." ON "public"."profiles" FOR SELECT USING (true);

CREATE POLICY "Users can insert their own profile." ON "public"."profiles" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "id"));

CREATE POLICY "Users can update own profile." ON "public"."profiles" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "id"));

ALTER TABLE "public"."country" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."currency" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Enable read access for all users" ON "task"."tblScheduledTask" FOR SELECT USING (true);

ALTER TABLE "task"."tblScheduledTask" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "task"."tblTaskType" ENABLE ROW LEVEL SECURITY;

ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT USAGE ON SCHEMA "task" TO "anon";
GRANT USAGE ON SCHEMA "task" TO "authenticated";
GRANT USAGE ON SCHEMA "task" TO "service_role";

GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";

GRANT ALL ON TABLE "public"."country" TO "anon";
GRANT ALL ON TABLE "public"."country" TO "authenticated";
GRANT ALL ON TABLE "public"."country" TO "service_role";

GRANT ALL ON SEQUENCE "public"."country_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."country_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."country_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."currency" TO "anon";
GRANT ALL ON TABLE "public"."currency" TO "authenticated";
GRANT ALL ON TABLE "public"."currency" TO "service_role";

GRANT ALL ON SEQUENCE "public"."currency_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."currency_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."currency_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";

GRANT ALL ON TABLE "task"."tblScheduledTask" TO "anon";
GRANT ALL ON TABLE "task"."tblScheduledTask" TO "authenticated";
GRANT ALL ON TABLE "task"."tblScheduledTask" TO "service_role";

GRANT ALL ON SEQUENCE "task"."tblScheduledTask_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "task"."tblScheduledTask_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "task"."tblScheduledTask_id_seq" TO "service_role";

GRANT ALL ON TABLE "task"."tblTaskType" TO "anon";
GRANT ALL ON TABLE "task"."tblTaskType" TO "authenticated";
GRANT ALL ON TABLE "task"."tblTaskType" TO "service_role";

GRANT ALL ON SEQUENCE "task"."tblTaskType_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "task"."tblTaskType_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "task"."tblTaskType_id_seq" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "task" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
