import { User, Profile } from "./models";

import { Prisma, PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
const prisma = new PrismaClient();

const getUsers = async (req: Request, res: Response) => {
  const users = await prisma.user.findMany({
    orderBy: { id: "asc" },
  });
  res.status(200).json(users);
};

const upsertUser = async (req: Request, res: Response) => {
  console.log(req.body);
  const {
    firstName,
    lastName,
    email,
    emailVerified,
    picture,
    dateCreated,
    lastLogin,
    delivering,
    profile,
  } = req.body as User;

  const createdUser = await prisma.user.upsert({
    where: { email },
    update: { emailVerified, lastLogin, delivering },
    create: {
      firstName,
      lastName,
      email,
      dateCreated,
    },
  });
  res.status(200).json(createdUser);
};

const db = {
  getUsers,
  upsertUser,
};

export default db;
