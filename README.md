# WeaponBreeder
A customizable Weapon, Item, Armor, or *Anything* breeding system.

Each attribute (or allele) of the customizable entity types are genetically transferrable, allowing for the seeded random generation of weapons and items

### Usage :
```sh
ruby weaponbreeder.rb {int:generations} {int:child_count} {int:generation_delay} {int:fitness_iterations} {bool:display_intermediate_generations}
```
 - __generations__ - _int_ - How many generations to iterate through
 - __children__ - _int_ - How many entities each generation will have
 - __generation_delay__ - _float_ - How long to sleep between generations (seconds)
 - __fitness_iterations__ - int - How many iterations to run for fitness function
 - __display_intermediate_generations__ - bool - show intermetiate generations instead of just last


### Customization:
Seed values are all managed by their respective __Type__ object. All values for all types are merged into the probability cloud to ensure genetic compatability with one another.

You can easily add a new type by adding a new file to the `types` folder. The type will bederived by the filename. Type files are `yml` format and should consist of sequences describing the possible values for each allele.

```YAML
is_mortal:
 - true
 - false
level:
 - 0
 - 10
hit_point:
 - 0
 - 10
sprite:
 - zombie
 - wolf
 - bat
 - slime
 - troll
behavior:
 - wander
 - seek
 - oscillate

```
