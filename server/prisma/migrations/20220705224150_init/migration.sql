/*
  Warnings:

  - You are about to drop the column `email_ending` on the `University` table. All the data in the column will be lost.
  - You are about to drop the column `full_name` on the `University` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "University" DROP COLUMN "email_ending",
DROP COLUMN "full_name",
ADD COLUMN     "emailEnding" TEXT,
ADD COLUMN     "fullName" TEXT;
