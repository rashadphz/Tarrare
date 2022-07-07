/*
  Warnings:

  - Made the column `dateCreated` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `emailVerified` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "password" TEXT,
ALTER COLUMN "dateCreated" SET NOT NULL,
ALTER COLUMN "emailVerified" SET NOT NULL;
