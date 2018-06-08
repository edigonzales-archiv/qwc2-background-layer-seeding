
# QWC2-Backgroundlayer-Seeding

## Einleitung

Fubar

## Aufsetzen eines kompletten neuen Servers

1. Server (CX41) hinzufügen: mit user data (`vagrant/background-layer-seeder/bootstrap.sh`) und SSH-Keys. Notfalls kann im laufenden Betrieb ein temporäres root-Passwort im Admin-GUI bestellt werden.
2. Warten bis der Server aufgesetzt ist (siehe `/var/log/cloud-init-output.log`).
3. Rasterdaten in das Verzeichnis `/vagrant/` kopieren (z.B. mitt SFTP):
⋅⋅* ch.swisstopo.lk1000.grau_relief
⋅⋅* ch.swisstopo.lk1000.grau
⋅⋅* ch.swisstopo.lk1000.farbig_relief
⋅⋅* ch.swisstopo.lk500.grau
⋅⋅* ch.swisstopo.lk500.farbig_relief
⋅⋅* ch.swisstopo.lk200.grau
⋅⋅* ch.swisstopo.lk200.farbig_relief
⋅⋅* ch.swisstopo.lk100.grau
⋅⋅* ch.swisstopo.lk100.farbig_relief
⋅⋅* ch.swisstopo.lk50.grau
⋅⋅* ch.swisstopo.lk50.farbig_relief
⋅⋅* ch.swisstopo.lk25.grau
⋅⋅* ch.swisstopo.lk25.farbig_relief
⋅⋅* ch.swisstopo.lk10.grau_relief
⋅⋅* ch.swisstopo.lk10.farbig_relief
⋅⋅* ch.swisstopo.landsat
⋅⋅* ch.so.agi.orthofoto_2017.rgb
⋅⋅* ch.so.agi.orthofoto_2016.rgb
⋅⋅* ch.so.agi.hintergrundkarte
⋅⋅* ch.bl.agi.orthofoto_2015.rgb
4. Rechte überprüfen. Die Daten müssen für QGIS-Server (also www-data) lesbar sein. Übertragungsrate vom lokalen PC im Kantonsnetz auf den externen Server circa 10 MB/s.
5. Vektordaten (haupsächlich AV-Daten) mit GRETL (`gretl/build.gradle`) kopieren: `gradle createHoheitsgrenzenSchema createGrundbuchplanSchema createMOpublicSchema` und `gradle copyDataFromHoheitsgrenzen copyDataFromGrundbuchplan copyDataFromMOpublic`. Am längsten dauert das Kopieren des gesamten MOpublic-Schemas. Total circa 11 Minuten. Je nach GRETL-Ausführvariante (manuell oder im Gretl-Jenkins) muss noch das Passwort die Datenbanken als env-Variable gesetzt werden (`export X=Y`).
6. Überprüfen der WMS und WMTS mittels GetCapabilities-Aufrufe (aber nichts requesten):
..* `http://159.69.29.182/cgi-bin/qgis_mapserv.fcgi?map=/opt/qwc2-background-layer-seeding/qgis/qgs/hintergrundkarte_farbig.qgs`
..* `http://159.69.29.182/mapcache/wmts/1.0.0/WMTSCapabilities.xml`
7. Die drei Caches für den WMTS erstellen. Dies kann entweder manuell gemacht werden oder mittels GRETL-Job (jeweils mit Benutzer `seeder`). Insgesamt sind es sechs Befehle. Für jeden Hintergrundkarten-Typ gibt es zwei Befehle, da je nach Zoomstufe mit resp. ohne Geometrie-Begrenzung gecached wird:
..* `mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_farbig -z 0,10 -n 4`
..* `mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_farbig -z 11,14 -n 4 -d /tiles/wmts-seeding-geom.gpkg -l kanton1000m`
..* `mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 0,10 -n 4`
..* `mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_sw -z 11,14 -n 4 -d /tiles/wmts-seeding-geom.gpkg -l kanton1000m`
..* `mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_ortho -z 0,10 -n 4`
..* `mapcache_seed -c /opt/mapcache/mapcache.xml -f -g 2056 -t ch.so.agi.hintergrundkarte_ortho -z 11,14 -n 4 -d /tiles/wmts-seeding-geom.gpkg -l kanton1000m`
8. Die Kacheln gehörten dem Benutzer `seeder`. Mapcache kann die Kacheln lesen und ausliefern, jedoch keine neuen Kacheln erzeugen. Dies ist aber sogar gewollt, da das Caching immer manuell resp. mittels Cronjob ausgeführt wird. Es muss jedoch dafür gesort werden, dass die Kacheln nie "ablaufen". Das kann in der `mapcache.xml`-Datei konfiguriert werden, indem keine `<auto-expire>` gesetzt wird.

## Floating IP

Die virtuellen Server erhalten eine IP, die solange statisch bis der Server gelöscht wird, dh. Reboots überstehen sie schadlos. Um den Aufwand auf Seiten AGI-Infrastruktur trotzdem möglichst gering zu halten, wird dem Server eine sogenannte "Floating IP" zugwiesen. Falls ein Server ausfällt, kann diese Floating IP einem neuen Server zugewiesen werden, ohne dass in der AGI-Infrastruktur etwas geändert werden muss. Die Zuweisung zum Server selbst muss im Admin-GUI von Hetzner gemacht werden. Zusätzlich müssen einige Einstellung auf dem Server vorgenommen werden.

Floating IP: **195.201.45.245**
Backup IP (non-floating): **195.201.234.152**

Die Einstellungen, die auf dem Server zu machen sind, stehen hier: `floating-ip/README.md`.

Falls das Umstellen der Floating IP nicht funktioniert, muss in der AGI-Infrastruktur im AGDI "nur" die IP in den Backgroundlayer-Definitionen angepasst werden (zweimal pro Backgroundlayer: einmal für den WMTS und einmal für den Druck-WMS).

Der Standby-Server wird soweit vorbereitet, dass die Caches vorhanden sind. Der Grundbuchplan wird im Falle eines Einsatzes natürlich nicht aktuell sein. Falls ein Cronjob (Gretl-Job) vorhanden ist, wird der Grundbuchplan maximal innerhalb eines Tages (resp. nach Ausführung des Gretl-Jobs) wieder aktuell sein.

## Tägliches Seeding des Planes für das Grundbuch

Für das tägliche Seeden des Grundbuchplanes sind aktuelle Daten auf der Datenbank des externen Servers notwendig. Dieses Kopieren und das Ausführen des Seedens werden in einem [Gretl-Job](https://github.com/sogis/gretljobs/tree/master/agi_wmts_hetzner_seeder) erledigt.

TODO: Infos zum Umgang mit dem Zertifikat.

```
gradle -I init.gradle -PdbUriPub=jdbc:postgresql://geodb_brw.verw.rootso.org:5432/pub -PdbUserPub=bjsvwzie -PdbPwdPub=XXXXXXXXX -PdbUriHetznerWmts=jdbc:postgresql://195.201.45.245:5432/pub -PdbUserHetznerWmts=ddluser -PdbPwdHetznerWmts=XXXXXXXX -PhetznerWmtsServerIp=195.201.45.245
```