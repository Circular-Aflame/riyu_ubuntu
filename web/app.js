const express = require('express');
const bodyParser = require('body-parser');
const multer = require('multer');
const https = require('https');
const fs = require('fs');
const httpProxy = require('http-proxy');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// 允许所有源访问
app.use(cors());

// 配置 bodyParser 中间件
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// 配置 multer 中间件，用于处理文件上传
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// 设置静态文件目录
app.use(express.static('public'));

app.get('/stylekana.css', (req, res) => {
    res.setHeader('Content-Type', 'text/css');
    res.sendFile(__dirname + '/stylekana.css');
});

app.get('/stylelist.css', (req, res) => {
    res.setHeader('Content-Type', 'text/css');
    res.sendFile(__dirname + '/stylelist.css');
});

app.get('/book.json', (req, res) => {
    fs.readFile('book.json', 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading book.json:', err);
            res.status(500).send('Internal Server Error');
        } else {
            const bookData = JSON.parse(data);
            res.json(bookData);
        }
    });
});


// 处理根路由，返回前端页面
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/list.html'); // 修改根路由返回的页面
});

// 配置代理
const proxy = httpProxy.createProxyServer({});

app.post('/demo/word', upload.single('file'), (req, res) => {
    console.log('Received request with FormData:', req.body); // 输出整个 FormData
    console.log('Received uploaded file:', req.file); // 输出上传的文件信息

    // 转发请求到HTTP服务器
    proxy.web(req, res, {
        target: 'http://49.233.22.132:8080', // 你的HTTP服务器地址
        // changeOrigin: true,
        // secure: false // 因为是自签名证书，需要设置为 false
    });

    // 监听代理的 `proxyRes` 事件，输出代理响应状态码
    proxy.on('proxyRes', (proxyRes, req, res) => {
        console.log('Received proxy response:', proxyRes.statusCode);
    });
});

// 新增对应的路由，用于处理 kana.html 页面的 GET 请求
app.get('/kana.html', (req, res) => {
    // 获取 URL 中的参数
    const textParam = req.query.text;
    const accentParam = req.query.accent;
    const hiraParam = req.query.hira;

    // 使用 fs 模块读取 kana.html 文件内容
    fs.readFile(__dirname + '/kana.html', 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading kana.html:', err);
            res.status(500).send('Internal Server Error');
            return;
        }

        // 替换模板中的参数
        const renderedHTML = data
            .replace('{{textParam}}', textParam)
            .replace('{{accentParam}}', accentParam)
            .replace('{{hiraParam}}', hiraParam);

        res.send(renderedHTML);
    });
});

const options = {
    key: fs.readFileSync('../key.pem'),
    cert: fs.readFileSync('../cert.pem'),
    passphrase: '2022-seka'
};

const server = https.createServer(options, app);

server.listen(PORT, () => {
    console.log(`Server is running on HTTPS port ${PORT}`);
});
