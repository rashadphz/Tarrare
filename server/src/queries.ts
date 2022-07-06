import { User, Profile } from "./models";

import { Prisma, PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();

const getUsers = async (req: Request, res: Response) => {
  const users = await prisma.user.findMany({
    orderBy: { id: "asc" },
  });
  res.status(200).json(users);
};

const loginUser = async (req: Request, res: Response) => {
  const { firstName, lastName, email, password } = req.body as User;
  const user = await prisma.user.findUnique({
    where: {
      email,
    },
  });

  if (user) {
    const hashedPassword = user.password;
    const result = await bcrypt.compare(password, hashedPassword);
    result ? res.status(200).json(user) : res.status(404).json();
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

const upsertUser = async (req: Request, res: Response) => {
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
    password,
  } = req.body as User;

  const createdUser = await prisma.user.upsert({
    where: { email },
    update: { emailVerified, lastLogin, delivering },
    create: {
      firstName,
      lastName,
      email,
      dateCreated,
      password,
    },
  });
  res.status(200).json(createdUser);
};

const db = {
  getUsers,
  upsertUser,
  loginUser,
};

export default db;
