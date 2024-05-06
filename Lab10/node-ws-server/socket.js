const websocket = require("ws");

module.exports = (httpServer) => {
  const server = new websocket.Server({ server: httpServer }, () => {
    console.log(`Websocket server is started up: ${server.address} `);
  });
  server.on("connection", (client) => {
    console.log("Một user đã tham gia vào phòng chat");

    client.on("error", (e) => {
      console.log(`Client error: ${client.username}`);
      console.log(e);
    });

    client.on("close", () => {
      if (!client.username) {
        console.log("Annonymous đã rời khỏi cuộc trò chuyện");
        return;
      }

      let res = {
        message: `${client.username} đã rời khỏi chat room`,
        type: "info",
      };
      server.clients.forEach((c) => {
        if (c !== client) {
          c.send(JSON.stringify(res));
        }
      });
    });

    client.on("message", (data) => {
      let json = "";
      try {
        json = JSON.parse(data.toString());
        const { message, type } = json;
        if (!message || !type) {
          throw Error("invalid message");
        }
      } catch {
        return client.send(
          JSON.stringify({
            type: "info",
            message: `Nội dung không hợp lệ. Bạn cần gửi một json document với các field như {message, type, from}`,
          })
        );
      }

      const { message, type } = json;
      console.log(data.toString());

      if (type == "register") {
        client.username = message;
        sendBroadcast(
          server,
          {
            message: `${message} đã tham gia vào chat room. Hãy gửi tin nhắn cho bạn ấy`,
            type: "info",
          },
          client
        );
      } else {
        if (!client.username) {
          return client.send(
            JSON.stringify({
              type: "info",
              message: `Bạn cần cung cấp username trước khi gửi tin nhắn cho người khác. Cấu trúc đăng ký như sau: {"type":"register","message":"Khoa"}`,
            })
          );
        }
        sendBroadcast(server, {
          message,
          from: client.username,
          type: "chat",
        });
      }
    });

    const online = getListOfOnlineUsers(server, client);
    let msg = `Chào mừng bạn đã đến với chat room`;
    if (online.length > 0)
      msg += `. Hiện tại đang có ${online} đang trực tuyến`;
    client.send(
      JSON.stringify({
        type: "info",
        message: msg,
      })
    );
  });

  server.on("error", (e) => {
    console.log("Socket server error");
    console.log(e);
  });

  return server;
};

function getListOfOnlineUsers(server, client) {
  let users = "";
  server.clients.forEach((c) => {
    if (c !== client && c.username) {
      if (users.length > 0) {
        users += ", ";
      }
      users += c.username;
    }
  });
  return users;
}

function sendBroadcast(server, data, skipClient) {
  server.clients.forEach((c) => {
    if (c !== skipClient) {
      c.send(JSON.stringify(data));
    }
  });
}
