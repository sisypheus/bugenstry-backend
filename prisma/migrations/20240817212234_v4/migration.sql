/*
  Warnings:

  - You are about to drop the column `user_id` on the `bugs` table. All the data in the column will be lost.
  - The primary key for the `organizations` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `profiles` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE "public"."bugs" DROP CONSTRAINT "bugs_assignee_profiles_id_fk";

-- DropForeignKey
ALTER TABLE "public"."bugs" DROP CONSTRAINT "bugs_organization_id_organizations_id_fk";

-- DropForeignKey
ALTER TABLE "public"."profiles" DROP CONSTRAINT "profiles_organization_id_organizations_id_fk";

-- AlterTable
ALTER TABLE "public"."bugs" DROP COLUMN "user_id",
ADD COLUMN     "reporter_id" TEXT,
ALTER COLUMN "assignee" SET DATA TYPE TEXT,
ALTER COLUMN "organization_id" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "public"."organizations" DROP CONSTRAINT "organizations_table_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "plan_id" DROP DEFAULT,
ADD CONSTRAINT "organizations_table_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "organizations_id_seq";
DROP SEQUENCE "organizations_plan_id_seq";

-- AlterTable
ALTER TABLE "public"."profiles" DROP CONSTRAINT "profiles_table_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "organization_id" DROP NOT NULL,
ALTER COLUMN "organization_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "profiles_table_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "profiles_id_seq";

-- CreateTable
CREATE TABLE "public"."invites" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "invites_table_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "invites_token_unique" ON "public"."invites"("token");

-- AddForeignKey
ALTER TABLE "public"."bugs" ADD CONSTRAINT "bugs_assignee_profiles_id_fk" FOREIGN KEY ("assignee") REFERENCES "public"."profiles"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."bugs" ADD CONSTRAINT "bugs_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "public"."profiles" ADD CONSTRAINT "profiles_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."invites" ADD CONSTRAINT "invites_organization_id_organizations_id_fk" FOREIGN KEY ("organizationId") REFERENCES "public"."organizations"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
