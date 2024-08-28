create table "public"."airport" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "code" text not null,
    "city" bigint not null
);


alter table "public"."airport" enable row level security;

create table "public"."fare" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "display_rank" bigint not null
);


alter table "public"."fare" enable row level security;

create table "public"."fare_mapping" (
    "id" bigint generated by default as identity not null,
    "program" bigint not null,
    "fare" bigint not null,
    "code" text not null
);


alter table "public"."fare_mapping" enable row level security;

create table "public"."reward_flight" (
    "id" bigint generated by default as identity not null,
    "program" bigint not null,
    "route" bigint not null,
    "points" numeric not null,
    "taxes" numeric not null,
    "currency" bigint not null,
    "date" timestamp with time zone not null,
    "created_at" timestamp with time zone not null default now()
);


alter table "public"."reward_flight" enable row level security;

create table "public"."reward_program" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "units" text not null
);


alter table "public"."reward_program" enable row level security;

create table "public"."route" (
    "id" bigint generated by default as identity not null,
    "departing" bigint not null,
    "arriving" bigint not null
);


alter table "public"."route" enable row level security;

CREATE UNIQUE INDEX airport_pkey ON public.airport USING btree (id);

CREATE UNIQUE INDEX fare_mapping_pkey ON public.fare_mapping USING btree (id);

CREATE UNIQUE INDEX fare_pkey ON public.fare USING btree (id);

CREATE UNIQUE INDEX reward_flight_pkey ON public.reward_flight USING btree (id);

CREATE UNIQUE INDEX reward_program_pkey ON public.reward_program USING btree (id);

CREATE UNIQUE INDEX route_pkey ON public.route USING btree (id);

alter table "public"."airport" add constraint "airport_pkey" PRIMARY KEY using index "airport_pkey";

alter table "public"."fare" add constraint "fare_pkey" PRIMARY KEY using index "fare_pkey";

alter table "public"."fare_mapping" add constraint "fare_mapping_pkey" PRIMARY KEY using index "fare_mapping_pkey";

alter table "public"."reward_flight" add constraint "reward_flight_pkey" PRIMARY KEY using index "reward_flight_pkey";

alter table "public"."reward_program" add constraint "reward_program_pkey" PRIMARY KEY using index "reward_program_pkey";

alter table "public"."route" add constraint "route_pkey" PRIMARY KEY using index "route_pkey";

alter table "public"."airport" add constraint "airport_city_fkey" FOREIGN KEY (city) REFERENCES city(id) not valid;

alter table "public"."airport" validate constraint "airport_city_fkey";

alter table "public"."fare_mapping" add constraint "fare_mapping_fare_fkey" FOREIGN KEY (fare) REFERENCES fare(id) not valid;

alter table "public"."fare_mapping" validate constraint "fare_mapping_fare_fkey";

alter table "public"."fare_mapping" add constraint "fare_mapping_program_fkey" FOREIGN KEY (program) REFERENCES reward_program(id) not valid;

alter table "public"."fare_mapping" validate constraint "fare_mapping_program_fkey";

alter table "public"."reward_flight" add constraint "reward_flight_currency_fkey" FOREIGN KEY (currency) REFERENCES currency(id) not valid;

alter table "public"."reward_flight" validate constraint "reward_flight_currency_fkey";

alter table "public"."reward_flight" add constraint "reward_flight_program_fkey" FOREIGN KEY (program) REFERENCES reward_program(id) not valid;

alter table "public"."reward_flight" validate constraint "reward_flight_program_fkey";

alter table "public"."reward_flight" add constraint "reward_flight_route_fkey" FOREIGN KEY (route) REFERENCES route(id) not valid;

alter table "public"."reward_flight" validate constraint "reward_flight_route_fkey";

alter table "public"."route" add constraint "route_arriving_fkey" FOREIGN KEY (arriving) REFERENCES airport(id) not valid;

alter table "public"."route" validate constraint "route_arriving_fkey";

alter table "public"."route" add constraint "route_departing_fkey" FOREIGN KEY (departing) REFERENCES airport(id) not valid;

alter table "public"."route" validate constraint "route_departing_fkey";

grant delete on table "public"."airport" to "anon";

grant insert on table "public"."airport" to "anon";

grant references on table "public"."airport" to "anon";

grant select on table "public"."airport" to "anon";

grant trigger on table "public"."airport" to "anon";

grant truncate on table "public"."airport" to "anon";

grant update on table "public"."airport" to "anon";

grant delete on table "public"."airport" to "authenticated";

grant insert on table "public"."airport" to "authenticated";

grant references on table "public"."airport" to "authenticated";

grant select on table "public"."airport" to "authenticated";

grant trigger on table "public"."airport" to "authenticated";

grant truncate on table "public"."airport" to "authenticated";

grant update on table "public"."airport" to "authenticated";

grant delete on table "public"."airport" to "service_role";

grant insert on table "public"."airport" to "service_role";

grant references on table "public"."airport" to "service_role";

grant select on table "public"."airport" to "service_role";

grant trigger on table "public"."airport" to "service_role";

grant truncate on table "public"."airport" to "service_role";

grant update on table "public"."airport" to "service_role";

grant delete on table "public"."fare" to "anon";

grant insert on table "public"."fare" to "anon";

grant references on table "public"."fare" to "anon";

grant select on table "public"."fare" to "anon";

grant trigger on table "public"."fare" to "anon";

grant truncate on table "public"."fare" to "anon";

grant update on table "public"."fare" to "anon";

grant delete on table "public"."fare" to "authenticated";

grant insert on table "public"."fare" to "authenticated";

grant references on table "public"."fare" to "authenticated";

grant select on table "public"."fare" to "authenticated";

grant trigger on table "public"."fare" to "authenticated";

grant truncate on table "public"."fare" to "authenticated";

grant update on table "public"."fare" to "authenticated";

grant delete on table "public"."fare" to "service_role";

grant insert on table "public"."fare" to "service_role";

grant references on table "public"."fare" to "service_role";

grant select on table "public"."fare" to "service_role";

grant trigger on table "public"."fare" to "service_role";

grant truncate on table "public"."fare" to "service_role";

grant update on table "public"."fare" to "service_role";

grant delete on table "public"."fare_mapping" to "anon";

grant insert on table "public"."fare_mapping" to "anon";

grant references on table "public"."fare_mapping" to "anon";

grant select on table "public"."fare_mapping" to "anon";

grant trigger on table "public"."fare_mapping" to "anon";

grant truncate on table "public"."fare_mapping" to "anon";

grant update on table "public"."fare_mapping" to "anon";

grant delete on table "public"."fare_mapping" to "authenticated";

grant insert on table "public"."fare_mapping" to "authenticated";

grant references on table "public"."fare_mapping" to "authenticated";

grant select on table "public"."fare_mapping" to "authenticated";

grant trigger on table "public"."fare_mapping" to "authenticated";

grant truncate on table "public"."fare_mapping" to "authenticated";

grant update on table "public"."fare_mapping" to "authenticated";

grant delete on table "public"."fare_mapping" to "service_role";

grant insert on table "public"."fare_mapping" to "service_role";

grant references on table "public"."fare_mapping" to "service_role";

grant select on table "public"."fare_mapping" to "service_role";

grant trigger on table "public"."fare_mapping" to "service_role";

grant truncate on table "public"."fare_mapping" to "service_role";

grant update on table "public"."fare_mapping" to "service_role";

grant delete on table "public"."reward_flight" to "anon";

grant insert on table "public"."reward_flight" to "anon";

grant references on table "public"."reward_flight" to "anon";

grant select on table "public"."reward_flight" to "anon";

grant trigger on table "public"."reward_flight" to "anon";

grant truncate on table "public"."reward_flight" to "anon";

grant update on table "public"."reward_flight" to "anon";

grant delete on table "public"."reward_flight" to "authenticated";

grant insert on table "public"."reward_flight" to "authenticated";

grant references on table "public"."reward_flight" to "authenticated";

grant select on table "public"."reward_flight" to "authenticated";

grant trigger on table "public"."reward_flight" to "authenticated";

grant truncate on table "public"."reward_flight" to "authenticated";

grant update on table "public"."reward_flight" to "authenticated";

grant delete on table "public"."reward_flight" to "service_role";

grant insert on table "public"."reward_flight" to "service_role";

grant references on table "public"."reward_flight" to "service_role";

grant select on table "public"."reward_flight" to "service_role";

grant trigger on table "public"."reward_flight" to "service_role";

grant truncate on table "public"."reward_flight" to "service_role";

grant update on table "public"."reward_flight" to "service_role";

grant delete on table "public"."reward_program" to "anon";

grant insert on table "public"."reward_program" to "anon";

grant references on table "public"."reward_program" to "anon";

grant select on table "public"."reward_program" to "anon";

grant trigger on table "public"."reward_program" to "anon";

grant truncate on table "public"."reward_program" to "anon";

grant update on table "public"."reward_program" to "anon";

grant delete on table "public"."reward_program" to "authenticated";

grant insert on table "public"."reward_program" to "authenticated";

grant references on table "public"."reward_program" to "authenticated";

grant select on table "public"."reward_program" to "authenticated";

grant trigger on table "public"."reward_program" to "authenticated";

grant truncate on table "public"."reward_program" to "authenticated";

grant update on table "public"."reward_program" to "authenticated";

grant delete on table "public"."reward_program" to "service_role";

grant insert on table "public"."reward_program" to "service_role";

grant references on table "public"."reward_program" to "service_role";

grant select on table "public"."reward_program" to "service_role";

grant trigger on table "public"."reward_program" to "service_role";

grant truncate on table "public"."reward_program" to "service_role";

grant update on table "public"."reward_program" to "service_role";

grant delete on table "public"."route" to "anon";

grant insert on table "public"."route" to "anon";

grant references on table "public"."route" to "anon";

grant select on table "public"."route" to "anon";

grant trigger on table "public"."route" to "anon";

grant truncate on table "public"."route" to "anon";

grant update on table "public"."route" to "anon";

grant delete on table "public"."route" to "authenticated";

grant insert on table "public"."route" to "authenticated";

grant references on table "public"."route" to "authenticated";

grant select on table "public"."route" to "authenticated";

grant trigger on table "public"."route" to "authenticated";

grant truncate on table "public"."route" to "authenticated";

grant update on table "public"."route" to "authenticated";

grant delete on table "public"."route" to "service_role";

grant insert on table "public"."route" to "service_role";

grant references on table "public"."route" to "service_role";

grant select on table "public"."route" to "service_role";

grant trigger on table "public"."route" to "service_role";

grant truncate on table "public"."route" to "service_role";

grant update on table "public"."route" to "service_role";


