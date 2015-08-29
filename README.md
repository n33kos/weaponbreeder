# WeaponBreeder
A customizable Weapon, Item, Armor, or *Anything* breeding system.

Each attribute (or allele) of the customizable entity types are genetically transferrable, allowing for the seeded random generation of weapons and items


### Usage :
```sh
Ruby WeaponBreeder.rb {int:generations} {int:children} {int:generation_delay}
```
 - __generations__ - _int_ - How many generations to iterate through
 - __children__ - _int_ - How many entities each generation will have
 - __generation_delay__ - _float_ - How long to sleep between generations (seconds)
 

### Customization:
Seed values are all managed by their respective __Type__ object. All values for all types are merged into the probability cloud to ensure genetic compatability with one another.

You can easily add a new type by adding a new __Type__ object to the __$probability_cloud__ array.

```ruby
$probability_cloud = generate_probability_cloud([
	Type.new("daisies", {
		:color => ["red","blue","green","white"], #strings
		:height => [1,4], #integer min/max range
		:is_awesome => [true,false] #booleans
	})
])
```
