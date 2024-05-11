read -p "Enter domain: " domain
apt install nginx -y
apt install certbot -y
apt install python3-certbot-nginx -y
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        server_name _;

        location / {
            try_files '' /index.html =404;
        }
}" > /etc/nginx/sites-available/default 
echo "<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minecraft Сервер $domain</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #8bba8b;
            color: white;
            padding: 20px;
        }
        h1, h2 {
            color: #ffcc00;
        }
        .container {
            background-color: #333333;
            padding: 20px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Добро пожаловать на наш Minecraft сервер!</h1>
        <p>Присоединяйтесь к нашему увлекательному миру, где вы можете строить, исследовать и сражаться с другими игроками!</p>
        
        <h2>Как подключиться:</h2>
        <p>Чтобы подключиться к нашему серверу, используйте следующие данные:</p>
        <ul>
            <li>IP адрес: <strong>$domain</strong></li>
            <li>Порт: <strong>9000</strong></li>
        </ul>

        <h2>Правила сервера:</h2>
        <p>Мы ценим хорошее поведение и соблюдение правил. Вот наши основные правила:</p>
        <ul>
            <li>Без гриферства</li>
            <li>Без использования читов</li>
            <li>Уважайте других игроков</li>
        </ul>

        <h2>Описание сервера:</h2>
        <p>Наш сервер предлагает различные моды и мини-игры, которые подходят для всех видов игроков, от новичков до опытных строителей и бойцов.</p>

        <p>Приглашаем вас присоединиться к нашему сообществу и получить удовольствие от игры вместе с нами!</p>
    </div>
</body>
</html>
" > /var/www/html/index.html
certbot --nginx -d "$domain" -d "www.$domain" --register-unsafely-without-email
systemctl restart nginx
