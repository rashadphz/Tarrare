import { Message, Status } from "@prisma/client";
import {
  makeSchema,
  mutationType,
  nonNull,
  objectType,
  queryType,
  stringArg,
  subscriptionType,
  intArg,
  arg,
  inputObjectType,
  booleanArg,
  asNexusMethod,
} from "nexus";
import { context, Context } from "./context";

import { DateTimeResolver } from "graphql-scalars";
export const DateTime = asNexusMethod(DateTimeResolver, "date");

const User = objectType({
  name: "User",
  definition(t) {
    t.nonNull.int("id");
    t.nonNull.string("firstName");
    t.nonNull.string("lastName");
    t.nonNull.string("email");
    t.nonNull.boolean("emailVerified");
    t.nonNull.string("password");
    t.string("picture");
    t.nonNull.field("dateCreated", { type: "DateTime" });
    t.nonNull.boolean("delivering");
  },
});

const Place = objectType({
  name: "Place",
  definition(t) {
    t.nonNull.int("id");
    t.nonNull.string("name");
    t.nonNull.string("fullAddress");
    t.nonNull.string("state");
    t.nonNull.string("city");
    t.nonNull.int("zipcode");
    t.nonNull.string("googlePlaceId");
  },
});

const Resturant = objectType({
  name: "Resturant",
  definition(t) {
    t.nonNull.int("placeId");
    t.field("place", {
      type: "Place",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.resturant
          .findUnique({
            where: { placeId: parent.placeId },
          })
          .place();
      },
    });
  },
});

const DeliveryBuilding = objectType({
  name: "DeliveryBuilding",
  definition(t) {
    t.nonNull.int("placeId");
    t.field("place", {
      type: "Place",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.deliveryBuilding
          .findUnique({
            where: { placeId: parent.placeId || undefined },
          })
          .place();
      },
    });
  },
});

const Delivery = objectType({
  name: "Delivery",
  definition(t) {
    t.nonNull.int("id");
    t.nonNull.string("orderStatus");
    t.nonNull.int("userId"),
      t.field("user", {
        type: "User",
        resolve: (parent, _, context: Context) => {
          return context.prisma.delivery
            .findUnique({
              where: { id: parent.id },
            })
            .user();
        },
      });
    t.nonNull.int("resturantPlaceId"),
      t.field("resturant", {
        type: "Resturant",
        resolve: (parent, _args, context: Context) => {
          return context.prisma.delivery
            .findUnique({
              where: { id: parent.resturantPlaceId },
            })
            .resturant();
        },
      });
    t.nonNull.int("deliveryBuildingPlaceId"),
      t.field("deliveryBuilding", {
        type: "DeliveryBuilding",
        resolve: (parent, _args, context: Context) => {
          return context.prisma.delivery
            .findUnique({
              where: { id: parent.deliveryBuildingPlaceId },
            })
            .deliveryBuilding();
        },
      });
  },
});

const Message = objectType({
  name: "Message",
  definition(t) {
    t.nonNull.int("id");
    t.nonNull.string("text");
    t.nonNull.field("createdAt", { type: "DateTime" });
    t.nonNull.int("senderId");
    t.field("sender", {
      type: "User",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.message
          .findUnique({
            where: { id: parent.id },
          })
          .sender();
      },
    });
    t.nonNull.int("recieverId");
    t.field("reciever", {
      type: "User",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.message
          .findUnique({
            where: { id: parent.id },
          })
          .reciever();
      },
    });
    t.nonNull.int("convoId");
    t.field("convo", {
      type: "Convo",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.message
          .findUnique({
            where: { id: parent.id },
          })
          .convo();
      },
    });
  },
});

const Convo = objectType({
  name: "Convo",
  definition(t) {
    t.nonNull.int("id");
    t.nonNull.int("memberOneId");
    t.field("memberOne", {
      type: "User",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.convo
          .findUnique({
            where: { id: parent.id },
          })
          .memberOne();
      },
    });
    t.nonNull.int("memberTwoId");
    t.field("memberTwo", {
      type: "User",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.convo
          .findUnique({
            where: { id: parent.id },
          })
          .memberTwo();
      },
    });
    t.nonNull.list.field("messages", {
      type: "Message",
      resolve: (parent, _args, context: Context) => {
        return context.prisma.convo
          .findFirst({
            where: {
              OR: [
                {
                  memberOneId: parent.memberOneId,
                  memberTwoId: parent.memberTwoId,
                },
                {
                  memberTwoId: parent.memberOneId,
                  memberOneId: parent.memberTwoId,
                },
              ],
            },
          })
          .messages();
      },
    });
  },
});

export const Query = queryType({
  definition(t) {
    t.nonNull.list.nonNull.field("allUsers", {
      type: "User",
      resolve: (_parent, _args, context: Context) => {
        return context.prisma.user.findMany();
      },
    });

    t.nonNull.list.field("allDeliveries", {
      type: "Delivery",
      resolve: (_parent, _args, context: Context) => {
        return context.prisma.delivery.findMany({
          where: {
            orderStatus: Status.placed,
          },
          orderBy: {
            dateCreated: "desc",
          },
        });
      },
    });

    t.nonNull.list.field("getConversation", {
      type: "Message",
      args: {
        senderId: nonNull(intArg()),
        recieverId: nonNull(intArg()),
      },
      resolve: (_parent, args, context: Context) => {
        return context.prisma.message.findMany({
          where: {
            OR: [
              {
                senderId: args.senderId,
                recieverId: args.recieverId,
              },
              {
                senderId: args.recieverId,
                recieverId: args.senderId,
              },
            ],
          },
          orderBy: {
            createdAt: "asc",
          },
        });
      },
    });

    t.nonNull.list.field("getUserConversations", {
      type: "Convo",
      args: {
        currentUserId: nonNull(intArg()),
      },
      resolve: (_parent, args, context: Context) => {
        return context.prisma.convo.findMany({
          where: {
            OR: [
              { memberOneId: args.currentUserId },
              { memberTwoId: args.currentUserId },
            ],
          },
        });
      },
    });
  },
});

export const Mutation = mutationType({
  definition(t) {
    t.field("login", {
      type: "User",
      args: {
        email: nonNull(stringArg()),
        password: nonNull(stringArg()),
      },
      resolve: async (_parent, args, context: Context) => {
        return await context.db.loginUser(args.email, args.password);
      },
    });

    t.field("register", {
      type: "User",
      args: {
        firstName: nonNull(stringArg()),
        lastName: nonNull(stringArg()),
        email: nonNull(stringArg()),
        password: nonNull(stringArg()),
      },
      resolve: async (_parent, args, context: Context) => {
        return await context.db.registerUser(
          args.firstName,
          args.lastName,
          args.email,
          args.password
        );
      },
    });

    t.field("toggleUserDeliveryStatus", {
      type: "User",
      args: {
        id: nonNull(intArg()),
        delivering: nonNull(booleanArg()),
      },
      resolve: async (_parent, args) => {
        return await context.db.updateUser(args.id, args.delivering);
      },
    });

    t.field("upsertDelivery", {
      type: "Delivery",
      args: {
        userId: nonNull(intArg()),
        orderStatus: nonNull(stringArg()),
        resturantPlaceId: intArg(),
        deliveryBuildingPlaceId: intArg(),
      },
      resolve: async (_parent, args) => {
        return await context.db.upsertDelivery(
          args.userId,
          args.orderStatus,
          args.resturantPlaceId,
          args.deliveryBuildingPlaceId
        );
      },
    });

    t.field("createPlace", {
      type: "Place",
      args: {
        name: nonNull(stringArg()),
        fullAddress: nonNull(stringArg()),
        state: nonNull(stringArg()),
        city: nonNull(stringArg()),
        zipcode: nonNull(intArg()),
        googlePlaceId: nonNull(stringArg()),
      },
      resolve: async (
        _parent,
        { name, fullAddress, state, city, zipcode, googlePlaceId }
      ) => {
        return await context.db.createPlace({
          name,
          fullAddress,
          state,
          city,
          zipcode,
          googlePlaceId,
        });
      },
    });

    t.field("createMessage", {
      type: "Message",
      args: {
        text: nonNull(stringArg()),
        senderId: nonNull(intArg()),
        recieverId: nonNull(intArg()),
      },
      resolve: async (_parent, args) => {
        const newMessage = await context.db.createMessage(
          args.text,
          args.senderId,
          args.recieverId
        );

        //publish the subscription
        context.pubsub.publish("newMessage", newMessage);

        return newMessage;
      },
    });
  },
});

export const Subscription = subscriptionType({
  definition(t) {
    t.field("newMessage", {
      type: "Message",
      args: {
        recieverId: nonNull(intArg()),
      },
      subscribe(_root, args, context: Context) {
        return context.pubsub.asyncIterator("newMessage");
      },
      resolve(payload: Message) {
        return payload;
      },
    });
  },
});

export const schema = makeSchema({
  types: [
    Query,
    Mutation,
    User,
    Place,
    DateTime,
    Resturant,
    DeliveryBuilding,
    Delivery,
    Subscription,
    Convo,
    Message,
  ],
  outputs: {
    schema: __dirname + "/../schema.graphql",
    typegen: __dirname + "/generated/nexus.ts",
  },
  contextType: {
    module: require.resolve("./context"),
    export: "Context",
  },
  sourceTypes: {
    modules: [
      {
        module: "@prisma/client",
        alias: "prisma",
      },
    ],
  },
});
