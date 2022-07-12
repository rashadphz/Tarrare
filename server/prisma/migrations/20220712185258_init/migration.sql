/*
  Warnings:

  - You are about to drop the column `deliveryBuildingId` on the `Delivery` table. All the data in the column will be lost.
  - You are about to drop the column `resturantId` on the `Delivery` table. All the data in the column will be lost.
  - The primary key for the `DeliveryBuilding` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `DeliveryBuilding` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryBuildingId` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `resturantId` on the `Order` table. All the data in the column will be lost.
  - The primary key for the `Resturant` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Resturant` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[placeId]` on the table `DeliveryBuilding` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[placeId]` on the table `Resturant` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `deliveryBuildingPlaceId` to the `Delivery` table without a default value. This is not possible if the table is not empty.
  - Added the required column `resturantPlaceId` to the `Delivery` table without a default value. This is not possible if the table is not empty.
  - Added the required column `deliveryBuildingPlaceId` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `resturantPlaceId` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Delivery" DROP CONSTRAINT "Delivery_deliveryBuildingId_fkey";

-- DropForeignKey
ALTER TABLE "Delivery" DROP CONSTRAINT "Delivery_resturantId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_deliveryBuildingId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_resturantId_fkey";

-- AlterTable
ALTER TABLE "Delivery" DROP COLUMN "deliveryBuildingId",
DROP COLUMN "resturantId",
ADD COLUMN     "deliveryBuildingPlaceId" INTEGER NOT NULL,
ADD COLUMN     "resturantPlaceId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "DeliveryBuilding" DROP CONSTRAINT "DeliveryBuilding_pkey",
DROP COLUMN "id";

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "deliveryBuildingId",
DROP COLUMN "resturantId",
ADD COLUMN     "deliveryBuildingPlaceId" INTEGER NOT NULL,
ADD COLUMN     "resturantPlaceId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Resturant" DROP CONSTRAINT "Resturant_pkey",
DROP COLUMN "id";

-- CreateIndex
CREATE UNIQUE INDEX "DeliveryBuilding_placeId_key" ON "DeliveryBuilding"("placeId");

-- CreateIndex
CREATE UNIQUE INDEX "Resturant_placeId_key" ON "Resturant"("placeId");

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_resturantPlaceId_fkey" FOREIGN KEY ("resturantPlaceId") REFERENCES "Resturant"("placeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_deliveryBuildingPlaceId_fkey" FOREIGN KEY ("deliveryBuildingPlaceId") REFERENCES "DeliveryBuilding"("placeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Delivery" ADD CONSTRAINT "Delivery_resturantPlaceId_fkey" FOREIGN KEY ("resturantPlaceId") REFERENCES "Resturant"("placeId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Delivery" ADD CONSTRAINT "Delivery_deliveryBuildingPlaceId_fkey" FOREIGN KEY ("deliveryBuildingPlaceId") REFERENCES "DeliveryBuilding"("placeId") ON DELETE RESTRICT ON UPDATE CASCADE;
