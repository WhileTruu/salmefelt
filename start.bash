docker-compose up -f backend/docker-compose.yml
npm --prefix frontend run build
ln -s nginx/sites-available/salmefelt.nginx /etc/nginx/sites-enabled/salmefelt-unstable
