import express, { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import db from "./queries";

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

/**
 * Users
 */

app.get("/user", (req: Request, res: Response) => {
  db.getUsers(req, res);
});

app.post("/user", (req: Request, res: Response) => {
  db.updateUser(req, res);
});

app.post("/login", (req: Request, res: Response) => {
  db.loginUser(req, res);
});

app.post("/register", (req: Request, res: Response) => {
  db.registerUser(req, res);
});

/**
 * Places
 */
app.post("/place", (req: Request, res: Response) => {
  db.addPlace(req, res);
});

/**
 * Deliveries/Orders
 */
app.post("/delivery", (req: Request, res: Response) => {
  db.upsertDelivery(req, res);
});
app.get("/delivery", (req: Request, res: Response) => {
  db.getDeliveries(req, res);
});


const port = 62528
const server = app.listen(port, () => {
  console.log(`Started server at port ${port}`);
});
