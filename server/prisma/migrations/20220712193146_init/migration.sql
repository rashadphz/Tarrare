/*
  Warnings:

  - The values [inProgress] on the enum `Status` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Status_new" AS ENUM ('placed', 'matched', 'complete', 'cancelled');
ALTER TABLE "Order" ALTER COLUMN "orderStatus" DROP DEFAULT;
ALTER TABLE "Delivery" ALTER COLUMN "orderStatus" DROP DEFAULT;
ALTER TABLE "Order" ALTER COLUMN "orderStatus" TYPE "Status_new" USING ("orderStatus"::text::"Status_new");
ALTER TABLE "Delivery" ALTER COLUMN "orderStatus" TYPE "Status_new" USING ("orderStatus"::text::"Status_new");
ALTER TYPE "Status" RENAME TO "Status_old";
ALTER TYPE "Status_new" RENAME TO "Status";
DROP TYPE "Status_old";
ALTER TABLE "Order" ALTER COLUMN "orderStatus" SET DEFAULT 'placed';
ALTER TABLE "Delivery" ALTER COLUMN "orderStatus" SET DEFAULT 'placed';
COMMIT;

-- AlterTable
ALTER TABLE "Delivery" ALTER COLUMN "orderStatus" SET DEFAULT 'placed';

-- AlterTable
ALTER TABLE "Order" ALTER COLUMN "orderStatus" SET DEFAULT 'placed';
