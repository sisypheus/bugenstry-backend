-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('critical', 'major', 'medium', 'small');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('open', 'in_progress', 'resolved', 'closed');

-- CreateTable
CREATE TABLE "Bugs" (
    "id" SERIAL NOT NULL,
    "assignee" INTEGER NOT NULL,
    "organization_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "small" "Priority" NOT NULL,
    "open" "Status" NOT NULL,
    "user_id" TEXT,
    "email" TEXT,

    CONSTRAINT "bugs_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Organizations" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "plan_id" SERIAL NOT NULL,

    CONSTRAINT "organizations_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Plans" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "price" DECIMAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "plans_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "organization_id" INTEGER NOT NULL,

    CONSTRAINT "users_table_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_unique" ON "Users"("email");

-- AddForeignKey
ALTER TABLE "Bugs" ADD CONSTRAINT "bugs_assignee_users_id_fk" FOREIGN KEY ("assignee") REFERENCES "Users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Bugs" ADD CONSTRAINT "bugs_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "Organizations"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Organizations" ADD CONSTRAINT "organizations_plan_id_plans_id_fk" FOREIGN KEY ("plan_id") REFERENCES "Plans"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "users_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "Organizations"("id") ON DELETE CASCADE ON UPDATE CASCADE;
