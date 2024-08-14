DO $$ BEGIN
 CREATE TYPE "public"."priority" AS ENUM('critical', 'major', 'medium', 'small');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."status" AS ENUM('open', 'in_progress', 'resolved', 'closed');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bugs_table" (
	"id" serial PRIMARY KEY NOT NULL,
	"assignee" serial NOT NULL,
	"organization_id" serial NOT NULL,
	"title" text NOT NULL,
	"description" text NOT NULL,
	"small" "priority" NOT NULL,
	"open" "status" NOT NULL,
	"user_id" text,
	"email" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "organizations_table" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"plan_id" serial NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "plans_table" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"price" numeric NOT NULL,
	"description" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users_table" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"organization_id" serial NOT NULL,
	CONSTRAINT "users_table_email_unique" UNIQUE("email")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bugs_table" ADD CONSTRAINT "bugs_table_assignee_users_table_id_fk" FOREIGN KEY ("assignee") REFERENCES "public"."users_table"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bugs_table" ADD CONSTRAINT "bugs_table_organization_id_organizations_table_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations_table"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "organizations_table" ADD CONSTRAINT "organizations_table_plan_id_plans_table_id_fk" FOREIGN KEY ("plan_id") REFERENCES "public"."plans_table"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users_table" ADD CONSTRAINT "users_table_organization_id_organizations_table_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations_table"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
