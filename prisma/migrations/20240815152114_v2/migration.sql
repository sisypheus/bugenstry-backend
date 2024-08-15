/*
  Warnings:

  - You are about to drop the `Bugs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Organizations` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Plans` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Users` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "auth";

-- CreateEnum
CREATE TYPE "public"."Role" AS ENUM ('admin', 'user');

-- DropForeignKey
ALTER TABLE "public"."Bugs" DROP CONSTRAINT "bugs_assignee_users_id_fk";

-- DropForeignKey
ALTER TABLE "public"."Bugs" DROP CONSTRAINT "bugs_organization_id_organizations_id_fk";

-- DropForeignKey
ALTER TABLE "public"."Organizations" DROP CONSTRAINT "organizations_plan_id_plans_id_fk";

-- DropForeignKey
ALTER TABLE "public"."Users" DROP CONSTRAINT "users_organization_id_organizations_id_fk";

-- DropTable
DROP TABLE "public"."Bugs";

-- DropTable
DROP TABLE "public"."Organizations";

-- DropTable
DROP TABLE "public"."Plans";

-- DropTable
DROP TABLE "public"."Users";

-- CreateTable
CREATE TABLE "public"."bugs" (
    "id" SERIAL NOT NULL,
    "assignee" INTEGER NOT NULL,
    "organization_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "small" "public"."Priority" NOT NULL,
    "open" "public"."Status" NOT NULL,
    "user_id" TEXT,
    "email" TEXT,

    CONSTRAINT "bugs_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."organizations" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "plan_id" SERIAL NOT NULL,

    CONSTRAINT "organizations_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."plans" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "price" DECIMAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "plans_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."profiles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "organization_id" INTEGER NOT NULL,

    CONSTRAINT "profiles_table_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "profiles_email_unique" ON "public"."profiles"("email");

-- AddForeignKey
ALTER TABLE "public"."bugs" ADD CONSTRAINT "bugs_assignee_profiles_id_fk" FOREIGN KEY ("assignee") REFERENCES "public"."profiles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."bugs" ADD CONSTRAINT "bugs_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."organizations" ADD CONSTRAINT "organizations_plan_id_plans_id_fk" FOREIGN KEY ("plan_id") REFERENCES "public"."plans"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."profiles" ADD CONSTRAINT "profiles_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE CASCADE ON UPDATE CASCADE;
