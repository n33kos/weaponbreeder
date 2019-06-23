# WeaponBreeder
A customizable Weapon, Item, Armor, or *Anything* breeding system.

Each attribute (or allele) of the customizable entity types are genetically transferrable, allowing for the seeded random generation of weapons and items. By default all types are placed into the gene pool and all types are able to breed with one another.

### Usage :
```sh
ruby weaponbreeder.rb [args]
```

 | Argument   |      Type      |  Description |
 |----------|:-------------:|------:|
 | -r --results | Integer | How many results to return |
 | -g --generations | Integer | How many generations to evolve over |
 | -m --mutation-chance | Float | Decimal percentage for how common mutations are |
 | -p --gene-pool-size | Integer | Size of the gene pool for each generation |
 | -d --delay | Integer | Delay between processing generations (in seconds) |
 | -f --fitness-iterations | Integer | How many iterations to run the fitness function for |
 | -t --types-allowed | string | A comma separated list of types to include in the probability cloud |
 | -i --display-intermediate-generations | Flag | Render gene pool for intermediate generations |

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
