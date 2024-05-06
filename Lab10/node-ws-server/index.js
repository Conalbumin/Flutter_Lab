const express = require("express");
const http = require("http");
const app = express();

app.get("/", (req, res) => {
  res.res("Trang web này hiện tại chỉ cung cấp server cho flutter client");
});

const PORT = process.env.PORT || 3000;
const server = http.createServer(app);
server.listen(PORT, () => {
  console.clear();
  console.log(`Http Server is listening at: http://localhost:${PORT}`);
  const ws = require("./socket")(server);
});
