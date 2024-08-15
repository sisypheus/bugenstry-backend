/*
  Warnings:

  - You are about to drop the column `open` on the `bugs` table. All the data in the column will be lost.
  - You are about to drop the column `small` on the `bugs` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."bugs" DROP COLUMN "open",
DROP COLUMN "small",
ADD COLUMN     "priority" "public"."Priority" NOT NULL DEFAULT 'small',
ADD COLUMN     "status" "public"."Status" NOT NULL DEFAULT 'open',
ALTER COLUMN "assignee" DROP NOT NULL;
