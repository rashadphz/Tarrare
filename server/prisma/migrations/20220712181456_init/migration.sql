/*
  Warnings:

  - You are about to drop the column `completed` on the `Delivery` table. All the data in the column will be lost.
  - You are about to drop the column `completed` on the `Order` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "Status" AS ENUM ('inProgress', 'complete', 'cancelled');

-- AlterTable
ALTER TABLE "Delivery" DROP COLUMN "completed",
ADD COLUMN     "orderStatus" "Status" NOT NULL DEFAULT 'inProgress';

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "completed",
ADD COLUMN     "orderStatus" "Status" NOT NULL DEFAULT 'inProgress';
