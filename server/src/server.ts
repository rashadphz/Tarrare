import { ApolloServer } from "apollo-server-express";
import { ApolloServerPluginDrainHttpServer } from "apollo-server-core";

import { WebSocketServer } from "ws";
import express from "express";
import { createServer } from "http";

import { useServer } from "graphql-ws/lib/use/ws";

import { schema } from "./schema";
import { context } from "./context";

const PORT = 62528;

const app = express();
const httpServer = createServer(app);

async function start() {
  /** Create WS Server */
  const wsServer = new WebSocketServer({
    server: httpServer,
    path: "/graphql",
  });

  /** hand-in created schema and have the WS Server start listening */
  const serverCleanup = useServer(
    {
      schema,
      context,
    },
    wsServer
  );

  const server = new ApolloServer({
    schema,
    context,
    plugins: [
      ApolloServerPluginDrainHttpServer({ httpServer }),
      {
        async serverWillStart() {
          return {
            async drainServer() {
              await serverCleanup.dispose();
            },
          };
        },
      },
    ],
  });

  await server.start();
  server.applyMiddleware({ app });

  httpServer.listen(PORT, () => {
    console.log(
      `🚀 Server ready at http://localhost:${PORT}/graphql`
    );
    console.log(
      `⏰ Subscriptions ready at http://localhost:${PORT}/graphql`
    );
  });
}

start();
