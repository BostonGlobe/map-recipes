# setup osm

- Follow https://www.mapbox.com/tilemill/docs/guides/osm-bright-mac-quickstart/, excluding downloading OSM Bright.
- You might have to create a new table or something in psql. Google it.

# download osm data
- Go to download.geofabrik.de, get the files you want.
- Merge them first:

`osmosis --rb bosnia-herzegovina-latest.osm.pbf --rb croatia-latest.osm.pbf --rb hungary-latest.osm.pbf --rb romania-latest.osm.pbf --rb serbia-latest.osm.pbf --m --m --m --m --wb merged.osm.pbf`

- Now import the data (this takes a while):

`osm2pgsql -c -d osm --slim -C 12000 -k --flat-nodes flat-nodes ~/Downloads/merged.osm.pbf`
