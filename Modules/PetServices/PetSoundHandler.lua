-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local u2 = {
    Dog = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    ["Golden Lab"] = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    Cat = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://88617197262546"
    },
    ["Orange Tabby"] = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://136807561780379"
    },
    ["Moon Cat"] = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://136807561780379"
    },
    Bunny = {
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    ["Black Bunny"] = {
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    Chicken = {
        Walk = "rbxassetid://139844945801226"
    },
    Rooster = {
        Walk = "rbxassetid://139844945801226"
    },
    Pig = {
        Walk = "rbxassetid://116135751746611",
        Frenzy = "rbxassetid://116342918915952"
    },
    Cow = {
        Idle = "rbxassetid://119310752148827",
        Walk = "rbxassetid://129633521888708"
    },
    Dragonfly = {
        Walk = "rbxassetid://88913485838830"
    },
    Monkey = {
        Walk = "rbxassetid://112777046526411",
        Steal = "rbxassetid://13772418142759"
    },
    ["Silver Monkey"] = {
        Walk = "rbxassetid://112777046526411",
        Steal = "rbxassetid://13772418142759"
    },
    Snail = {
        Idle = "rbxassetid://123370432487085"
    },
    ["Giant Ant"] = {
        Walk = "rbxassetid://85188904272858",
        Dance = "rbxassetid://104549164564414"
    },
    Turtle = {
        Walk = "rbxassetid://95903584684041"
    },
    Deer = {
        Walk = "rbxassetid://72482977771929",
        Stomp = "rbxassetid://110481608328857"
    },
    ["Spotted Deer"] = {
        Walk = "rbxassetid://72482977771929",
        Stomp = "rbxassetid://110481608328857"
    },
    Caterpillar = {
        Walk = "rbxassetid://122412833570405"
    },
    ["Praying Mantis"] = {
        Walk = "rbxassetid://84713477229850",
        Idle = "rbxassetid://97641683064349",
        Pray = "rbxassetid://73332209725156"
    },
    ["Sea Otter"] = {
        Spray = "rbxassetid://132032269231520",
        Walk = "rbxassetid://111713760896073"
    },
    ["Polar Bear"] = {
        Roar = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    Panda = {
        Walk = "rbxassetid://126208503221327",
        Chomp = "rbxassetid://106994678664275"
    },
    Hedgehog = {
        Idle = "rbxassetid://99389171870232",
        Walk = "rbxassetid://79078872328055",
        Curl = "rbxassetid://109183921043480"
    },
    Kiwi = {
        Idle = "rbxassetid://70643795779986",
        Walk = "rbxassetid://113954129903942",
        Nurse = "rbxassetid://126248680195169"
    },
    Mole = {
        Idle = "rbxassetid://95599243108942",
        Walk = "rbxassetid://109159558883532",
        DigDown = "rbxassetid://122838135787975",
        DigUp = "rbxassetid://87901949070969"
    },
    Frog = {
        Walk = "rbxassetid://115669906209025",
        Croak = "rbxassetid://97143990552632"
    },
    ["Echo Frog"] = {
        Walk = "rbxassetid://133255384275881",
        Croak = "rbxassetid://113309295117031"
    },
    Owl = {
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://103608467045533",
        FlyDown = "rbxassetid://126267742639216",
        FlyUp = "rbxassetid://113660155265682"
    },
    ["Night Owl"] = {
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://103608467045533",
        FlyDown = "rbxassetid://126267742639216",
        FlyUp = "rbxassetid://113660155265682"
    },
    Raccoon = {
        Idle = "rbxassetid://134230704254748",
        Walk = "rbxassetid://72260807159974",
        Steal = "rbxassetid://98750147885192"
    },
    ["Blood Kiwi"] = {
        Idle = "rbxassetid://70643795779986",
        Walk = "rbxassetid://113954129903942",
        Nurse = "rbxassetid://126248680195169"
    },
    ["Blood Hedgehog"] = {
        Idle = "rbxassetid://99389171870232",
        Walk = "rbxassetid://79078872328055",
        Curl = "rbxassetid://109183921043480"
    },
    ["Blood Owl"] = {
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://103608467045533",
        FlyDown = "rbxassetid://126267742639216",
        FlyUp = "rbxassetid://113660155265682"
    },
    ["Chicken Zombie"] = {
        Idle = "rbxassetid://81537385466343",
        Walk = "rbxassetid://77478760027344"
    },
    ["Grey Mouse"] = {
        Idle = "rbxassetid://97778347635709",
        Walk = "rbxassetid://89252475842825"
    },
    Squirrel = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    ["Brown Mouse"] = {
        Idle = "rbxassetid://97778347635709",
        Walk = "rbxassetid://89252475842825"
    },
    ["Red Giant Ant"] = {
        Walk = "rbxassetid://76161666777473",
        Idle = "rbxassetid://131780886746478"
    },
    Fox = {
        Idle = "rbxassetid://130458837573687",
        Walk = "rbxassetid://129545821321602",
        Steal = "rbxassetid://98750147885192"
    },
    Bee = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Honey Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Petal Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Golden Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Bear Bee"] = {
        Walk = "rbxassetid://107497023739294",
        Sit = "rbxassetid://129851107983906"
    },
    ["Queen Bee"] = {
        Idle = "rbxassetid://122660592645582",
        Walk = "rbxassetid://122660592645582",
        Pollinate = "rbxassetid://99031845745055",
        Lead = "rbxassetid://132982275374665"
    },
    Wasp = {
        Pollinate = "rbxassetid://99031845745055",
        Sting = "rbxassetid://113403785478319",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    Moth = {
        Idle = "rbxassetid://79800649815691",
        Walk = "rbxassetid://127482827344286",
        Sing = "rbxassetid://77071003679880"
    },
    ["Tarantula Hawk"] = {
        Pollinate = "rbxassetid://99031845745055",
        Sting = "rbxassetid://113403785478319",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    Butterfly = {
        Idle = "rbxassetid://128008676366287",
        Walk = "rbxassetid://84018547802237",
        Flutter = "rbxassetid://90463210469979"
    },
    ["Disco Bee"] = {
        Dance = "rbxassetid://135576658936030",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Cooked Owl"] = {
        Walk = "rbxassetid://125335397900823",
        Fly = "rbxassetid://71375374141307",
        FlyDown = "rbxassetid://73376480549975",
        FlyUp = "rbxassetid://135267194842326"
    },
    ["Pack Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    Starfish = {
        Walk = "rbxassetid://124497229124515"
    },
    Crab = {
        Walk = "rbxassetid://137490397885881",
        Pinch = "rbxassetid://101619248230134"
    },
    Seagull = {
        Walk = "rbxassetid://134519211827778",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Cuckoo = {
        Idle = "rbxassetid://90982975938855",
        Walk = "rbxassetid://90982975938855"
    },
    Toucan = {
        Walk = "rbxassetid://71775411958781",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Flamingo = {
        Walk = "rbxassetid://124497229124515"
    },
    ["Sea Turtle"] = {
        Walk = "rbxassetid://81508998365618",
        Spin = "rbxassetid://72987965730701"
    },
    Seal = {
        Walk = "rbxassetid://78222935005087"
    },
    Orangutan = {
        Walk = "rbxassetid://72043737830269"
    },
    Peacock = {
        Walk = "rbxassetid://101301427298854",
        Fan = "rbxassetid://73915703683838"
    },
    Capybara = {
        Walk = "rbxassetid://78422835877662"
    },
    Ostrich = {
        Walk = "rbxassetid://113301091663888"
    },
    ["Scarlet Macaw"] = {
        Walk = "rbxassetid://110356736658981",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Mimic Octopus"] = {
        Walk = "rbxassetid://86410817334548",
        Mimicry = "rbxassetid://119828032068847"
    },
    Meerkat = {
        Idle = "rbxassetid://124033074230661",
        Walk = "rbxassetid://138011594997254",
        Stand = "rbxassetid://135190045066509"
    },
    ["Sand Snake"] = {
        Idle = "rbxassetid://75501211177631",
        Walk = "rbxassetid://106280386832026"
    },
    Axolotl = {
        Idle = "rbxassetid://122454346600382",
        Walk = "rbxassetid://132310882154118"
    },
    ["Hyacinth Macaw"] = {
        Walk = "rbxassetid://110356736658981",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Fennec Fox"] = {
        Idle = "rbxassetid://139673820881397",
        Walk = "rbxassetid://98864434206228",
        Steal = "rbxassetid://109928151227010"
    },
    Hamster = {
        Idle = "rbxassetid://92568979802155",
        Walk = "rbxassetid://78896000844765",
        Run = "rbxassetid://76926723835853"
    },
    ["Bald Eagle"] = {
        Idle = "rbxassetid://89177456565600",
        Walk = "rbxassetid://102768068611613",
        Fly = "rbxassetid://83021412338858",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834",
        Spin = "rbxassetid://110526461833717"
    },
    Triceratops = {
        Idle = "rbxassetid://119419781485000",
        Walk = "rbxassetid://72419862408286",
        Run = "rbxassetid://82039485525048",
        Ram = "rbxassetid://112557982594164"
    },
    Stegosaurus = {
        Idle = "rbxassetid://113388221747054",
        Walk = "rbxassetid://71323752540040"
    },
    Raptor = {
        Idle = "rbxassetid://124797301068961",
        Walk = "rbxassetid://96516235550356"
    },
    Brontosaurus = {
        Idle = "rbxassetid://122784337595448",
        Walk = "rbxassetid://135731865962788"
    },
    Pterodactyl = {
        Idle = "rbxassetid://129770489140344",
        Walk = "rbxassetid://111746291935975",
        Flap = "rbxassetid://91250728499728",
        Fly = "rbxassetid://122209192875342",
        FlyDown = "rbxassetid://80605077775457",
        FlyUp = "rbxassetid://100667707044787"
    },
    ["T-Rex"] = {
        Idle = "rbxassetid://92304805767989",
        Walk = "rbxassetid://80676652531002",
        Eat = "rbxassetid://139962613806128",
        Roar = "rbxassetid://95858307486950"
    },
    Ankylosaurus = {
        Idle = "rbxassetid://99141802677334",
        Walk = "rbxassetid://125011954184495"
    },
    Dilophosaurus = {
        Idle = "rbxassetid://114610341541845",
        Walk = "rbxassetid://104694858364201",
        Frill = "rbxassetid://109335879280084"
    },
    Pachycephalosaurus = {
        Idle = "rbxassetid://84343634698599",
        Walk = "rbxassetid://140449840918939"
    },
    Parasaurolophus = {
        Idle = "rbxassetid://78199269149372",
        Walk = "rbxassetid://133162096998870",
        Crowbar = "rbxassetid://117364823639825"
    },
    Spinosaurus = {
        Idle = "rbxassetid://98524735324136",
        Walk = "rbxassetid://114968103668706",
        Eat = "rbxassetid://75118152376278",
        Roar = "rbxassetid://129398782040528"
    },
    Iguanodon = {
        Idle = "rbxassetid://79910895122131",
        Walk = "rbxassetid://127303042386736"
    },
    ["Rainbow Ankylosaurus"] = {
        Idle = "rbxassetid://99141802677334",
        Walk = "rbxassetid://125011954184495"
    },
    ["Rainbow Dilophosaurus"] = {
        Idle = "rbxassetid://114610341541845",
        Walk = "rbxassetid://104694858364201",
        Frill = "rbxassetid://109335879280084"
    },
    ["Rainbow Pachycephalosaurus"] = {
        Idle = "rbxassetid://84343634698599",
        Walk = "rbxassetid://140449840918939"
    },
    ["Rainbow Parasaurolophus"] = {
        Idle = "rbxassetid://78199269149372",
        Walk = "rbxassetid://133162096998870",
        Crowbar = "rbxassetid://117364823639825"
    },
    ["Rainbow Spinosaurus"] = {
        Idle = "rbxassetid://98524735324136",
        Walk = "rbxassetid://114968103668706",
        Eat = "rbxassetid://75118152376278",
        Roar = "rbxassetid://129398782040528"
    },
    ["Rainbow Iguanodon"] = {
        Idle = "rbxassetid://79910895122131",
        Walk = "rbxassetid://127303042386736"
    },
    ["Shiba Inu"] = {
        Idle = "rbxassetid://71888519556410",
        Walk = "rbxassetid://116213352206058",
        Dig = "rbxassetid://84201564054458",
        Play = "rbxassetid://103807916779989"
    },
    Nihonzaru = {
        Idle = "rbxassetid://135317821048418",
        Walk = "rbxassetid://73545348188686",
        Bathe = "rbxassetid://96750632910499"
    },
    Tanuki = {
        Idle = "rbxassetid://134914408771060",
        Walk = "rbxassetid://120043490928927",
        Mischief = "rbxassetid://134914408771060"
    },
    Tanchozuru = {
        Idle = "rbxassetid://132276763392696",
        Walk = "rbxassetid://92777857718180",
        Wings = "rbxassetid://113467819982653"
    },
    Kappa = {
        Idle = "rbxassetid://95999268909469",
        Walk = "rbxassetid://99913630324299",
        Magic = "rbxassetid://107408167945595"
    },
    Kitsune = {
        Idle = "rbxassetid://87102906222964",
        Walk = "rbxassetid://104049108847490",
        Spin = "rbxassetid://89501989901805"
    },
    Koi = {
        Idle = "rbxassetid://108805706480890",
        Walk = "rbxassetid://88429870622041",
        Jump = "rbxassetid://74202384322672"
    },
    Football = {
        Idle = "rbxassetid://121665754635643",
        Walk = "rbxassetid://129085228318902",
        Touchdown = "rbxassetid://120705599519447"
    },
    ["Maneki-neko"] = {
        Idle = "rbxassetid://126430736259456",
        Walk = "rbxassetid://75691085685258",
        Wave = "rbxassetid://136807561780379"
    },
    Kodama = {
        Idle = "rbxassetid://121744729910043",
        Walk = "rbxassetid://130804530913850",
        Dance = "rbxassetid://102240300775981"
    },
    Raiju = {
        Idle = "rbxassetid://93101943880594",
        Walk = "rbxassetid://107777964336069",
        Eat = "rbxassetid://94751642505865",
        Spit = "rbxassetid://107609664703626"
    },
    ["Corrupted Kitsune"] = {
        Idle = "rbxassetid://87102906222964",
        Walk = "rbxassetid://104049108847490",
        Spin = "rbxassetid://89501989901805"
    },
    ["Rainbow Maneki-neko"] = {
        Idle = "rbxassetid://126430736259456",
        Walk = "rbxassetid://75691085685258",
        Wave = "rbxassetid://136807561780379"
    },
    ["Rainbow Kodama"] = {
        Idle = "rbxassetid://121744729910043",
        Walk = "rbxassetid://130804530913850",
        Dance = "rbxassetid://102240300775981"
    },
    ["Rainbow Corrupted Kitsune"] = {
        Idle = "rbxassetid://87102906222964",
        Walk = "rbxassetid://104049108847490",
        Spin = "rbxassetid://89501989901805"
    },
    ["Bagel Bunny"] = {
        Idle = "rbxassetid://80830019163546",
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    ["Pancake Mole"] = {
        Idle = "rbxassetid://95599243108942",
        Walk = "rbxassetid://109159558883532",
        DigDown = "rbxassetid://122838135787975",
        DigUp = "rbxassetid://87901949070969"
    },
    ["Sushi Bear"] = {
        Idle = "rbxassetid://100399217826845",
        Walk = "rbxassetid://100399217826845",
        Roar = "rbxassetid://100918889424478"
    },
    ["Spaghetti Sloth"] = {
        Idle = "rbxassetid://115150731449068",
        Walk = "rbxassetid://107523814512911",
        Stir = "rbxassetid://92651338170371"
    },
    ["French Fry Ferret"] = {
        Idle = "rbxassetid://133281155118942",
        Walk = "rbxassetid://108171827532222",
        Play = "rbxassetid://105398855713096"
    },
    ["Mochi Mouse"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644"
    },
    ["Bacon Pig"] = {
        Walk = "rbxassetid://116135751746611",
        Frenzy = "rbxassetid://116342918915952"
    },
    ["Hotdog Daschund"] = {
        Walk = "rbxassetid://131980972522024",
        Pee = "rbxassetid://91518092841712"
    },
    ["Lobster Thermidor"] = {
        Idle = "rbxassetid://100618154892195",
        Walk = "rbxassetid://85697783104278",
        Boil = "rbxassetid://104675162445573"
    },
    ["Sunny-Side Chicken"] = {
        Walk = "rbxassetid://139844945801226"
    },
    Junkbot = {
        Idle = "rbxassetid://93272584209420",
        Walk = "rbxassetid://90247268825726",
        Oil = "rbxassetid://118415483882012"
    },
    ["Gorilla Chef"] = {
        Idle = "rbxassetid://91292826047910",
        Walk = "rbxassetid://112018455441234",
        Stir = "rbxassetid://74005374188609"
    },
    ["Rainbow Bacon Pig"] = {
        Walk = "rbxassetid://116135751746611",
        Frenzy = "rbxassetid://116342918915952"
    },
    ["Rainbow Hotdog Daschund"] = {
        Walk = "rbxassetid://131980972522024",
        Pee = "rbxassetid://91518092841712"
    },
    ["Rainbow Lobster Thermidor"] = {
        Idle = "rbxassetid://100618154892195",
        Walk = "rbxassetid://85697783104278",
        Boil = "rbxassetid://104675162445573"
    },
    ["Dairy Cow"] = {
        Idle = "rbxassetid://119310752148827",
        Walk = "rbxassetid://129633521888708"
    },
    Jackalope = {
        Idle = "rbxassetid://107364087679831",
        Walk = "rbxassetid://90673880075997",
        Thump = "rbxassetid://73312324491008"
    },
    Seedling = {
        Idle = "rbxassetid://137990359620182",
        Walk = "rbxassetid://101870770594666",
        Bless = "rbxassetid://105990760955609"
    },
    Golem = {
        Walk = "rbxassetid://139497860067157",
        Idle = "rbxassetid://93439317171326",
        Tinker = "rbxassetid://116450241959684"
    },
    ["Gold Finch"] = {
        Walk = "rbxassetid://97890807282861",
        Idle = "rbxassetid://97890807282861"
    },
    ["Golden Goose"] = {
        Idle = "rbxassetid://129053065867617",
        Walk = "rbxassetid://96746435324653",
        Lay = "rbxassetid://139495366690864"
    },
    Spriggan = {
        Idle = "rbxassetid://91575051165469",
        Walk = "rbxassetid://75942027064762",
        Overgrowth = "rbxassetid://86935512954276"
    },
    ["Peach Wasp"] = {
        Pollinate = "rbxassetid://99031845745055",
        Sting = "rbxassetid://113403785478319",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Apple Gazelle"] = {
        Idle = "rbxassetid://71743917811983",
        Walk = "rbxassetid://77545733275421"
    },
    ["Lemon Lion"] = {
        Idle = "rbxassetid://81514957954038",
        Walk = "rbxassetid://120120865113664",
        Roar = "rbxassetid://132737800952486"
    },
    Elk = {
        Walk = "rbxassetid://72482977771929",
        Stomp = "rbxassetid://110481608328857"
    },
    Mandrake = {
        Idle = "rbxassetid://87147842486934",
        Walk = "rbxassetid://137533465679031",
        Magic = "rbxassetid://76790654545392"
    },
    Griffin = {
        Idle = "rbxassetid://129074703805811",
        Walk = "rbxassetid://110165477248052",
        Fly = "rbxassetid://71138030319313",
        FlyDown = "rbxassetid://112716030067072",
        FlyUp = "rbxassetid://97839556679489",
        Flaunt = "rbxassetid://99423522398360"
    },
    ["Green Bean"] = {
        Idle = "rbxassetid://72949554388737",
        Walk = "rbxassetid://103182496515924",
        Sacrifice = "rbxassetid://72949554388737"
    },
    Gnome = {
        Idle = "rbxassetid://117684715562874",
        Walk = "rbxassetid://85787412798122"
    },
    ["Rainbow Elk"] = {
        Walk = "rbxassetid://72482977771929",
        Stomp = "rbxassetid://110481608328857"
    },
    ["Rainbow Mandrake"] = {
        Idle = "rbxassetid://87147842486934",
        Walk = "rbxassetid://137533465679031",
        Magic = "rbxassetid://76790654545392"
    },
    ["Rainbow Griffin"] = {
        Idle = "rbxassetid://129074703805811",
        Walk = "rbxassetid://110165477248052",
        Fly = "rbxassetid://71138030319313",
        FlyDown = "rbxassetid://112716030067072",
        FlyUp = "rbxassetid://97839556679489",
        Flaunt = "rbxassetid://99423522398360"
    },
    Ladybug = {
        Idle = "rbxassetid://137517050462421",
        Walk = "rbxassetid://129964746102969"
    },
    Pixie = {
        Idle = "rbxassetid://129244470925716",
        Walk = "rbxassetid://73090075715293",
        Dust = "rbxassetid://106878357058936"
    },
    Imp = {
        Idle = "rbxassetid://101402930111977",
        Walk = "rbxassetid://115146504922278",
        Jump = "rbxassetid://130157282577000"
    },
    ["Glimmering Sprite"] = {
        Idle = "rbxassetid://70880859489431",
        Walk = "rbxassetid://84102770397001",
        Glimmer = "rbxassetid://126067355158115"
    },
    Cockatrice = {
        Idle = "rbxassetid://82186459844527",
        Walk = "rbxassetid://125878518804739",
        Screech = "rbxassetid://72263933323945",
        Spit = "rbxassetid://76816842314937"
    },
    Cardinal = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Shroomie = {
        Idle = "rbxassetid://116019916283749",
        Walk = "rbxassetid://133714105814569"
    },
    Phoenix = {
        Idle = "rbxassetid://93895326347815",
        Walk = "rbxassetid://135458442132271",
        Dive = "rbxassetid://93895326347815"
    },
    Wisp = {
        Idle = "rbxassetid://114282495356514",
        Walk = "rbxassetid://121043816008707",
        Spin = "rbxassetid://136319550863763"
    },
    Drake = {
        Idle = "rbxassetid://116884180841320",
        Walk = "rbxassetid://91979103574680",
        Fire = "rbxassetid://83696226919369"
    },
    ["Rainbow Cardinal"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Shroomie"] = {
        Idle = "rbxassetid://116019916283749",
        Walk = "rbxassetid://133714105814569"
    },
    ["Rainbow Phoenix"] = {
        Idle = "rbxassetid://93895326347815",
        Walk = "rbxassetid://135458442132271",
        Dive = "rbxassetid://93895326347815"
    },
    ["Luminous Sprite"] = {
        Idle = "rbxassetid://70880859489431",
        Walk = "rbxassetid://84102770397001",
        Illuminate = "rbxassetid://126067355158115"
    },
    Robin = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Badger = {
        Idle = "rbxassetid://114301619177297",
        Walk = "rbxassetid://94764157039106",
        Dig = "rbxassetid://134213807627174"
    },
    ["Grizzly Bear"] = {
        Idle = "rbxassetid://100399217826845",
        Walk = "rbxassetid://100399217826845",
        Roar = "rbxassetid://100918889424478"
    },
    ["Barn Owl"] = {
        Idle = "rbxassetid://129074703805811",
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://103608467045533",
        FlyDown = "rbxassetid://126267742639216",
        FlyUp = "rbxassetid://113660155265682"
    },
    Swan = {
        Idle = "rbxassetid://103648273864726",
        Walk = "rbxassetid://75104001870811",
        Sing = "rbxassetid://137665381449278"
    },
    ["Rainbow Robin"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Badger"] = {
        Idle = "rbxassetid://114301619177297",
        Walk = "rbxassetid://94764157039106",
        Dig = "rbxassetid://134213807627174"
    },
    ["Rainbow Grizzly Bear"] = {
        Idle = "rbxassetid://100399217826845",
        Walk = "rbxassetid://100399217826845",
        Roar = "rbxassetid://100918889424478"
    },
    ["Rainbow Barn Owl"] = {
        Idle = "rbxassetid://129074703805811",
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Swan"] = {
        Idle = "rbxassetid://103648273864726",
        Walk = "rbxassetid://75104001870811",
        Sing = "rbxassetid://137665381449278"
    },
    ["Red Squirrel"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    Chipmunk = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    Marmot = {
        Idle = "rbxassetid://104303252479964",
        Walk = "rbxassetid://85491596199451",
        DigDown = "rbxassetid://122838135787975",
        DigUp = "rbxassetid://87901949070969"
    },
    ["Sugar Glider"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://130762325822735"
    },
    ["Space Squirrel"] = {
        Idle = "rbxassetid://102655899175277",
        Walk = "rbxassetid://130554844180020"
    },
    Salmon = {
        Idle = "rbxassetid://118473094826584",
        Walk = "rbxassetid://128868000002970"
    },
    Woodpecker = {
        Idle = "rbxassetid://77148704770744",
        Walk = "rbxassetid://90509061709776",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834",
        Peck = "rbxassetid://121780589391675"
    },
    Mallard = {
        Idle = "rbxassetid://82215667152758",
        Fly = "rbxassetid://135337078062278"
    },
    ["Red Panda"] = {
        Idle = "rbxassetid://98124216850960",
        Walk = "rbxassetid://123362618522933",
        Cute = "rbxassetid://78407580577296"
    },
    ["Tree Frog"] = {
        Idle = "rbxassetid://78549392598741",
        Walk = "rbxassetid://81185249043652",
        Croak = "rbxassetid://114941663767532"
    },
    Hummingbird = {
        Walk = "rbxassetid://120628386657802"
    },
    Iguana = {
        Idle = "rbxassetid://101004947591015",
        Walk = "rbxassetid://130875451600978",
        Lying = "rbxassetid://132263982605200"
    },
    Chimpanzee = {
        Idle = "rbxassetid://83224948063982",
        Walk = "rbxassetid://90951262590242",
        Carry = "rbxassetid://119098723940955"
    },
    Tiger = {
        Idle = "rbxassetid://79938940309796",
        Walk = "rbxassetid://137862666039684",
        Roar = "rbxassetid://114105373171031"
    },
    ["Blue Jay"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Silver Dragonfly"] = {
        Idle = "rbxassetid://77220774723390",
        Walk = "rbxassetid://88913485838830"
    },
    Firefly = {
        Idle = "rbxassetid://76157041575597",
        Walk = "rbxassetid://76157041575597"
    },
    Mizuchi = {
        Idle = "rbxassetid://76271686512046",
        Walk = "rbxassetid://137349480002830",
        Roar = "rbxassetid://128836280480873"
    },
    ["Rainbow Fortune Squirrel"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906",
        Fortune = "rbxassetid://113288365434429"
    },
    ["Rainbow Blue Jay"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["GIANT Silver Dragonfly"] = {
        Idle = "rbxassetid://77220774723390",
        Walk = "rbxassetid://88913485838830"
    },
    ["GIANT Firefly"] = {
        Idle = "rbxassetid://76157041575597",
        Walk = "rbxassetid://76157041575597"
    },
    ["Rainbow Mizuchi"] = {
        Idle = "rbxassetid://76271686512046",
        Walk = "rbxassetid://137349480002830",
        Roar = "rbxassetid://128836280480873"
    },
    ["Chubby Chipmunk"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906",
        Eat = "rbxassetid://91545917920155"
    },
    ["Farmer Chipmunk"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    ["Idol Chipmunk"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    Chinchilla = {
        Idle = "rbxassetid://77574866979930",
        Walk = "rbxassetid://97239399646987",
        Dust = "rbxassetid://115533598709971"
    },
    Hyrax = {
        Idle = "rbxassetid://125401477530369",
        Walk = "rbxassetid://91860604755869",
        Chomp = "rbxassetid://120112992373115"
    },
    ["Fortune Squirrel"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906",
        Fortune = "rbxassetid://113288365434429"
    },
    Bat = {
        Idle = "rbxassetid://95312483963988",
        Walk = "rbxassetid://83093213704558"
    },
    ["Bone Dog"] = {
        Idle = "rbxassetid://73700834335592",
        Walk = "rbxassetid://83013450094941",
        Dig = "rbxassetid://131684637288806"
    },
    Spider = {
        Idle = "rbxassetid://103807012076708",
        Walk = "rbxassetid://93697932933763",
        Weave = "rbxassetid://128945359726851"
    },
    ["Black Cat"] = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://136807561780379"
    },
    ["Headless Horseman"] = {
        Idle = "rbxassetid://108689600091071",
        Walk = "rbxassetid://126046898549016",
        Rein = "rbxassetid://133964380028710"
    },
    ["Ghostly Bat"] = {
        Idle = "rbxassetid://95312483963988",
        Walk = "rbxassetid://83093213704558"
    },
    ["Ghostly Bone Dog"] = {
        Idle = "rbxassetid://73700834335592",
        Walk = "rbxassetid://83013450094941",
        Dig = "rbxassetid://131684637288806"
    },
    ["Ghostly Spider"] = {
        Idle = "rbxassetid://103807012076708",
        Walk = "rbxassetid://93697932933763",
        Weave = "rbxassetid://128945359726851"
    },
    ["Ghostly Black Cat"] = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://136807561780379"
    },
    ["Ghostly Headless Horseman"] = {
        Idle = "rbxassetid://108689600091071",
        Walk = "rbxassetid://126046898549016",
        Rein = "rbxassetid://133964380028710"
    },
    ["Pumpkin Rat"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644",
        Carve = "rbxassetid://134576216190254"
    },
    ["Ghost Bear"] = {
        Roar = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    Wolf = {
        Idle = "rbxassetid://88728313020733",
        Walk = "rbxassetid://132574825481094",
        Howl = "rbxassetid://125236041202689"
    },
    Reaper = {
        Idle = "rbxassetid://117975421848702",
        Scythe = "rbxassetid://127695822014814"
    },
    Crow = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Goat = {
        Idle = "rbxassetid://105822668591831",
        Walk = "rbxassetid://132252961466982",
        Ram = "rbxassetid://105822668591831"
    },
    Goblin = {
        Idle = "rbxassetid://117369583070457",
        Walk = "rbxassetid://120721854346874",
        Carry = "rbxassetid://120721854346874"
    },
    ["Dark Spriggan"] = {
        Idle = "rbxassetid://91575051165469",
        Walk = "rbxassetid://75942027064762",
        Overgrowth = "rbxassetid://86935512954276"
    },
    ["Hex Serpent"] = {
        Idle = "rbxassetid://75501211177631",
        Walk = "rbxassetid://106280386832026",
        Hex = "rbxassetid://128339477640652"
    },
    ["Ghostly Dark Spriggan"] = {
        Idle = "rbxassetid://91575051165469",
        Walk = "rbxassetid://75942027064762",
        Overgrowth = "rbxassetid://86935512954276"
    },
    Scarab = {
        Idle = "rbxassetid://74544516706549",
        Walk = "rbxassetid://136151388430046"
    },
    ["Tomb Marmot"] = {
        Idle = "rbxassetid://104303252479964",
        Walk = "rbxassetid://85491596199451",
        DigDown = "rbxassetid://122838135787975",
        DigUp = "rbxassetid://87901949070969"
    },
    Mummy = {
        Idle = "rbxassetid://92639615768147",
        Walk = "rbxassetid://125593396046564"
    },
    ["Ghostly Scarab"] = {
        Idle = "rbxassetid://74544516706549",
        Walk = "rbxassetid://136151388430046"
    },
    ["Ghostly Tomb Marmot"] = {
        Idle = "rbxassetid://104303252479964",
        Walk = "rbxassetid://85491596199451",
        DigDown = "rbxassetid://122838135787975",
        DigUp = "rbxassetid://87901949070969"
    },
    ["Ghostly Mummy"] = {
        Idle = "rbxassetid://92639615768147",
        Walk = "rbxassetid://125593396046564"
    },
    Specter = {
        Idle = "rbxassetid://139092534533157",
        Walk = "rbxassetid://103345850127497",
        Haunt = "rbxassetid://75915615514863"
    },
    Lich = {
        Idle = "rbxassetid://75052308247307",
        Walk = "rbxassetid://82655086049292",
        Conjure = "rbxassetid://106255674630333"
    },
    Woody = {
        Idle = "rbxassetid://108595453616119",
        Walk = "rbxassetid://139629428874699",
        Dance = "rbxassetid://104016339941290"
    },
    ["Glass Dog"] = {
        Idle = "rbxassetid://74516706583472",
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    ["Glass Cat"] = {
        Idle = "rbxassetid://126430736259456",
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://88617197262546"
    },
    Oxpecker = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Zebra = {
        Idle = "rbxassetid://103114730568735",
        Walk = "rbxassetid://134163636378156",
        Run = "rbxassetid://82658544109844",
        Stand = "rbxassetid://79626217950308"
    },
    Giraffe = {
        Idle = "rbxassetid://106458046742227",
        Walk = "rbxassetid://134201804320470",
        Graze = "rbxassetid://70818578156573"
    },
    Rhino = {
        Idle = "rbxassetid://82400652259323",
        Walk = "rbxassetid://138329859720215",
        Run = "rbxassetid://116226332909321",
        Ram = "rbxassetid://106970317107410"
    },
    Elephant = {
        Idle = "rbxassetid://106095899285858",
        Walk = "rbxassetid://131299055217536",
        Trumpet = "rbxassetid://99644691810174"
    },
    Armadillo = {
        Idle = "rbxassetid://133537531319442",
        Walk = "rbxassetid://111148328525379",
        Roll = "rbxassetid://108125482450638"
    },
    ["Stag Beetle"] = {
        Idle = "rbxassetid://119223203218217",
        Walk = "rbxassetid://119223203218217",
        Fight = "rbxassetid://81518878788978"
    },
    ["Mantis Shrimp"] = {
        Idle = "rbxassetid://101422107566828",
        Walk = "rbxassetid://118635697275806",
        Punch = "rbxassetid://124598188233727"
    },
    Hydra = {
        Idle = "rbxassetid://115056123048154",
        Walk = "rbxassetid://99628307336768",
        Head1 = "rbxassetid://105703681155973",
        Head2 = "rbxassetid://105703681155973",
        Head3 = "rbxassetid://105703681155973"
    },
    ["Rainbow Oxpecker"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Zebra"] = {
        Idle = "rbxassetid://103114730568735",
        Walk = "rbxassetid://134163636378156",
        Run = "rbxassetid://82658544109844"
    },
    ["Rainbow Giraffe"] = {
        Idle = "rbxassetid://106458046742227",
        Walk = "rbxassetid://134201804320470",
        Graze = "rbxassetid://70818578156573"
    },
    ["Rainbow Rhino"] = {
        Idle = "rbxassetid://82400652259323",
        Walk = "rbxassetid://138329859720215",
        Run = "rbxassetid://116226332909321",
        Ram = "rbxassetid://106970317107410"
    },
    ["Rainbow Elephant"] = {
        Idle = "rbxassetid://106095899285858",
        Walk = "rbxassetid://131299055217536",
        Trumpet = "rbxassetid://99644691810174"
    },
    ["GIANT Armadillo"] = {
        Idle = "rbxassetid://133537531319442",
        Walk = "rbxassetid://111148328525379",
        Roll = "rbxassetid://108125482450638"
    },
    ["Rainbow Stag Beetle"] = {
        Idle = "rbxassetid://119223203218217",
        Walk = "rbxassetid://119223203218217",
        Fight = "rbxassetid://81518878788978"
    },
    ["GIANT Mantis Shrimp"] = {
        Idle = "rbxassetid://101422107566828",
        Walk = "rbxassetid://118635697275806",
        Punch = "rbxassetid://124598188233727"
    },
    ["Rainbow Hydra"] = {
        Idle = "rbxassetid://115056123048154",
        Walk = "rbxassetid://99628307336768",
        Head1 = "rbxassetid://105703681155973",
        Head2 = "rbxassetid://105703681155973",
        Head3 = "rbxassetid://105703681155973"
    },
    Gecko = {
        Idle = "rbxassetid://125531726119452",
        Walk = "rbxassetid://124907327406485"
    },
    Hyena = {
        Idle = "rbxassetid://112799982415446",
        Walk = "rbxassetid://114673306490963"
    },
    ["Cape Buffalo"] = {
        Idle = "rbxassetid://90962460144042",
        Walk = "rbxassetid://86433768115895"
    },
    Hippo = {
        Idle = "rbxassetid://99489205870899",
        Walk = "rbxassetid://95096144637584",
        Chomp = "rbxassetid://110694581104845"
    },
    Crocodile = {
        Idle = "rbxassetid://92639615768147",
        Walk = "rbxassetid://82909303177155",
        Roll = "rbxassetid://129778574485157"
    },
    Lion = {
        Idle = "rbxassetid://127030702558345",
        Walk = "rbxassetid://80530021817282",
        Roar = "rbxassetid://131398673745689"
    },
    Cheetah = {
        Idle = "rbxassetid://120631719071811",
        Walk = "rbxassetid://100207688306120",
        Run = "rbxassetid://89315302832127",
        Jump = ""
    },
    ["Topaz Snail"] = {
        Idle = "rbxassetid://123370432487085"
    },
    ["Amethyst Beetle"] = {
        Idle = "rbxassetid://119223203218217",
        Walk = "rbxassetid://119223203218217",
        Fight = "rbxassetid://81518878788978"
    },
    ["Emerald Snake"] = {
        Idle = "rbxassetid://75501211177631",
        Walk = "rbxassetid://106280386832026"
    },
    ["Sapphire Macaw"] = {
        Walk = "rbxassetid://110356736658981",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Diamond Panther"] = {
        Idle = "rbxassetid://127030702558345",
        Walk = "rbxassetid://80530021817282",
        Roar = "rbxassetid://131398673745689"
    },
    ["Ruby Squid"] = {
        Idle = "rbxassetid://86497514353700",
        Walk = "rbxassetid://79670871735841",
        Squirm = "rbxassetid://91714018194070"
    },
    Termite = {
        Idle = "rbxassetid://109262061509258",
        Walk = "rbxassetid://119463591717839",
        Eat = "rbxassetid://105644647393019"
    },
    ["Geode Turtle"] = {
        Walk = "rbxassetid://81508998365618",
        Spin = "rbxassetid://72987965730701",
        Splash = "rbxassetid://72987965730701"
    },
    ["Trapdoor Spider"] = {
        Idle = "rbxassetid://97698043065815",
        Walk = "rbxassetid://113527720179360"
    },
    ["Goblin Miner"] = {
        Idle = "rbxassetid://117369583070457",
        Walk = "rbxassetid://120721854346874",
        Mine = "rbxassetid://86290530989806"
    },
    ["Silver Piggy"] = {
        Walk = "rbxassetid://116135751746611"
    },
    ["Golden Piggy"] = {
        Walk = "rbxassetid://116135751746611"
    },
    Clam = {
        Idle = "rbxassetid://118473094826584",
        Walk = "rbxassetid://128868000002970"
    },
    Magpie = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Bearded Dragon"] = {
        Idle = "rbxassetid://96057767665055",
        Walk = "rbxassetid://104953959052312",
        Spin = "rbxassetid://96057767665055"
    },
    ["Rainbow Clam"] = {
        Idle = "rbxassetid://118473094826584",
        Walk = "rbxassetid://128868000002970"
    },
    ["Rainbow Magpie"] = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Bearded Dragon"] = {
        Idle = "rbxassetid://96057767665055",
        Walk = "rbxassetid://104953959052312",
        Spin = "rbxassetid://96057767665055"
    },
    ["Pack Mule"] = {
        Idle = "rbxassetid://72168697044828",
        Walk = "rbxassetid://134163636378156"
    },
    ["Water Buffalo"] = {
        Idle = "rbxassetid://83773855436063",
        Walk = "rbxassetid://122266402056852",
        Grab = "rbxassetid://83773855436063"
    },
    Chimera = {
        Idle = "rbxassetid://136622453780896",
        Walk = "rbxassetid://108364429483845",
        Roar = "rbxassetid://99789507453292",
        Charge = "rbxassetid://77468980243870",
        Stand = "rbxassetid://120281740623004"
    },
    Sheckling = {
        Idle = "rbxassetid://137990359620182",
        Walk = "rbxassetid://101870770594666",
        Bless = "rbxassetid://105990760955609"
    },
    ["Messenger Pigeon"] = {
        Idle = "rbxassetid://106041598873684",
        Walk = "rbxassetid://108418344670667",
        Fly = "rbxassetid://87470063105639",
        FlyDown = "rbxassetid://89158119399685",
        FlyUp = "rbxassetid://93206859496781"
    },
    Camel = {
        Idle = "rbxassetid://124522347892442",
        Walk = "rbxassetid://113964680505851",
        Eat = "rbxassetid://91334105261520"
    },
    ["Snowman Builder"] = {
        Walk = "rbxassetid://76989997959860",
        Build = "rbxassetid://128947221537935"
    },
    ["Snowman Soldier"] = {
        Idle = "rbxassetid://103410512777328",
        Walk = "rbxassetid://70861007167696",
        Throw = "rbxassetid://116217861606866"
    },
    ["Arctic Fox"] = {
        Idle = "rbxassetid://130458837573687",
        Walk = "rbxassetid://129545821321602",
        Steal = "rbxassetid://98750147885192"
    },
    ["Frost Dragon"] = {
        Idle = "rbxassetid://96559573803971",
        Walk = "rbxassetid://93009972171138",
        Fly = "rbxassetid://73044662346459",
        FlyDown = "rbxassetid://112273890169977",
        FlyUp = "rbxassetid://120025906797071",
        Breathe = "rbxassetid://116322839157068"
    },
    ["Gift Rat"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644",
        Carve = "rbxassetid://134576216190254"
    },
    Penguin = {
        Idle = "rbxassetid://76677061194663",
        Walk = "rbxassetid://84644837001529",
        Slide = "rbxassetid://103845927605085"
    },
    ["Snow Bunny"] = {
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    ["French Hen"] = {
        Walk = "rbxassetid://139844945801226"
    },
    ["Christmas Gorilla"] = {
        Idle = "rbxassetid://91292826047910",
        Walk = "rbxassetid://112018455441234",
        Stir = "rbxassetid://74005374188609"
    },
    Mistletoad = {
        Walk = "rbxassetid://115669906209025",
        Croak = "rbxassetid://97143990552632"
    },
    Krampus = {
        Idle = "rbxassetid://100692335896590",
        Walk = "rbxassetid://114303907208753",
        Punish = "rbxassetid://130462624017520"
    },
    ["GIANT Snowman Builder"] = {
        Walk = "rbxassetid://76989997959860",
        Build = "rbxassetid://128947221537935"
    },
    ["GIANT Snowman Soldier"] = {
        Idle = "rbxassetid://103410512777328",
        Walk = "rbxassetid://70861007167696",
        Throw = "rbxassetid://116217861606866"
    },
    ["Rainbow Arctic Fox"] = {
        Idle = "rbxassetid://130458837573687",
        Walk = "rbxassetid://129545821321602",
        Steal = "rbxassetid://98750147885192"
    },
    ["Rainbow Frost Dragon"] = {
        Idle = "rbxassetid://96559573803971",
        Walk = "rbxassetid://93009972171138",
        Fly = "rbxassetid://73044662346459",
        FlyDown = "rbxassetid://112273890169977",
        FlyUp = "rbxassetid://120025906797071",
        Breathe = "rbxassetid://116322839157068"
    },
    ["Rainbow Gift Rat"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644",
        Carve = "rbxassetid://134576216190254"
    },
    ["Rainbow Penguin"] = {
        Idle = "rbxassetid://76677061194663",
        Walk = "rbxassetid://84644837001529",
        Slide = "rbxassetid://103845927605085"
    },
    ["Rainbow Snow Bunny"] = {
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    ["Rainbow French Hen"] = {
        Walk = "rbxassetid://139844945801226"
    },
    ["Rainbow Christmas Gorilla"] = {
        Idle = "rbxassetid://91292826047910",
        Walk = "rbxassetid://112018455441234",
        Stir = "rbxassetid://74005374188609"
    },
    ["Rainbow Mistletoad"] = {
        Walk = "rbxassetid://115669906209025",
        Croak = "rbxassetid://97143990552632"
    },
    ["Rainbow Krampus"] = {
        Idle = "rbxassetid://100692335896590",
        Walk = "rbxassetid://114303907208753",
        Punish = "rbxassetid://130462624017520"
    },
    ["Turtle Dove"] = {
        Idle = "rbxassetid://106041598873684",
        Walk = "rbxassetid://108418344670667",
        Fly = "rbxassetid://87470063105639",
        FlyDown = "rbxassetid://89158119399685",
        FlyUp = "rbxassetid://93206859496781"
    },
    Nutcracker = {
        Walk = "rbxassetid://112682059195900",
        Nutcrack = "rbxassetid://121331954198331"
    },
    Reindeer = {
        Idle = "rbxassetid://86027726187753",
        Walk = "rbxassetid://136101426081513",
        Spin = "rbxassetid://102809626274554"
    },
    Yeti = {
        Idle = "rbxassetid://85932247723296",
        Walk = "rbxassetid://110720723687469",
        Roar = "rbxassetid://102497531055885",
        Eat = "rbxassetid://114526771673386"
    },
    ["Ice Golem"] = {
        Idle = "rbxassetid://102286994221688",
        Walk = "rbxassetid://90703620506829"
    },
    ["Festive Turtle Dove"] = {
        Idle = "rbxassetid://106041598873684",
        Walk = "rbxassetid://108418344670667",
        Fly = "rbxassetid://87470063105639",
        FlyDown = "rbxassetid://89158119399685",
        FlyUp = "rbxassetid://93206859496781"
    },
    ["Festive Nutcracker"] = {
        Idle = "rbxassetid://0",
        Walk = "rbxassetid://112682059195900",
        Nutcrack = "rbxassetid://121331954198331"
    },
    ["Festive Reindeer"] = {
        Idle = "rbxassetid://86027726187753",
        Walk = "rbxassetid://136101426081513",
        Spin = "rbxassetid://102809626274554"
    },
    ["Festive Yeti"] = {
        Idle = "rbxassetid://85932247723296",
        Walk = "rbxassetid://110720723687469",
        Roar = "rbxassetid://102497531055885",
        Eat = "rbxassetid://114526771673386"
    },
    ["Festive Ice Golem"] = {
        Idle = "rbxassetid://102286994221688",
        Walk = "rbxassetid://90703620506829"
    },
    ["Pine Beetle"] = {
        Idle = "rbxassetid://119223203218217",
        Walk = "rbxassetid://119223203218217",
        Fight = "rbxassetid://81518878788978"
    },
    ["Cocoa Cat"] = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://88617197262546"
    },
    ["Eggnog Chick"] = {
        Walk = "rbxassetid://139844945801226"
    },
    ["Red-Nosed Reindeer"] = {
        Idle = "rbxassetid://86027726187753",
        Walk = "rbxassetid://136101426081513",
        Spin = "rbxassetid://102809626274554"
    },
    Partridge = {
        Idle = "rbxassetid://70643795779986",
        Nurse = "rbxassetid://126248680195169"
    },
    ["Santa Bear"] = {
        Roar = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    Moose = {
        Idle = "rbxassetid://122903917879273",
        Walk = "rbxassetid://113657336420160",
        Eat = "rbxassetid://110920993586591",
        Call = "rbxassetid://86551006368940"
    },
    ["Frost Squirrel"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    Wendigo = {
        Idle = "rbxassetid://71787939130516",
        Walk = "rbxassetid://128736102157068",
        Roar = "rbxassetid://77568866505408"
    },
    ["Festive Partridge"] = {
        Idle = "rbxassetid://70643795779986",
        Nurse = "rbxassetid://126248680195169"
    },
    ["Festive Santa Bear"] = {
        Roar = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    ["Festive Moose"] = {
        Idle = "rbxassetid://122903917879273",
        Walk = "rbxassetid://113657336420160",
        Eat = "rbxassetid://110920993586591",
        Call = "rbxassetid://86551006368940"
    },
    ["Festive Frost Squirrel"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    ["Festive Wendigo"] = {
        Idle = "rbxassetid://71787939130516",
        Walk = "rbxassetid://128736102157068",
        Roar = "rbxassetid://77568866505408"
    },
    ["Summer Kiwi"] = {
        Idle = "rbxassetid://70643795779986",
        Walk = "rbxassetid://113954129903942",
        Nurse = "rbxassetid://126248680195169"
    },
    ["Christmas Spirit"] = {
        Idle = "rbxassetid://75229945518858",
        Walk = "rbxassetid://83226328794834",
        Dance = "rbxassetid://130566567530344"
    },
    ["New Year\'s Bird"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Firework Sprite"] = {
        Idle = "rbxassetid://70880859489431",
        Walk = "rbxassetid://84102770397001",
        Glimmer = "rbxassetid://126067355158115"
    },
    ["Celebration Puppy"] = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    ["New Year\'s Chimp"] = {
        Idle = "rbxassetid://83224948063982",
        Walk = "rbxassetid://90951262590242",
        Carry = "rbxassetid://119098723940955"
    },
    ["Star Wolf"] = {
        Idle = "rbxassetid://88728313020733",
        Walk = "rbxassetid://132574825481094",
        Howl = "rbxassetid://125236041202689"
    },
    ["New Year\'s Dragon"] = {
        Idle = "rbxassetid://96559573803971",
        Walk = "rbxassetid://93009972171138",
        Fly = "rbxassetid://73044662346459",
        FlyDown = "rbxassetid://112273890169977",
        FlyUp = "rbxassetid://120025906797071",
        Breathe = "rbxassetid://116322839157068"
    },
    ["Rainbow New Year\'s Bird"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Firework Sprite"] = {
        Idle = "rbxassetid://70880859489431",
        Walk = "rbxassetid://84102770397001",
        Glimmer = "rbxassetid://126067355158115"
    },
    ["Rainbow Celebration Puppy"] = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    ["Rainbow New Year\'s Chimp"] = {
        Idle = "rbxassetid://83224948063982",
        Walk = "rbxassetid://90951262590242",
        Carry = "rbxassetid://119098723940955"
    },
    ["Rainbow Star Wolf"] = {
        Idle = "rbxassetid://88728313020733",
        Walk = "rbxassetid://132574825481094",
        Howl = "rbxassetid://125236041202689"
    },
    ["Rainbow New Year\'s Dragon"] = {
        Idle = "rbxassetid://104400394504910",
        Walk = "rbxassetid://99076367548697",
        Fly = "rbxassetid://131632458205530",
        FlyDown = "rbxassetid://115823131753439",
        FlyUp = "rbxassetid://77104596494975",
        Breathe = "rbxassetid://70492108388906"
    },
    ["Unicycle Monkey"] = {
        Idle = "rbxassetid://13772418142759"
    },
    ["Performer Seal"] = {
        Walk = "rbxassetid://78222935005087"
    },
    ["Bear on Bike"] = {
        Fall = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    ["Show Pony"] = {
        Idle = "rbxassetid://103114730568735",
        Walk = "rbxassetid://134163636378156",
        Run = "rbxassetid://82658544109844"
    },
    ["Carnival Elephant"] = {
        Idle = "rbxassetid://106095899285858",
        Walk = "rbxassetid://131299055217536",
        Trumpet = "rbxassetid://99644691810174"
    },
    ["Rainbow Unicycle Monkey"] = {
        Idle = "rbxassetid://13772418142759"
    },
    ["Rainbow Performer Seal"] = {
        Walk = "rbxassetid://78222935005087"
    },
    ["Rainbow Bear on Bike"] = {
        Fall = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    ["Rainbow Show Pony"] = {
        Idle = "rbxassetid://103114730568735",
        Walk = "rbxassetid://134163636378156",
        Run = "rbxassetid://82658544109844"
    },
    ["Rainbow Carnival Elephant"] = {
        Idle = "rbxassetid://106095899285858",
        Walk = "rbxassetid://131299055217536",
        Trumpet = "rbxassetid://99644691810174"
    },
    ["Angora Goat"] = {
        Idle = "rbxassetid://105822668591831",
        Walk = "rbxassetid://132252961466982",
        Ram = "rbxassetid://105822668591831"
    },
    Tsuchinoko = {
        Idle = "rbxassetid://124252788066125",
        Walk = "rbxassetid://97857078919719"
    },
    ["Wind-Up Rat"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644",
        Carve = "rbxassetid://134576216190254"
    },
    ["Flame Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Champion Beetle"] = {
        Idle = "rbxassetid://119223203218217",
        Walk = "rbxassetid://119223203218217",
        Fight = "rbxassetid://81518878788978"
    },
    Calico = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://136807561780379"
    },
    ["German Shepherd"] = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    ["Goblin Gardener"] = {
        Idle = "rbxassetid://117369583070457",
        Walk = "rbxassetid://120721854346874",
        Carry = "rbxassetid://120721854346874"
    },
    ["Galah Cockatoo"] = {
        Walk = "rbxassetid://110356736658981",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Albino Peacock"] = {
        Walk = "rbxassetid://101301427298854",
        Fan = "rbxassetid://73915703683838"
    },
    Lioness = {
        Idle = "rbxassetid://127030702558345",
        Walk = "rbxassetid://80530021817282",
        Roar = "rbxassetid://131398673745689"
    },
    ["White Tiger"] = {
        Idle = "rbxassetid://79938940309796",
        Walk = "rbxassetid://137862666039684",
        Roar = "rbxassetid://114105373171031"
    },
    ["Diamond Dragonfly"] = {
        Walk = "rbxassetid://88913485838830"
    },
    ["Blue Whale"] = {
        Idle = "rbxassetid://116632594655053",
        Walk = "rbxassetid://122054589321582",
        Open = "rbxassetid://104329300330097",
        Splash = "rbxassetid://79571885012155"
    },
    ["Giant Scorpion"] = {
        Idle = "rbxassetid://106474097207512",
        Walk = "rbxassetid://96251861810394",
        Sting = "rbxassetid://98742685113348"
    },
    ["Wind Wyvern"] = {
        Idle = "rbxassetid://130760149861766",
        Walk = "rbxassetid://139675502965586",
        Fly = "rbxassetid://105501964971134",
        FlyDown = "rbxassetid://73670628853664",
        FlyUp = "rbxassetid://94502358646601",
        Breathe = "rbxassetid://130760149861766"
    },
    Firemite = {
        Idle = "rbxassetid://134102069484376",
        Walk = "rbxassetid://134102069484376",
        Zap = "rbxassetid://100164836309395"
    },
    ["Ash Raven"] = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    Hazehound = {
        Idle = "rbxassetid://102720496713959",
        Walk = "rbxassetid://97932653282338",
        Bark = "rbxassetid://102720496713959"
    },
    Cerberus = {
        Idle = "rbxassetid://79052433360664",
        Walk = "rbxassetid://135877576192587",
        Triple = "rbxassetid://113089579377393"
    },
    ["GIANT Firemite"] = {
        Idle = "rbxassetid://134102069484376",
        Walk = "rbxassetid://134102069484376",
        Zap = "rbxassetid://100164836309395"
    },
    ["GIANT Ash Raven"] = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Hazehound"] = {
        Idle = "rbxassetid://102720496713959",
        Walk = "rbxassetid://97932653282338",
        Bark = "rbxassetid://102720496713959"
    },
    ["Rainbow Cerberus"] = {
        Idle = "rbxassetid://79052433360664",
        Walk = "rbxassetid://135877576192587",
        Triple = "rbxassetid://113089579377393"
    },
    ["Chocolate Bunny"] = {
        Idle = "rbxassetid://80830019163546",
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    ["Easter Egg Chick"] = {
        Idle = "rbxassetid://82465422567517",
        Walk = "rbxassetid://118517007627299",
        Panic = "rbxassetid://101960802097425"
    },
    ["Marshmallow Lamb"] = {
        Idle = "rbxassetid://86278199448313",
        Walk = "rbxassetid://118517007627299",
        Play = "rbxassetid://84877059114826"
    },
    ["Easter Bunny"] = {
        Idle = "rbxassetid://112923996241477",
        Walk = "rbxassetid://71277102842499",
        Run = "rbxassetid://121162114980794"
    },
    ["Gilded Choc Chocolate Bunny"] = {
        Idle = "rbxassetid://80830019163546",
        Walk = "rbxassetid://117228920028311",
        Chomp = "rbxassetid://91545917920155"
    },
    ["Gilded Choc Easter Egg Chick"] = {
        Idle = "rbxassetid://82465422567517",
        Walk = "rbxassetid://118517007627299",
        Panic = "rbxassetid://101960802097425"
    },
    ["Gilded Choc Marshmallow Lamb"] = {
        Idle = "rbxassetid://86278199448313",
        Walk = "rbxassetid://118517007627299",
        Play = "rbxassetid://84877059114826"
    },
    ["Gilded Choc Easter Bunny"] = {
        Idle = "rbxassetid://112923996241477",
        Walk = "rbxassetid://71277102842499",
        Run = "rbxassetid://121162114980794"
    },
    ["Gummy Bear"] = {
        Idle = "rbxassetid://100399217826845",
        Walk = "rbxassetid://100399217826845",
        Roar = "rbxassetid://100918889424478"
    },
    ["Hootise Roll"] = {
        Idle = "rbxassetid://129074703805811",
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://103608467045533",
        FlyDown = "rbxassetid://126267742639216",
        FlyUp = "rbxassetid://113660155265682"
    },
    Beaver = {
        Idle = "rbxassetid://125110758440513",
        Walk = "rbxassetid://94960793853786",
        Carve = "rbxassetid://70369650746251"
    },
    Stork = {
        Idle = "rbxassetid://82305951303457",
        Walk = "rbxassetid://92777857718180",
        Fly = "rbxassetid://106292804465704"
    },
    ["Orchid Mantis"] = {
        Walk = "rbxassetid://84713477229850",
        Idle = "rbxassetid://97641683064349",
        Pray = "rbxassetid://73332209725156"
    },
    ["Candy Squirrel"] = {
        Idle = "rbxassetid://92747344416384",
        Walk = "rbxassetid://73793157974906"
    },
    ["Bloom Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    Jerboa = {
        Idle = "rbxassetid://136068604115329",
        Walk = "rbxassetid://126163627579981",
        Hop = "rbxassetid://127784013290128"
    },
    Nyala = {
        Idle = "rbxassetid://120871790954077",
        Walk = "rbxassetid://112017219694466",
        Feed = "rbxassetid://90421283536087"
    },
    Peryton = {
        Idle = "rbxassetid://131615429435113",
        Walk = "rbxassetid://71804276472695",
        Fly = "rbxassetid://129843153738853",
        FlyDown = "rbxassetid://100787854072194",
        FlyUp = "rbxassetid://100787854072194",
        Screech = "rbxassetid://120728735583575"
    },
    ["Gilded Choc Bloom Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Gilded Choc Jerboa"] = {
        Idle = "rbxassetid://136068604115329",
        Walk = "rbxassetid://126163627579981",
        Hop = "rbxassetid://127784013290128"
    },
    ["Gilded Choc Nyala"] = {
        Idle = "rbxassetid://120871790954077",
        Walk = "rbxassetid://112017219694466",
        Feed = "rbxassetid://90421283536087"
    },
    ["Gilded Choc Peryton"] = {
        Idle = "rbxassetid://131615429435113",
        Walk = "rbxassetid://71804276472695",
        Fly = "rbxassetid://129843153738853",
        FlyDown = "rbxassetid://100787854072194",
        FlyUp = "rbxassetid://100787854072194",
        Screech = "rbxassetid://120728735583575"
    },
    Lyrebird = {
        Idle = "rbxassetid://74217548775765",
        Walk = "rbxassetid://126649294305107",
        Sing = "rbxassetid://134655305101805"
    },
    ["Professor Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    Bumblebee = {
        Idle = "rbxassetid://136324580744789",
        Walk = "rbxassetid://131116875539192",
        Pollinate = "rbxassetid://99031845745055"
    },
    ["Nurse Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Gardener Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Elemental Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Empress Bee"] = {
        Idle = "rbxassetid://138765990879962",
        Walk = "rbxassetid://76443481988578",
        Spin = "rbxassetid://111266870266297",
        Command = "rbxassetid://111266870266297"
    },
    ["Rainbow Bumblebee"] = {
        Idle = "rbxassetid://136324580744789",
        Walk = "rbxassetid://131116875539192",
        Pollinate = "rbxassetid://99031845745055"
    },
    ["Rainbow Nurse Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Rainbow Gardener Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Rainbow Elemental Bee"] = {
        Pollinate = "rbxassetid://99031845745055",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["Rainbow Empress Bee"] = {
        Idle = "rbxassetid://138765990879962",
        Walk = "rbxassetid://76443481988578",
        Spin = "rbxassetid://111266870266297",
        Command = "rbxassetid://111266870266297"
    },
    ["Carpenter Bee"] = {
        Idle = "rbxassetid://136324580744789",
        Walk = "rbxassetid://131116875539192",
        Pollinate = "rbxassetid://99031845745055"
    },
    ["Honey Badger"] = {
        Idle = "rbxassetid://118969927454334",
        Walk = "rbxassetid://98430715188615",
        Eat = "rbxassetid://110740070404541"
    },
    ["Prince Wasp"] = {
        Pollinate = "rbxassetid://99031845745055",
        Sting = "rbxassetid://113403785478319",
        Idle = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://100424552289454",
            Volume = 0.25
        }
    },
    ["King Bee"] = {
        Idle = "rbxassetid://111595060793857",
        Walk = "rbxassetid://87560728207355",
        Bow = "rbxassetid://137998385550572",
        Command = "rbxassetid://117277682220297"
    },
    ["Leaf Insect"] = {
        Idle = "rbxassetid://116963501853429",
        Leaf = "rbxassetid://78238208252226",
        LeafLoop = "rbxassetid://78238208252226",
        Walk = {
            SoundId = "rbxassetid://89739222805831",
            Volume = 0.25
        }
    },
    Quetzal = {
        Idle = "rbxassetid://0",
        Fly = "rbxassetid://105996688632139",
        FlyDown = "rbxassetid://132432689735292",
        FlyUp = "rbxassetid://100380863812391",
        Spin = "rbxassetid://139603946926212",
        Walk = {
            SoundId = "rbxassetid://75956970487459",
            Volume = 0.25
        }
    },
    ["Monitor Lizard"] = {
        Idle = "rbxassetid://101615981759687",
        Walk = "rbxassetid://93264315622775",
        Eat = "rbxassetid://136376920393065"
    },
    ["Moss Wyvern"] = {
        Idle = "rbxassetid://130760149861766",
        Walk = "rbxassetid://139675502965586",
        Fly = "rbxassetid://105501964971134",
        FlyDown = "rbxassetid://73670628853664",
        FlyUp = "rbxassetid://94502358646601",
        Breathe = "rbxassetid://130760149861766"
    },
    ["GIANT Leaf Insect"] = {
        Idle = "rbxassetid://116963501853429",
        Leaf = "rbxassetid://78238208252226",
        LeafLoop = "rbxassetid://78238208252226",
        Walk = {
            SoundId = "rbxassetid://89739222805831",
            Volume = 0.25
        }
    },
    ["GIANT Quetzal"] = {
        Idle = "rbxassetid://0",
        Fly = "rbxassetid://105996688632139",
        FlyDown = "rbxassetid://132432689735292",
        FlyUp = "rbxassetid://100380863812391",
        Spin = "rbxassetid://139603946926212",
        Walk = {
            SoundId = "rbxassetid://75956970487459",
            Volume = 0.25
        }
    },
    ["Rainbow Monitor Lizard"] = {
        Idle = "rbxassetid://101615981759687",
        Walk = "rbxassetid://93264315622775",
        Eat = "rbxassetid://136376920393065"
    },
    ["Rainbow Moss Wyvern"] = {
        Idle = "rbxassetid://130760149861766",
        Walk = "rbxassetid://139675502965586",
        Fly = "rbxassetid://105501964971134",
        FlyDown = "rbxassetid://73670628853664",
        FlyUp = "rbxassetid://94502358646601",
        Breathe = "rbxassetid://130760149861766"
    },
    ["Black Spotty Dragon"] = {
        Idle = "rbxassetid://130760149861766",
        Walk = "rbxassetid://139675502965586",
        Fly = "rbxassetid://105501964971134",
        FlyDown = "rbxassetid://73670628853664",
        FlyUp = "rbxassetid://94502358646601",
        Breathe = "rbxassetid://130760149861766"
    },
    Cicada = {
        Idle = "rbxassetid://129784257208359",
        Walk = "rbxassetid://75555525736774",
        Buzz = "rbxassetid://134663313559598"
    },
    Newt = {
        Idle = "rbxassetid://125531726119452",
        Walk = "rbxassetid://124907327406485"
    },
    Nightjar = {
        Idle = "rbxassetid://127611055791709",
        Walk = "rbxassetid://137654758252045",
        Fly = "rbxassetid://96848430452191",
        FlyDown = "rbxassetid://82421991385909",
        FlyUp = "rbxassetid://131259701063325"
    },
    ["Fire Wisp"] = {
        Idle = "rbxassetid://110704895116462",
        Walk = "rbxassetid://110704895116462",
        Ascend = "rbxassetid://106709145459724"
    },
    ["Rainbow Cicada"] = {
        Idle = "rbxassetid://129784257208359",
        Walk = "rbxassetid://127042403783291",
        Buzz = "rbxassetid://134663313559598"
    },
    ["Rainbow Newt"] = {
        Idle = "rbxassetid://125531726119452",
        Walk = "rbxassetid://124907327406485"
    },
    ["Rainbow Nightjar"] = {
        Idle = "rbxassetid://127611055791709",
        Walk = "rbxassetid://137654758252045",
        Fly = "rbxassetid://96848430452191",
        FlyDown = "rbxassetid://82421991385909",
        FlyUp = "rbxassetid://131259701063325"
    },
    ["Rainbow Fire Wisp"] = {
        Idle = "rbxassetid://110704895116462",
        Walk = "rbxassetid://127042403783291",
        Ascend = "rbxassetid://106709145459724"
    },
    ["Flame Bear"] = {
        Idle = "rbxassetid://100399217826845",
        Walk = "rbxassetid://100399217826845",
        Roar = "rbxassetid://100918889424478"
    },
    ["Shadow Cat"] = {
        Walk = "rbxassetid://75691085685258",
        Nap = "rbxassetid://136807561780379"
    },
    Shark = {
        Idle = "rbxassetid://108136730193155",
        Walk = "rbxassetid://108136730193155",
        Bite = "rbxassetid://114624433670754"
    },
    Canary = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Electric Eel"] = {
        Idle = "rbxassetid://96627905384303",
        Walk = "rbxassetid://76778554615674",
        Shock = "rbxassetid://75544917054556"
    },
    Kirin = {
        Idle = "rbxassetid://106862254590358",
        Walk = "rbxassetid://123371144063636",
        Dash = "rbxassetid://86577632109368"
    },
    Thunderbird = {
        Idle = "rbxassetid://102096908900822",
        Walk = "rbxassetid://102096908900822",
        Shock = "rbxassetid://139097104624092"
    },
    ["GIANT Canary"] = {
        Idle = "rbxassetid://136788955816392",
        Walk = "rbxassetid://84761067991330",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["GIANT Electric Eel"] = {
        Idle = "rbxassetid://96627905384303",
        Walk = "rbxassetid://76778554615674",
        Shock = "rbxassetid://75544917054556"
    },
    ["Rainbow Kirin"] = {
        Idle = "rbxassetid://106862254590358",
        Walk = "rbxassetid://123371144063636",
        Dash = "rbxassetid://86577632109368"
    },
    ["Rainbow Thunderbird"] = {
        Idle = "rbxassetid://102096908900822",
        Walk = "rbxassetid://102096908900822",
        Shock = "rbxassetid://139097104624092"
    },
    Bison = {
        Idle = "rbxassetid://127227237399300",
        Walk = "rbxassetid://100344775945109",
        Run = "rbxassetid://74248314216026",
        Charge = "rbxassetid://120331924814733"
    },
    ["Sea Anemone"] = {
        Idle = {
            SoundId = "rbxassetid://127584301059260",
            Volume = 0.1
        },
        Walk = {
            SoundId = "rbxassetid://82878662393601",
            Volume = 0.1
        }
    },
    Seahorse = {
        Idle = {
            SoundId = "rbxassetid://134783279693703",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://97807222960818",
            Volume = 0.25
        },
        Bubble = {
            SoundId = "rbxassetid://84109746155297",
            Volume = 0.25
        }
    },
    ["Hermit Crab"] = {
        Walk = {
            SoundId = "rbxassetid://103907290147431",
            Volume = 0.5
        },
        Pinch = {
            SoundId = "rbxassetid://85991076501996",
            Volume = 0.5
        }
    },
    Orca = {
        Idle = "rbxassetid://114736867335883",
        Walk = "rbxassetid://114736867335883",
        Splash = "rbxassetid://136671939470608"
    },
    ["Tidal Sea Anemone"] = {
        Idle = {
            SoundId = "rbxassetid://127584301059260",
            Volume = 0.1
        },
        Walk = {
            SoundId = "rbxassetid://82878662393601",
            Volume = 0.1
        }
    },
    ["Tidal Seahorse"] = {
        Idle = {
            SoundId = "rbxassetid://134783279693703",
            Volume = 0.25
        },
        Walk = {
            SoundId = "rbxassetid://97807222960818",
            Volume = 0.25
        },
        Bubble = {
            SoundId = "rbxassetid://84109746155297",
            Volume = 0.25
        }
    },
    ["Tidal Hermit Crab"] = {
        Walk = {
            SoundId = "rbxassetid://103907290147431",
            Volume = 0.5
        },
        Pinch = {
            SoundId = "rbxassetid://85991076501996",
            Volume = 0.5
        }
    },
    ["Tidal Orca"] = {
        Idle = "rbxassetid://114736867335883",
        Walk = "rbxassetid://114736867335883",
        Splash = "rbxassetid://136671939470608"
    },
    ["Sea Urchin"] = {
        Idle = "rbxassetid://110505008065975",
        Walk = "rbxassetid://131000528240929"
    },
    Pelican = {
        Idle = "rbxassetid://117471622114903",
        Walk = "rbxassetid://91927011367552",
        Eat = "rbxassetid://129994917338347"
    },
    Walrus = {
        Idle = "rbxassetid://80466864049400",
        Walk = "rbxassetid://116931778673601",
        Clap = "rbxassetid://96832527010597"
    },
    ["Manta Ray"] = {
        Idle = "rbxassetid://94963134022544",
        Walk = "rbxassetid://110863621925842",
        Spin = "rbxassetid://84472598139191"
    },
    ["Sandcastle Crab"] = {
        Walk = {
            SoundId = "rbxassetid://103907290147431",
            Volume = 0.5
        },
        Pinch = {
            SoundId = "rbxassetid://85991076501996",
            Volume = 0.5
        }
    },
    Jellyfish = {
        Idle = "rbxassetid://116402801615301",
        Walk = "rbxassetid://138365732826428",
        Sting = "rbxassetid://110724592548435"
    },
    Hippocampus = {
        Idle = "rbxassetid://103853166195982",
        Walk = "rbxassetid://119493083752735",
        Tail = "rbxassetid://116936715254421"
    },
    Nautilus = {
        Idle = "rbxassetid://79234631769984",
        Walk = "rbxassetid://103346921347874",
        Spin = "rbxassetid://82495674580538"
    },
    Dolphin = {
        Idle = "rbxassetid://117789839126020",
        Walk = "rbxassetid://79775962391352",
        Flip = "rbxassetid://101072009659111"
    },
    Opossum = {
        Idle = "rbxassetid://135217895415649",
        Walk = "rbxassetid://72746742393830"
    },
    ["Lunar Moth"] = {
        Idle = "rbxassetid://79800649815691",
        Walk = "rbxassetid://127482827344286",
        Sing = "rbxassetid://77071003679880"
    },
    ["Night Horse"] = {
        Idle = "rbxassetid://103114730568735",
        Walk = "rbxassetid://134163636378156",
        Run = "rbxassetid://82658544109844",
        Stand = "rbxassetid://79626217950308"
    },
    ["Moon Dragon"] = {
        Idle = "rbxassetid://130760149861766",
        Walk = "rbxassetid://139675502965586",
        Fly = "rbxassetid://105501964971134",
        FlyDown = "rbxassetid://73670628853664",
        FlyUp = "rbxassetid://94502358646601",
        Breathe = "rbxassetid://130760149861766"
    },
    ["Starry Opossum"] = {
        Idle = "rbxassetid://135217895415649",
        Walk = "rbxassetid://72746742393830"
    },
    ["Starry Lunar Moth"] = {
        Idle = "rbxassetid://79800649815691",
        Walk = "rbxassetid://127482827344286",
        Sing = "rbxassetid://77071003679880"
    },
    ["Starry Night Horse"] = {
        Idle = "rbxassetid://103114730568735",
        Walk = "rbxassetid://134163636378156",
        Run = "rbxassetid://82658544109844",
        Stand = "rbxassetid://79626217950308"
    },
    ["Starry Moon Dragon"] = {
        Idle = "rbxassetid://130760149861766",
        Walk = "rbxassetid://139675502965586",
        Fly = "rbxassetid://105501964971134",
        FlyDown = "rbxassetid://73670628853664",
        FlyUp = "rbxassetid://94502358646601",
        Breathe = "rbxassetid://130760149861766"
    },
    ["Vampire Squid"] = {
        Idle = "rbxassetid://140611920609147",
        Walk = "rbxassetid://80936143584994",
        Suck = "rbxassetid://87092788231176"
    },
    ["Cactus Mouse"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644",
        Carve = "rbxassetid://134576216190254"
    },
    ["Desert Tortoise"] = {
        Walk = "rbxassetid://95903584684041"
    },
    Anubis = {
        Idle = "rbxassetid://119874616318471",
        Walk = "rbxassetid://90125616261659",
        Strike = "rbxassetid://72178819857341"
    },
    ["Sand Wyrm"] = {
        Idle = "rbxassetid://102094280039848",
        Walk = "rbxassetid://73667744473410",
        Burrow = "rbxassetid://102094280039848",
        BurrowWalk = "rbxassetid://82270613678462",
        Rise = "rbxassetid://102094280039848"
    },
    ["GIANT Cactus Mouse"] = {
        Idle = "rbxassetid://109690099689968",
        Walk = "rbxassetid://95888740536644",
        Carve = "rbxassetid://134576216190254"
    },
    ["GIANT Desert Tortoise"] = {
        Walk = "rbxassetid://95903584684041"
    },
    ["Rainbow Anubis"] = {
        Idle = "rbxassetid://119874616318471",
        Walk = "rbxassetid://90125616261659",
        Strike = "rbxassetid://72178819857341"
    },
    ["Rainbow Sand Wyrm"] = {
        Idle = "rbxassetid://102094280039848",
        Walk = "rbxassetid://73667744473410",
        Burrow = "rbxassetid://102094280039848",
        BurrowWalk = "rbxassetid://82270613678462",
        Rise = "rbxassetid://102094280039848"
    },
    ["Moon Snail"] = {
        Idle = "rbxassetid://123370432487085"
    },
    Anglerfish = {
        Idle = "rbxassetid://93370092833396",
        Walk = "rbxassetid://124429042220217",
        Bite = "rbxassetid://131428948699414"
    },
    ["Wise Owl"] = {
        Idle = "rbxassetid://129074703805811",
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Rainbow Moon Snail"] = {
        Idle = "rbxassetid://123370432487085"
    },
    ["Rainbow Anglerfish"] = {
        Idle = "rbxassetid://93370092833396",
        Walk = "rbxassetid://124429042220217",
        Bite = "rbxassetid://131428948699414"
    },
    ["Rainbow Wise Owl"] = {
        Walk = "rbxassetid://72938304206168",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Wheat Crow"] = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Harvest Golem"] = {
        Idle = "rbxassetid://116130981349572",
        Walk = "rbxassetid://109443639160889",
        Smash = "rbxassetid://122891830446328"
    },
    ["Wooly Mammoth"] = {
        Walk = "rbxassetid://128582506038245",
        Trunk = "rbxassetid://102693681114060"
    },
    Goose = {
        Idle = "rbxassetid://129053065867617",
        Walk = "rbxassetid://96746435324653",
        Lay = "rbxassetid://139495366690864"
    },
    ["Vine Serpent"] = {
        Idle = "rbxassetid://75501211177631",
        Walk = "rbxassetid://106280386832026"
    },
    ["Cloud Sprite"] = {
        Idle = "rbxassetid://70880859489431",
        Walk = "rbxassetid://84102770397001",
        Glimmer = "rbxassetid://126067355158115"
    },
    Jabberwock = {
        Walk = "rbxassetid://75699537119433",
        Scare = "rbxassetid://108994588571013"
    },
    ["Rainbow Goose"] = {
        Idle = "rbxassetid://129053065867617",
        Walk = "rbxassetid://96746435324653",
        Lay = "rbxassetid://139495366690864"
    },
    ["Rainbow Vine Serpent"] = {
        Idle = "rbxassetid://75501211177631",
        Walk = "rbxassetid://106280386832026"
    },
    ["Rainbow Cloud Sprite"] = {
        Idle = "rbxassetid://70880859489431",
        Walk = "rbxassetid://84102770397001",
        Glimmer = "rbxassetid://126067355158115"
    },
    ["Rainbow Jabberwock"] = {
        Walk = "rbxassetid://75699537119433",
        Scare = "rbxassetid://108994588571013"
    },
    Sheep = {
        Idle = "rbxassetid://114764847530472",
        Walk = "rbxassetid://83384733630721",
        Eat = "rbxassetid://118763986964906"
    },
    ["Cloud Hound"] = {
        Idle = "rbxassetid://102720496713959",
        Walk = "rbxassetid://97932653282338",
        Bark = "rbxassetid://102720496713959"
    },
    ["Chest Mimic"] = {
        Walk = "rbxassetid://120163575521197",
        Bite = "rbxassetid://71614889519880"
    },
    ["Rainbow Sheep"] = {
        Idle = "rbxassetid://114764847530472",
        Walk = "rbxassetid://83384733630721",
        Eat = "rbxassetid://118763986964906"
    },
    ["Rainbow Cloud Hound"] = {
        Idle = "rbxassetid://102720496713959",
        Walk = "rbxassetid://97932653282338",
        Bark = "rbxassetid://102720496713959"
    },
    ["Rainbow Chest Mimic"] = {
        Walk = "rbxassetid://120163575521197",
        Bite = "rbxassetid://71614889519880"
    },
    ["Beanstalk Bear"] = {
        Idle = "rbxassetid://100399217826845",
        Roar = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    ["Scarf Dog"] = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    Skunk = {
        Idle = "rbxassetid://111909256457584",
        Walk = "rbxassetid://71407740674454",
        Stink = "rbxassetid://104053151773289"
    },
    Llama = {
        Idle = "rbxassetid://100255777925822",
        Walk = "rbxassetid://137394557939661",
        Run = "rbxassetid://97358177175637"
    },
    Enfield = {
        Idle = "rbxassetid://77750028157000",
        Walk = "rbxassetid://126806962045844",
        Jump = "rbxassetid://115116184764635"
    },
    ["Rainbow Scarf Dog"] = {
        Walk = "rbxassetid://95883386499521",
        Dig = "rbxassetid://82347082239944"
    },
    ["Rainbow Skunk"] = {
        Idle = "rbxassetid://111909256457584",
        Walk = "rbxassetid://71407740674454",
        Stink = "rbxassetid://104053151773289"
    },
    ["Rainbow Llama"] = {
        Idle = "rbxassetid://100255777925822",
        Walk = "rbxassetid://137394557939661",
        Run = "rbxassetid://97358177175637"
    },
    ["Rainbow Enfield"] = {
        Idle = "rbxassetid://77750028157000",
        Walk = "rbxassetid://126806962045844",
        Jump = "rbxassetid://115116184764635"
    },
    ["Scarf Crow"] = {
        Idle = "rbxassetid://98519985813095",
        Walk = "rbxassetid://126204755611802",
        Fly = "rbxassetid://120628386657802",
        FlyDown = "rbxassetid://95783055449423",
        FlyUp = "rbxassetid://132476910449834"
    },
    ["Golden Raccoon"] = {
        Idle = "rbxassetid://134230704254748",
        Walk = "rbxassetid://72260807159974",
        Steal = "rbxassetid://98750147885192"
    },
    Wolpertinger = {
        Idle = "rbxassetid://87922529822496",
        Walk = "rbxassetid://110959225802713",
        Fly = "rbxassetid://76500887589368"
    },
    Redcap = {
        Idle = "rbxassetid://134870622683802",
        Walk = "rbxassetid://82070990648664",
        Dance = "rbxassetid://106540353463804"
    },
    Manticore = {
        Idle = "rbxassetid://106071099189411",
        Walk = "rbxassetid://121940995234691",
        Roar = "rbxassetid://130678279055511"
    },
    ["Rainbow Wolpertinger"] = {
        Idle = "rbxassetid://87922529822496",
        Walk = "rbxassetid://110959225802713",
        Fly = "rbxassetid://76500887589368"
    },
    ["Rainbow Redcap"] = {
        Idle = "rbxassetid://134870622683802",
        Walk = "rbxassetid://82070990648664",
        Dance = "rbxassetid://106540353463804"
    },
    ["Rainbow Manticore"] = {
        Idle = "rbxassetid://106071099189411",
        Walk = "rbxassetid://121940995234691",
        Roar = "rbxassetid://130678279055511"
    },
    ["Skull Snail"] = {
        Idle = "rbxassetid://123370432487085"
    },
    ["Lantern Wisp"] = {
        Idle = "rbxassetid://114282495356514",
        Walk = "rbxassetid://121043816008707",
        Spin = "rbxassetid://136319550863763"
    },
    Gargoyle = {
        Idle = "rbxassetid://99016747734492",
        Walk = "rbxassetid://114042345485210",
        Stone = "rbxassetid://84443701695103"
    },
    ["Haunted Knight"] = {
        Idle = "rbxassetid://129873317423050",
        Walk = "rbxassetid://123946719762530",
        Rein = "rbxassetid://115345813866533"
    },
    ["Ghostly Skull Snail"] = {
        Idle = "rbxassetid://123370432487085"
    },
    ["Ghostly Lantern Wisp"] = {
        Idle = "rbxassetid://114282495356514",
        Walk = "rbxassetid://121043816008707",
        Spin = "rbxassetid://136319550863763"
    },
    ["Ghostly Gargoyle"] = {
        Idle = "rbxassetid://99016747734492",
        Walk = "rbxassetid://114042345485210",
        Stone = "rbxassetid://84443701695103"
    },
    ["Ghostly Haunted Knight"] = {
        Idle = "rbxassetid://129873317423050",
        Walk = "rbxassetid://123946719762530",
        Rein = "rbxassetid://115345813866533"
    },
    ["Grave Crab"] = {
        Walk = "rbxassetid://137490397885881",
        Pinch = "rbxassetid://101619248230134"
    },
    ["Frankenstein\'s Bear"] = {
        Roar = "rbxassetid://100918889424478",
        Walk = "rbxassetid://100399217826845"
    },
    ["Eyeball Monster"] = {
        Idle = "rbxassetid://135581439540425",
        Walk = "rbxassetid://92778000728828",
        Gaze = "rbxassetid://139750934216180"
    }
};
local u3 = {};

function u1.new(p4, p5, p6) -- Line: 3070
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.PetType = p4;
    v7.PetModel = p5;
    v7.UUID = p6;
    v7.currentSound = nil;

    return v7;
end;

function u1.playSound(p8, p9) -- Line: 3081
    -- upvalues: u2 (copy), u3 (copy), SoundService (copy)
    if p9 ~= "Idle" and (p8.CurrentAnimationName == p9 and (p8.currentSound and p8.currentSound.Parent)) then
        if not p8.currentSound.IsPlaying then
            p8.currentSound:Play();
        end;

        return;
    end;

    p8:stopSound();
    p8.CurrentAnimationName = p9;
    local v10 = u2[p8.PetType];

    if not v10 then
        return;
    end;

    local v11 = v10[p9];

    if not v11 then
        return;
    end;

    local v12 = 0.5;
    local v13;

    if typeof(v11) == "table" then
        v13 = v11.SoundId;
        v12 = v11.Volume or v12;
    else
        v13 = v11;
    end;

    if not v13 then
        return;
    end;

    if not u3[v13] then
        local Sound = Instance.new("Sound");
        Sound.SoundGroup = SoundService.Music.SFX;
        Sound.SoundId = v13;
        Sound.Volume = v12;
        Sound.RollOffMode = Enum.RollOffMode.Inverse;
        Sound.RollOffMaxDistance = 100;
        Sound.RollOffMinDistance = 5;
        u3[v13] = Sound;
    end;

    local u14 = u3[v13]:Clone();
    u14.SoundGroup = SoundService.Music.SFX;
    u14.Volume = v12;
    u14.Parent = p8.PetModel.PrimaryPart or p8.PetModel;
    u14.Looped = p9 ~= "Idle";

    if p9 == "Walk" then
        u14.Loaded:Connect(function() -- Line: 3129
            -- upvalues: u14 (copy)
            if u14.IsLoaded and u14.TimeLength > 2 then
                u14.TimePosition = math.random() * (u14.TimeLength - 1);
            end;
        end);
    end;

    u14:Play();
    p8.currentSound = u14;
end;

function u1.stopSound(p15) -- Line: 3140
    p15.CurrentAnimationName = nil;

    if p15.currentSound then
        local currentSound = p15.currentSound;
        p15.currentSound = nil;
        local Volume = currentSound.Volume;

        for i = 1, 10 do
            task.delay((i - 1) * 0.1, function() -- Line: 3152
                -- upvalues: currentSound (copy), Volume (copy), i (copy)
                if currentSound then
                    currentSound.Volume = Volume * (1 - i / 10);
                end;
            end);
            local _ = i;
        end;

        task.delay(1, function() -- Line: 3159
            -- upvalues: currentSound (copy)
            if currentSound then
                currentSound:Stop();
                currentSound:Destroy();
            end;
        end);
    end;
end;

function u1.destroy(p16) -- Line: 3168
    p16:stopSound();
end;

return u1;