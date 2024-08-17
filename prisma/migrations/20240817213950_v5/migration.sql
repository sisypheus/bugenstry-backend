-- AlterTable
ALTER TABLE "public"."profiles" ADD COLUMN     "role" "public"."Role" NOT NULL DEFAULT 'user';
