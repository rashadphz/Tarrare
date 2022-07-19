import { PrismaClient } from "@prisma/client";
import { PubSub } from "graphql-subscriptions";
import db from "./queries";

export interface Context {
  prisma: PrismaClient;
  db: typeof db;
  pubsub: PubSub;
}

const prisma = new PrismaClient();
const pubsub = new PubSub();

export const context: Context = {
  prisma: prisma,
  pubsub: pubsub,
  db: db,
};
