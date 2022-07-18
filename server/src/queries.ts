import { Place, Status } from "@prisma/client";
import { Prisma, PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";
import { context } from "./context";

/**
 * Users
 */

const updateUser = async (id: number, delivering: boolean) => {
  const user = await context.prisma.user.update({
    where: {
      id,
    },
    data: {
      delivering,
    },
  });
  return user;
};

const loginUser = async (email: string, password: string) => {
  const user = await context.prisma.user.findUnique({
    where: {
      email,
    },
  });
  if (!user) {
    throw new Error(`No user found for email: ${email}`);
  }
  const hashedPassword = user.password;
  const passwordValid = await bcrypt.compare(
    password,
    hashedPassword
  );
  if (!passwordValid) {
    throw new Error("Invalid Password");
  }
  return user;
};

const registerUser = async (
  firstName: string,
  lastName: string,
  email: string,
  password: string
) => {
  const emailExists =
    (await context.prisma.user.findUnique({
      where: {
        email,
      },
    })) != null;

  if (emailExists) {
    throw new Error("Email already exists");
  } else {
    const salt = await bcrypt.genSalt();
    const hash = await bcrypt.hash(password, salt);

    const createdUser = await context.prisma.user.create({
      data: {
        firstName,
        lastName,
        email,
        dateCreated: undefined,
        password: hash,
      },
    });
    return createdUser;
  }
};

/**
 * Places
 */

const createPlace = async (placeObj: any) => {
  const { name, fullAddress, state, city, zipcode, googlePlaceId } =
    placeObj;

  const place = await context.prisma.place.findUnique({
    where: {
      googlePlaceId,
    },
  });

  // Already exists
  if (place) {
    return place;
  } else {
    const createdPlace = await context.prisma.place.create({
      data: {
        name,
        fullAddress,
        state,
        city,
        zipcode,
        googlePlaceId,
      },
    });
    return createdPlace;
  }
};

const addPlace = async (placeBody: Place) => {
  const place = await createPlace(placeBody);
  return place;
};

const addResturant = async (placeId: number) => {
  await context.prisma.resturant.upsert({
    where: {
      placeId,
    },
    create: {
      placeId,
    },
    update: {},
  });
};

const addDeliveryBuilding = async (placeId: number) => {
  await context.prisma.deliveryBuilding.upsert({
    where: {
      placeId,
    },
    create: {
      placeId,
    },
    update: {},
  });
};

/**
 * Orders/Deliveries
 */
const upsertDelivery = async (
  userId: number,
  orderStatus: string,
  resturantPlaceId?: number | null,
  deliveryBuildingPlaceId?: number | null
) => {
  let status = (<any>Status)[orderStatus];
  // check if user already has an incomplete delivery request
  const placedDeliveryRequest =
    await context.prisma.delivery.findFirst({
      where: {
        userId,
        orderStatus: Status.placed,
      },
      select: {
        id: true,
      },
    });

  if (placedDeliveryRequest) {
    // if incomplete delivery exists for this user, update orderStatus
    const updatedDelivery = await context.prisma.delivery.update({
      where: {
        id: placedDeliveryRequest.id,
      },
      data: {
        orderStatus: status,
      },
      include: {
        user: true,
        resturant: true,
        deliveryBuilding: true,
      },
    });
    return updatedDelivery;
  } else {
    if (resturantPlaceId && deliveryBuildingPlaceId) {
      await addResturant(resturantPlaceId);
      await addDeliveryBuilding(deliveryBuildingPlaceId);

      const createdDelivery = await context.prisma.delivery.create({
        data: {
          orderStatus: status,
          userId,
          resturantPlaceId,
          deliveryBuildingPlaceId,
        },
        include: {
          user: true,
          resturant: true,
          deliveryBuilding: true,
        },
      });
      return createdDelivery;
    } else {
      throw new Error("Invalid Delivery Request");
    }
  }
};

/**
 * Message
 */

const createMessage = async (
  text: string,
  senderId: number,
  recieverId: number
) => {
  const createdMessage = await context.prisma.message.create({
    data: {
      text,
      senderId,
      recieverId,
    },
  });
  return createdMessage;
};

const db = {
  loginUser,
  registerUser,
  updateUser,
  addPlace,
  createPlace,
  addResturant,
  addDeliveryBuilding,
  upsertDelivery,
  createMessage,
};

export default db;
