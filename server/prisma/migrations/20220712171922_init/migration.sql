/*
  Warnings:

  - You are about to drop the column `locationId` on the `DeliveryBuilding` table. All the data in the column will be lost.
  - You are about to drop the column `locationId` on the `Resturant` table. All the data in the column will be lost.
  - You are about to drop the column `locationId` on the `University` table. All the data in the column will be lost.
  - You are about to drop the `Location` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `placeId` to the `DeliveryBuilding` table without a default value. This is not possible if the table is not empty.
  - Added the required column `placeId` to the `Resturant` table without a default value. This is not possible if the table is not empty.
  - Added the required column `placeId` to the `University` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "DeliveryBuilding" DROP CONSTRAINT "DeliveryBuilding_locationId_fkey";

-- DropForeignKey
ALTER TABLE "Resturant" DROP CONSTRAINT "Resturant_locationId_fkey";

-- DropForeignKey
ALTER TABLE "University" DROP CONSTRAINT "University_locationId_fkey";

-- AlterTable
ALTER TABLE "DeliveryBuilding" DROP COLUMN "locationId",
ADD COLUMN     "placeId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Resturant" DROP COLUMN "locationId",
ADD COLUMN     "placeId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "University" DROP COLUMN "locationId",
ADD COLUMN     "placeId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "lastLogin" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "lastLogin" SET DATA TYPE TIMESTAMP(3);

-- DropTable
DROP TABLE "Location";

-- CreateTable
CREATE TABLE "Place" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "fullAddress" VARCHAR(255) NOT NULL,
    "state" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "zipcode" INTEGER NOT NULL,
    "googlePlaceId" TEXT NOT NULL,

    CONSTRAINT "Place_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "University" ADD CONSTRAINT "University_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resturant" ADD CONSTRAINT "Resturant_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeliveryBuilding" ADD CONSTRAINT "DeliveryBuilding_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
