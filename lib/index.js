const Container = require('./container');

const app = Container.loadAndInstantiate("app-spec-rust.hcpkg");

app.start();

const create_post_res = app.call("blog", "main", "create_post", JSON.stringify({ content: "Hello guys!", in_reply_to: "" }));
console.log(create_post_res);

const posts_by_agent_res = app.call("blog", "main", "posts_by_agent", JSON.stringify({ agent: "bob" }));
console.log(posts_by_agent_res);

app.stop();
