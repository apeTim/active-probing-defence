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
echo curl https://raw.githubusercontent.com/apeTim/active-probing-defence/main/index-$((1 + $RANDOM % 4)).html > /var/www/html/index.html
certbot --nginx -d "$domain" -d "www.$domain" --register-unsafely-without-email
systemctl restart nginx
