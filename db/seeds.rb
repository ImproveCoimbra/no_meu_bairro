# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Municipality.create(ost_id: 379,
                    name: 'Coimbra',
                    driver_str: 'SendMailReportDriver',
                    driver_parameters: {
                        destination_name: 'CMC',
                        destination_mail: 'geral@cm-coimbra.pt'
                    }
)



