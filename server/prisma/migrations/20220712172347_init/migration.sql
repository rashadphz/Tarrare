/*
  Warnings:

  - Made the column `name` on table `Place` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Place" ALTER COLUMN "name" SET NOT NULL;
