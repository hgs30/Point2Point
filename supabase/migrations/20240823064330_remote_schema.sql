alter table "public"."country" drop column "offical_name";

alter table "public"."country" add column "official_name" text not null;


