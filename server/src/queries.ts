import {
  User,
  Profile,
  Place,
  Delivery,
  Status,
  Resturant,
} from "@prisma/client";
import { Prisma, PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();

/**
 * Users
 */

const getUsers = async (req: Request, res: Response) => {
  const users = await prisma.user.findMany({
    orderBy: { id: "asc" },
  });
  res.status(200).json(users);
};

const updateUser = async (req: Request, res: Response) => {
  const {email, delivering } = req.body as User
  const user = await prisma.user.update({
    where: {
      email
    },
    data: {
      delivering
    }
  })
  res.status(200).json(user);
};

const loginUser = async (req: Request, res: Response) => {
  const { email, password } = req.body as User;
  const user = await prisma.user.findUnique({
    where: {
      email,
    },
  });

  if (user) {
    const hashedPassword = user.password;
    const result = await bcrypt.compare(password, hashedPassword);
    result
      ? res.status(200).json(user)
      : res.status(404).send("Password Incorrect");
  } else {
    res.status(404).send("Email does not exist");
  }
};

const registerUser = async (req: Request, res: Response) => {
  const { firstName, lastName, email, password } = req.body as User;

  const emailExists =
    (await prisma.user.findUnique({
      where: {
        email,
      },
    })) != null;

  if (emailExists) {
    res.status(404).send("Email Already exists.");
  } else {
    const salt = await bcrypt.genSalt();
    const hash = await bcrypt.hash(password, salt);

    const createdUser = await prisma.user.create({
      data: {
        firstName,
        lastName,
        email,
        dateCreated: undefined,
        password: hash,
      },
    });
    res.status(200).json(createdUser);
  }
};

/**
 * Places
 */

const createPlace = async (placeObj: Place) => {
  const { name, fullAddress, state, city, zipcode, googlePlaceId } =
    placeObj;

  const place = await prisma.place.findUnique({
    where: {
      googlePlaceId,
    },
  });

  // Already exists
  if (place) {
    return place;
  } else {
    const createdPlace = await prisma.place.create({
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

const addPlace = async (req: Request, res: Response) => {
  const place = await createPlace(req.body as Place);
  res.status(200).json(place);
};

const addResturant = async (req: Request, res: Response) => {
  const place = await createPlace(req.body as Place);

  const resturant = await prisma.resturant.findUnique({
    where: {
      placeId: place.id,
    },
  });

  if (!resturant) {
    await prisma.resturant.create({
      data: {
        placeId: place.id,
      },
    });
  }
  res.status(200).json(place);
};

const addDeliveryBuilding = async (req: Request, res: Response) => {
  const place = await createPlace(req.body as Place);

  const deliveryBuilding = await prisma.deliveryBuilding.findUnique({
    where: {
      placeId: place.id,
    },
  });

  if (!deliveryBuilding) {
    await prisma.deliveryBuilding.create({
      data: {
        placeId: place.id,
      },
    });
  }
  res.status(200).json(place);
};

/**
 * Orders/Deliveries
 */

const addDelivery = async (req: Request, res: Response) => {
  const {
    orderStatus,
    userId,
    resturantPlaceId,
    deliveryBuildingPlaceId,
  } = req.body as Delivery;

  const createdDelivery = await prisma.delivery.create({
    data: {
      orderStatus,
      userId,
      resturantPlaceId,
      deliveryBuildingPlaceId,
    },
  });

  res.status(200).json(createdDelivery);
};

const db = {
  getUsers,
  loginUser,
  registerUser,
  updateUser,
  addPlace,
  addResturant,
  addDeliveryBuilding,
  addDelivery,
};

export default db;
