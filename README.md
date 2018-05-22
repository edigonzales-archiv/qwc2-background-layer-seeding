# qwc2-background-layer-seeding

mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,8

sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,8 -v'

sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,10 -n 4'


sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,10 -n 4'

seeded 19968 tiles, now at z10 x112 y88                                                        
seeded 316 metatiles (20224 total tiles, 20224 non-empty tiles) in 393.5 seconds at 51.4 tiles/sec (51.4 non-empty tiles/sec)



sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 11,14 -n 4 -d /opt/qwc2-background-layer-seeding/mapcache/wmts-seeding-geom.gpkg -l kanton1000m'

seeded 2203520 tiles, now at z14 x1232 y2152                                                   
seeded 34430 metatiles (2203520 total tiles, 2203520 non-empty tiles) in 10517.7 seconds at 209.5 tiles/sec (209.5 non-empty tiles/sec)




sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_farbig -z 0,10 -n 4'
seeded 20160 tiles, now at z10 x144 y88                                                        
seeded 316 metatiles (20224 total tiles, 20224 non-empty tiles) in 571.4 seconds at 35.4 tiles/sec (35.4 non-empty tiles/sec)

sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_farbig -z 11,14 -n 4 -d /opt/qwc2-background-layer-seeding/mapcache/wmts-seeding-geom.gpkg -l kanton500m'
seeded 2203392 tiles, now at z14 x1216 y2152                                                   
seeded 34430 metatiles (2203520 total tiles, 2203520 non-empty tiles) in 10848.8 seconds at 203.1 tiles/sec (203.1 non-empty tiles/sec)


sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_ortho -z 0,10 -n 4'