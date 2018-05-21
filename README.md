# qwc2-background-layer-seeding

mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,8

sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,8 -v'

sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,10 -n 4'


sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,10 -n 4'

seeded 19968 tiles, now at z10 x112 y88                                                        
seeded 316 metatiles (20224 total tiles, 20224 non-empty tiles) in 393.5 seconds at 51.4 tiles/sec (51.4 non-empty tiles/sec)



sudo su - www-data -s /bin/bash -c 'mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 11,14 -n 4 -d /opt/qwc2-background-layer-seeding/mapcache/wmts-seeding-geom.gpkg -l kanton1000m'