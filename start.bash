docker-compose --project-directory backend -f backend/docker-compose.yml up -d
npm --prefix frontend install
npm --prefix frontend run build
sudo ln -sf $PWD/nginx/sites-available/salmefelt.nginx /etc/nginx/sites-enabled/salmefelt-unstable
sudo service nginx reload
