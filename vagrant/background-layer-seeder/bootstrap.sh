#!/bin/bash
locale-gen de_CH.utf8
echo "Europe/Zurich" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
echo 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -    
apt-get update
apt-get install -y xfce4 xfce4-whiskermenu-plugin xfce4-terminal thunar-archive-plugin gedit
apt-get install -y x2goserver x2goserver-xsession
apt-get install -y apache2 libapache2-mod-fcgid
apt-get install -y qgis python-qgis qgis-plugin-grass qgis-server
apt-get install -y mapcache-tools libapache2-mod-mapcache libmapcache1-dev
service apache2 restart
apt-get install -y xauth zip
apt-get install -y ifupdown
apt-get install -y fonts-liberation
apt-get install -y git
apt-get install -y unzip
mkdir -p /vagrant/
mkdir -p /opt/geodata/
mkdir -p /opt/mapcache/
mkdir -p /opt/qgis/
mkdir -p /tiles
chown www-data:www-data -R /tiles
#chmod 7777 -R /tiles
git clone https://github.com/edigonzales/qwc2-background-layer-seeding.git /opt/qwc2-background-layer-seeding
chmod +rx -R /opt/qwc2-background-layer-seeding
cp /opt/qwc2-background-layer-seeding/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
cp /opt/qwc2-background-layer-seeding/apache/fcgid.conf /etc/apache2/mods-available/fcgid.conf
cp /opt/qwc2-background-layer-seeding/mapcache/mapcache.xml /opt/mapcache/
cp /opt/qwc2-background-layer-seeding/mapcache/wmts-seeding-geom.gpkg /opt/mapcache/
chown www-data:www-data -R /opt/mapcache/
cp /opt/qwc2-background-layer-seeding/qgis/qgs/*.qgs /opt/qgis/
chown www-data:www-data -R /opt/qgis/
cp /opt/qwc2-background-layer-seeding/maske/maske.gpkg /vagrant/
unzip -d /usr/share/fonts/truetype/ /opt/qwc2-background-layer-seeding/fonts/Cadastra.zip
fc-cache -f -v
unzip -d /usr/share/qgis/svg/ /opt/qwc2-background-layer-seeding/symbols/grundbuchplan.zip
chmod +r /usr/share/qgis/svg/*.svg   
service apache2 restart
cp /opt/qwc2-background-layer-seeding/bash/.profile /root/.profile
apt-get install -y postgresql-10 
apt-get install -y postgresql-client-10
apt-get install -y postgresql-10-postgis-2.4
apt-get install -y postgresql-10-postgis-2.4-scripts
apt-get install -y postgis
sudo -u postgres psql -d postgres -c "UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';"
sudo -u postgres psql -d postgres -c "DROP DATABASE template1;"
sudo -u postgres psql -d postgres -c "CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING='UNICODE' LC_COLLATE='en_US.UTF8' LC_CTYPE='en_US.UTF8';"
sudo -u postgres psql -d postgres -c "UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';"
sudo -u postgres psql -d postgres -c "UPDATE pg_database SET datallowconn = FALSE WHERE datname = 'template1';"
sudo -u postgres psql -d postgres -c "CREATE ROLE ddluser LOGIN PASSWORD 'ddluser';"
sudo -u postgres psql -d postgres -c "CREATE ROLE dmluser LOGIN PASSWORD 'dmluser';"
sudo -u postgres psql -d postgres -c "CREATE ROLE vagrant LOGIN PASSWORD 'vagrant';"
sudo -u postgres psql -d postgres -c "CREATE ROLE ubuntu LOGIN PASSWORD 'ubuntu';"
sudo -u postgres psql -d postgres -c 'CREATE ROLE "www-data" LOGIN;'
sudo -u postgres psql -d postgres -c "CREATE DATABASE pub WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' OWNER ddluser;"
sudo -u postgres psql -d pub -c 'CREATE EXTENSION postgis;'
sudo -u postgres psql -d pub -c 'CREATE EXTENSION "uuid-ossp";'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geometry_columns TO dmluser;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON spatial_ref_sys TO dmluser;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geography_columns TO dmluser;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON raster_columns TO dmluser;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geometry_columns TO vagrant;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON spatial_ref_sys TO vagrant;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geography_columns TO vagrant;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON raster_columns TO vagrant;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geometry_columns TO ubuntu;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON spatial_ref_sys TO ubuntu;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geography_columns TO ubuntu;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON raster_columns TO ubuntu;'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geometry_columns TO "www-data";'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON spatial_ref_sys TO "www-data";'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON geography_columns TO "www-data";'
sudo -u postgres psql -d pub -c 'GRANT SELECT ON raster_columns TO "www-data";'
sudo -u postgres psql -d pub -c "ALTER DATABASE pub SET postgis.gdal_enabled_drivers TO 'GTiff PNG JPEG';"
systemctl stop postgresql
rm /etc/postgresql/10/main/postgresql.conf
rm /etc/postgresql/10/main/pg_hba.conf
cp /opt/qwc2-background-layer-seeding/postgres/postgresql.conf /etc/postgresql/10/main
cp /opt/qwc2-background-layer-seeding/postgres/pg_hba.conf /etc/postgresql/10/main
sudo -u root chown postgres:postgres /etc/postgresql/10/main/postgresql.conf
sudo -u root chown postgres:postgres /etc/postgresql/10/main/pg_hba.conf
service postgresql start
