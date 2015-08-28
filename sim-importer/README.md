# Sim::Importer

change database name in ../config/database.yml to sim_old_production_pg
change database name in config/database.yml to sim_old_production_pg

cd ..
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
cd sim-importer

./bin/run
pg_dump -Fc sim_old_production_pg > old_production.dump
scp -P 20022 old_production.dump root@sim.demo.llp.pl:~/
scp -P 20022 config/ids_mapping.yml lunar@sim.demo.llp.pl:~/apps/sim/current/sim-importer/config/
ssh root@sim.demo.llp.pl -p 20022
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U sim -d sim old_production.dump

cd /home/lunar/apps/sim/current
RAILS_ENV=production bundle exec rake upload_production_photos
RAILS_ENV=production bundle exec rake update_categories
