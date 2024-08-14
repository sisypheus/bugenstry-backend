ALTER TABLE "bugs_table" RENAME TO "bugs";--> statement-breakpoint
ALTER TABLE "organizations_table" RENAME TO "organizations";--> statement-breakpoint
ALTER TABLE "plans_table" RENAME TO "plans";--> statement-breakpoint
ALTER TABLE "users_table" RENAME TO "users";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_table_email_unique";--> statement-breakpoint
ALTER TABLE "bugs" DROP CONSTRAINT "bugs_table_assignee_users_table_id_fk";
--> statement-breakpoint
ALTER TABLE "bugs" DROP CONSTRAINT "bugs_table_organization_id_organizations_table_id_fk";
--> statement-breakpoint
ALTER TABLE "organizations" DROP CONSTRAINT "organizations_table_plan_id_plans_table_id_fk";
--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_table_organization_id_organizations_table_id_fk";
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bugs" ADD CONSTRAINT "bugs_assignee_users_id_fk" FOREIGN KEY ("assignee") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bugs" ADD CONSTRAINT "bugs_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "organizations" ADD CONSTRAINT "organizations_plan_id_plans_id_fk" FOREIGN KEY ("plan_id") REFERENCES "public"."plans"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users" ADD CONSTRAINT "users_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");