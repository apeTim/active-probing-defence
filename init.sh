apt install nginx -y
apt install fail2ban
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        server_name _;

        location / {
            try_files '' /index.html =404;
        }
}" > /etc/nginx/sites-available/default 
curl https://raw.githubusercontent.com/apeTim/active-probing-defence/main/index-$((1 + $RANDOM % 4)).html > /var/www/html/index.html

# Ssh security
echo "
Port $2
PermitRootLogin yes
ChallengeResponseAuthentication no
UsePAM no
PasswordAuthentication no
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server" > /etc/ssh/sshd_config
mkdir ~/.ssh
echo "$3" > ~/.ssh/authorized_keys
service ssh restart
