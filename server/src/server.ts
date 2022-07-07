import express, { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import db from "./queries";

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

/**
 * Users
 */

app.get("/users", (req: Request, res: Response) => {
  db.getUsers(req, res);
});
app.post("/login", (req: Request, res: Response) => {
  db.loginUser(req, res);
});
app.post("/register", (req: Request, res: Response) => {
  db.registerUser(req, res);
});

const server = app.listen(3000, () => {
  console.log("Started server at port 3000");
});
