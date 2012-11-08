# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Unit.create([
#   {imperial: "%", metric: "%", imperials_per_metric: 1},
#   {imperial: "psi", metric: "MPa", imperials_per_metric: xxxx},
#   {imperial: "lbs/ft3", metric: "kg/m3", imperials_per_metric: 0.0624},
#   {imperial: "F", metric: "C", imperials_per_metric: 0.0}, # 0.0 means to convert manually
#   
# ])
Standard.create([
  {code: "C24-01", description: "pyrometric cone equivalent", unit_id: Unit.find_by_imperial('F').id},
  {code: "C97", description: "bulk gravity", unit_id: Unit.find_by_imperial('lbs/ft3').id},
  {code: "C97", description: "absorption", unit_id: Unit.find_by_imperial('%').id},
  {code: "C97", description: "density", unit_id: Unit.find_by_imperial('lbs/ft3').id},
  {code: "C99", description: "modulus of rupture", unit_id: Unit.find_by_imperial('psi').id},
  {code: "C170", description: "compressive strength", unit_id: Unit.find_by_imperial('psi').id},
  {code: "C241", description: "abrasion resistance", unit_id: Unit.find_by_imperial('Ha').id},
  {code: "C666", description: "freeze thaw", unit_id: Unit.find_by_imperial('%').id},
  {code: "C880", description: "flexural strength", unit_id: Unit.find_by_imperial('psi').id}
])
