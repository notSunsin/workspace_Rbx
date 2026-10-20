-- Decompiled with Potassium's decompiler.

return {
    GlobalSpeedModifier = 1.5,
    Speakers = {
        Jandel = {
            Verified = true,
            Rank = 254,
            Color = Color3.fromRGB(255, 50, 50)
        },
        Scammy = {
            Verified = true,
            Color = Color3.fromRGB(180, 128, 255)
        },
        Jhai = {
            Verified = false,
            Rank = 253,
            Color = Color3.fromRGB(2, 184, 87)
        }
    },
    Dialogues = {
        [1] = {
            Length = "5.7",
            Dialogue = "WELCOME EVERYONE!",
            Speaker = "Jhai"
        },
        [2] = {
            Length = "5.4",
            Dialogue = "it\'s me dj jhai",
            Speaker = "Jhai"
        },
        [3] = {
            Length = "26.4",
            Dialogue = "hope youre all ready for what\'s coming today... thanks for choosing Grow a Garden",
            Speaker = "Jhai"
        },
        [4] = {
            Length = "7.8",
            Dialogue = "let me put on some music",
            Speaker = "Jhai"
        },
        [5] = {
            Length = "9.6",
            Dialogue = "I hope you\'re all hyped",
            Speaker = "Jhai"
        },
        [6] = {
            Length = "10.5",
            Dialogue = "im also announcing todays admin war",
            Speaker = "Jhai"
        },
        [7] = {
            Length = "10.5",
            Dialogue = "let me introduce our guest first...",
            Speaker = "Jhai"
        },
        [8] = {
            Length = "15",
            Dialogue = "everyone, i would like to introduce GOOD BOY SAMMY",
            Speaker = "Jhai",

            Method = function(p1) -- Line: 72, Name: Method
                p1:JandelRestock({
                    Carrot = 10
                });
            end
        },
        [9] = {
            Length = "4.2",
            Dialogue = "wow! DJ Jhai! ",
            Speaker = "Scammy"
        },
        [10] = {
            Length = "14.4",
            Dialogue = "that\'s a great idea... let me write that down...",
            Speaker = "Scammy"
        },
        [11] = {
            Length = "3.6",
            Dialogue = "wow.. really?",
            Speaker = "Jhai"
        },
        [12] = {
            Length = "6.6",
            Dialogue = "right in front of me?!",
            Speaker = "Jhai"
        },
        [13] = {
            Length = "2.1",
            Dialogue = "anyways",
            Speaker = "Jhai"
        },
        [14] = {
            Length = "5.4",
            Dialogue = "Over on the other side",
            Speaker = "Jhai"
        },
        [15] = {
            Length = "8.1",
            Dialogue = "We have none other than JA-",
            Speaker = "Jhai"
        },
        [16] = {
            Length = "2.1",
            Dialogue = "No no! ",
            Speaker = "Scammy"
        },
        [17] = {
            Length = "1.2",
            Dialogue = "what?",
            Speaker = "Jhai"
        },
        [18] = {
            Length = "8.4",
            Dialogue = "I\'m not waiting for this guy",
            Speaker = "Scammy"
        },
        [19] = {
            Length = "8.1",
            Dialogue = "time to summon the cavalry!",
            Speaker = "Scammy"
        },
        [20] = {
            Length = "3",
            Dialogue = "what the-!",
            Speaker = "Jhai"
        },
        [21] = {
            Length = "5.7",
            Dialogue = "we\'re under attack!",
            Speaker = "Jhai"
        },
        [22] = {
            Length = "2.4",
            Dialogue = "muahaha!",
            Speaker = "Scammy"
        },
        [23] = {
            Length = "15",
            Dialogue = "My brainrots are unstoppable! And totally mine! :3",
            Speaker = "Scammy"
        },
        [24] = {
            Length = "15",
            Dialogue = "hiding them among the regular pets... im a genius!",
            Speaker = "Scammy"
        },
        [25] = {
            Length = "13.8",
            Dialogue = "Look! The brainrots are attacking our gardens!",
            Speaker = "Jhai"
        },
        [26] = {
            Length = "1.5",
            Dialogue = "oh no",
            Speaker = "Jhai"
        },
        [27] = {
            Length = "5.7",
            Dialogue = "I can\'t watch this... :( ",
            Speaker = "Jhai"
        },
        [28] = {
            Length = "14.4",
            Dialogue = "take these plant ideas my precious brainrots! :3",
            Speaker = "Scammy"
        },
        [29] = {
            Length = "10.2",
            Dialogue = "They\'re mutating the plants...",
            Speaker = "Jhai"
        },
        [30] = {
            Length = "12",
            Dialogue = "scammy sammy has joined Grow a Garden...",
            Speaker = "Jandel",

            Method = function(p2) -- Line: 187, Name: Method
                p2:JandelRestock({
                    Beanstalk = 5,
                    Watermelon = 5,
                    Bamboo = 13,
                    Cactus = 6
                }, {
                    ["Trading Ticket"] = 2
                });
            end
        },
        [31] = {
            Length = "8.1",
            Dialogue = "this has gone on far enough",
            Speaker = "Jandel"
        },
        [32] = {
            Length = "1.2",
            Dialogue = "Eh??",
            Speaker = "Scammy"
        },
        [33] = {
            Length = "6",
            Dialogue = "is that you jandel?",
            Speaker = "Jhai"
        },
        [34] = {
            Length = "3",
            Dialogue = "Sure is 😈",
            Speaker = "Jandel"
        },
        [35] = {
            Length = "7.5",
            Dialogue = "It\'s too late Jandel! >:D",
            Speaker = "Scammy"
        },
        [36] = {
            Length = "5.1",
            Dialogue = "too late for you!",
            Speaker = "Jandel"
        },
        [37] = {
            Length = "14.7",
            Dialogue = "i will protect the green beans no matter the cost",
            Speaker = "Jandel"
        },
        [38] = {
            Length = "7.5",
            Dialogue = "brainrots, meet my lazer!",
            Speaker = "Jandel"
        },
        [39] = {
            Length = "11.4",
            Dialogue = "MY COPYRIGHT INFRINGING BRAINROTS!!!!!",
            Speaker = "Scammy"
        },
        [40] = {
            Length = "6.3",
            Dialogue = "sick lazers!",
            Speaker = "Jhai"
        },
        [41] = {
            Length = "0.6",
            Dialogue = "🤑",
            Speaker = "Jandel"
        },
        [42] = {
            Length = "5.1",
            Dialogue = "Keep playing Jhai",
            Speaker = "Jandel"
        },
        [43] = {
            Length = "3.3",
            Dialogue = "for sure!",
            Speaker = "Jhai",

            Method = function(p3) -- Line: 262, Name: Method
                p3:JandelRestock({
                    Pepper = 3,
                    Blueberry = 15,
                    Tomato = 12
                }, {
                    ["Advanced Sprinkler"] = 3
                });
            end
        },
        [44] = {
            Length = "5.4",
            Dialogue = "hmm... nice lazers",
            Speaker = "Scammy"
        },
        [45] = {
            Length = "5.1",
            Dialogue = "dont mind if I...",
            Speaker = "Scammy"
        },
        [46] = {
            Length = "6.6",
            Dialogue = "take these for my own?",
            Speaker = "Scammy"
        },
        [47] = {
            Length = "2.7",
            Dialogue = "really...",
            Speaker = "Jandel"
        },
        [48] = {
            Length = "5.7",
            Dialogue = "I DO mind actually!",
            Speaker = "Jandel"
        },
        [49] = {
            Length = "7.8",
            Dialogue = "SCAMMY SAMMY STRIKES AGAIN",
            Speaker = "Jandel"
        },
        [50] = {
            Length = "2.7",
            Dialogue = "Muahaha! ",
            Speaker = "Scammy"
        },
        [51] = {
            Length = "7.2",
            Dialogue = "these lazers are so powerful!!",
            Speaker = "Scammy",

            Method = function(p4) -- Line: 311, Name: Method
                p4:JandelRestock({
                    Cacao = 5,
                    Coconut = 8,
                    Corn = 12
                }, {
                    ["Godly Sprinkler"] = 3,
                    ["Magnifying Glass"] = 1
                });
            end
        },
        [52] = {
            Length = "10.5",
            Dialogue = "im gonna defeat you jandel!",
            Speaker = "Scammy"
        },
        [53] = {
            Length = "0.9",
            Dialogue = "...",
            Speaker = "Jandel"
        },
        [54] = {
            Length = "9.3",
            Dialogue = "AHHHHHHHHH YOOOOOOOOOOOOWCHHHHH",
            Speaker = "Jandel"
        },
        [55] = {
            Length = "6.9",
            Dialogue = "Cant... keep.. staring!",
            Speaker = "Scammy"
        },
        [56] = {
            Length = "4.2",
            Dialogue = "Must... blink!",
            Speaker = "Scammy"
        },
        [57] = {
            Length = "1.5",
            Dialogue = "OUCH!",
            Speaker = "Scammy"
        },
        [58] = {
            Length = "8.7",
            Dialogue = "Lasers are overrated anyways!",
            Speaker = "Scammy"
        },
        [59] = {
            Length = "5.1",
            Dialogue = "Nice work jandel",
            Speaker = "Jhai"
        },
        [60] = {
            Length = "4.2",
            Dialogue = "thanks brother",
            Speaker = "Jandel"
        },
        [61] = {
            Length = "5.4",
            Dialogue = "OP RESTOCK!",
            Speaker = "Jandel",

            Method = function(p5) -- Line: 371, Name: Method
                p5:JandelRestock({
                    Romanesco = 1,
                    ["Elder Strawberry"] = 2,
                    ["Sugar Apple"] = 6,
                    Mushroom = 8,
                    Strawberry = 11
                });
            end
        },
        [62] = {
            Length = "3",
            Dialogue = "No matter!",
            Speaker = "Scammy"
        },
        [63] = {
            Length = "1.2",
            Dialogue = "look",
            Speaker = "Jhai"
        },
        [64] = {
            Length = "11.4",
            Dialogue = "That little raccoon plane is flying by",
            Speaker = "Jhai"
        },
        [65] = {
            Length = "7.2",
            Dialogue = "Oh and it\'s dropping fruit",
            Speaker = "Jhai"
        },
        [66] = {
            Length = "7.5",
            Dialogue = "maybe it switched sides? ",
            Speaker = "Jhai"
        },
        [67] = {
            Length = "0.6",
            Dialogue = "🤑",
            Speaker = "Jandel"
        },
        [68] = {
            Length = "9",
            Dialogue = "welcome to the team little guy",
            Speaker = "Jandel"
        },
        [69] = {
            Length = "8.1",
            Dialogue = "My own pets? Betraying me??",
            Speaker = "Scammy"
        },
        [70] = {
            Length = "3.3",
            Dialogue = "Impossible!",
            Speaker = "Scammy"
        },
        [71] = {
            Length = "6.6",
            Dialogue = "Nice job little buddy",
            Speaker = "Jhai"
        },
        [72] = {
            Length = "3",
            Dialogue = "No matter!",
            Speaker = "Scammy"
        },
        [73] = {
            Length = "16.8",
            Dialogue = "I have more tricks up my sleeve with this magic staff...",
            Speaker = "Scammy"
        },
        [74] = {
            Length = "4.8",
            Dialogue = "Go my beasties!!",
            Speaker = "Scammy"
        },
        [75] = {
            Length = "4.8",
            Dialogue = "STAMPEDE!!!",
            Speaker = "Jhai",

            Method = function(p6) -- Line: 450, Name: Method
                p6:JandelRestock({
                    Coconut = 10,
                    Cactus = 8,
                    ["Dragon Fruit"] = 5
                }, {
                    ["Master Sprinkler"] = 1
                });
            end
        },
        [76] = {
            Length = "1.5",
            Dialogue = "uh oh",
            Speaker = "Jandel"
        },
        [77] = {
            Length = "4.5",
            Dialogue = "this is no good",
            Speaker = "Jandel"
        },
        [78] = {
            Length = "2.4",
            Dialogue = "Muahaha!",
            Speaker = "Scammy"
        },
        [79] = {
            Length = "13.5",
            Dialogue = "you stand no chance for my army of brainrots!",
            Speaker = "Scammy"
        },
        [80] = {
            Length = "6.9",
            Dialogue = "all of grow a garden...",
            Speaker = "Scammy"
        },
        [81] = {
            Length = "9.9",
            Dialogue = "soon mine for the taking! muahaha!",
            Speaker = "Scammy"
        },
        [82] = {
            Length = "27.6",
            Dialogue = "This is even better than when I started doing admin abuse events because of you- I mean MyGame43!",
            Speaker = "Scammy"
        },
        [83] = {
            Length = "0.6",
            Dialogue = ":3",
            Speaker = "Scammy"
        },
        [84] = {
            Length = "9.3",
            Dialogue = "another stock resupply incoming",
            Speaker = "Jhai"
        },
        [85] = {
            Length = "3.6",
            Dialogue = "NOT SO FAST!",
            Speaker = "Scammy"
        },
        [86] = {
            Length = "7.5",
            Dialogue = "I\'ll be taking that!",
            Speaker = "Scammy"
        },
        [87] = {
            Length = "10.2",
            Dialogue = "hey that was for the green beans!!",
            Speaker = "Jandel"
        },
        [88] = {
            Length = "5.4",
            Dialogue = "you can\'t do that!",
            Speaker = "Jhai"
        },
        [89] = {
            Length = "6.3",
            Dialogue = "I can do what I want!",
            Speaker = "Scammy"
        },
        [90] = {
            Length = "4.2",
            Dialogue = "Muahahaha! >:D",
            Speaker = "Scammy"
        },
        [91] = {
            Length = "5.1",
            Dialogue = "Here\'s an idea...",
            Speaker = "Jandel"
        },
        [92] = {
            Length = "4.2",
            Dialogue = "Don\'t do that!",
            Speaker = "Jandel",

            Method = function(p7) -- Line: 544, Name: Method
                p7:JandelRestock({
                    ["Ember Lily"] = 3,
                    Beanstalk = 4
                }, {
                    ["Harvest Tool"] = 5
                });
            end
        },
        [93] = {
            Length = "7.8",
            Dialogue = "Ooh let me write tha- HEY!",
            Speaker = "Scammy"
        },
        [94] = {
            Length = "7.2",
            Dialogue = "You almost got me there!",
            Speaker = "Scammy"
        },
        [95] = {
            Length = "12.9",
            Dialogue = "I gotta do something about this stampede...",
            Speaker = "Jandel"
        },
        [96] = {
            Length = "15.3",
            Dialogue = "theyre too fast for my lasers to work...",
            Speaker = "Jandel"
        },
        [97] = {
            Length = "11.7",
            Dialogue = "exactly! nothing can stop me this time!",
            Speaker = "Scammy"
        },
        [98] = {
            Length = "2.7",
            Dialogue = "Unless...",
            Speaker = "Jandel"
        },
        [99] = {
            Length = "2.7",
            Dialogue = "Try this!",
            Speaker = "Jandel"
        },
        [100] = {
            Length = "5.1",
            Dialogue = "Noo my brainrots!",
            Speaker = "Scammy"
        },
        [101] = {
            Length = "8.4",
            Dialogue = "They\'re all getting warped away",
            Speaker = "Jhai",

            Method = function(p8) -- Line: 597, Name: Method
                p8:JandelRestock({
                    ["Elder Strawberry"] = 1,
                    Mango = 8,
                    Grapes = 13
                }, {
                    ["Grandmaster Sprinkler"] = 1
                });
            end
        },
        [102] = {
            Length = "11.7",
            Dialogue = "You may have taken away my brainrots...",
            Speaker = "Scammy"
        },
        [103] = {
            Length = "6.9",
            Dialogue = "but its too late jandel",
            Speaker = "Scammy"
        },
        [104] = {
            Length = "8.4",
            Dialogue = "ive gathered enough grow a garden magic...",
            Speaker = "Scammy"
        },
        [105] = {
            Length = "6.9",
            Dialogue = "im becoming more powerful!",
            Speaker = "Scammy"
        },
        [106] = {
            Length = "11.4",
            Dialogue = "all this grow a garden power!",
            Speaker = "Scammy"
        },
        [107] = {
            Length = "0.9",
            Dialogue = "...",
            Speaker = "Scammy"
        },
        [108] = {
            Length = "1.8",
            Dialogue = "oh no...",
            Speaker = "Jhai"
        },
        [109] = {
            Length = "6",
            Dialogue = "hes getting stronger",
            Speaker = "Jandel"
        },
        [110] = {
            Length = "9",
            Dialogue = "this is getting out of control",
            Speaker = "Jandel"
        },
        [111] = {
            Length = "2.4",
            Dialogue = "Muahaha!",
            Speaker = "Scammy"
        },
        [112] = {
            Length = "11.4",
            Dialogue = "I\'ve had visions of this moment Jandel",
            Speaker = "Scammy"
        },
        [113] = {
            Length = "9.3",
            Dialogue = "the all powerful GOOD BOY SAMMY",
            Speaker = "Scammy"
        },
        [114] = {
            Length = "13.2",
            Dialogue = "finally destroying JANDEL and GROW A GARDEN!",
            Speaker = "Scammy"
        },
        [115] = {
            Length = "5.1",
            Dialogue = "look out jandel",
            Speaker = "Jhai"
        },
        [116] = {
            Length = "4.2",
            Dialogue = "i can\'t watch",
            Speaker = "Jhai"
        },
        [117] = {
            Length = "0.6",
            Dialogue = "😈",
            Speaker = "Jandel"
        },
        [118] = {
            Length = "4.2",
            Dialogue = "Muahahaha! >:D",
            Speaker = "Scammy"
        },
        [119] = {
            Length = "5.4",
            Dialogue = "This is it Jandel!",
            Speaker = "Scammy"
        },
        [120] = {
            Length = "8.7",
            Dialogue = "Say goodbye to Grow a Garden!",
            Speaker = "Scammy"
        },
        [121] = {
            Length = "13.8",
            Dialogue = "theres one thing u forgot to account for sammy",
            Speaker = "Jandel"
        },
        [122] = {
            Length = "8.1",
            Dialogue = "grow a garden is two things",
            Speaker = "Jandel"
        },
        [123] = {
            Length = "2.4",
            Dialogue = "the game",
            Speaker = "Jandel"
        },
        [124] = {
            Length = "6",
            Dialogue = "but also the PLAYERS",
            Speaker = "Jandel"
        },
        [125] = {
            Length = "12.3",
            Dialogue = "all these green beans you see around here",
            Speaker = "Jandel"
        },
        [126] = {
            Length = "5.4",
            Dialogue = "where is your army",
            Speaker = "Jandel"
        },
        [127] = {
            Length = "1.5",
            Dialogue = "So???",
            Speaker = "Scammy"
        },
        [128] = {
            Length = "5.4",
            Dialogue = "green beans are op",
            Speaker = "Jandel"
        },
        [129] = {
            Length = "3.9",
            Dialogue = "get ready GREEN BEANS!!!!!!",
            Speaker = "Jandel"
        },
        [131] = {
            Length = "4.8",
            Dialogue = "LETS FIGHT BACK!",
            Speaker = "Jandel"
        },
        [132] = {
            Length = "7.8",
            Dialogue = "theres too many of you!!!!",
            Speaker = "Scammy"
        },
        [133] = {
            Length = "3.6",
            Dialogue = "AAAAAAHHHHH!",
            Speaker = "Scammy"
        },
        [134] = {
            Length = "0",
            Dialogue = "you got him!",
            Speaker = "Jhai"
        },
        [135] = {
            Length = "3",
            Dialogue = "not yet...",
            Speaker = "Jandel"
        },
        [136] = {
            Length = "9",
            Dialogue = "its time to end this admin war",
            Speaker = "Jandel"
        },
        [137] = {
            Length = "3.6",
            Dialogue = "SCAMMY SAMMY",
            Speaker = "Jandel"
        },
        [138] = {
            Length = "10.5",
            Dialogue = "I AM BANNING YOU FROM GROW A GARDEN",
            Speaker = "Jandel"
        },
        [139] = {
            Length = "10.8",
            Dialogue = "ack- what a cool idea... i better...",
            Speaker = "Scammy"
        },
        [140] = {
            Length = "5.4",
            Dialogue = "write that down...",
            Speaker = "Scammy"
        },
        [141] = {
            Length = "3.6",
            Dialogue = "jandel look!",
            Speaker = "Jhai",

            Method = function(p9) -- Line: 806, Name: Method
                p9:JandelRestock({
                    ["Burning Bud"] = 4,
                    Carrot = 12,
                    Strawberry = 9,
                    Blueberry = 15
                });
            end
        },
        [142] = {
            Length = "15.9",
            Dialogue = "that little creature was hiding behind good boy sammy",
            Speaker = "Jhai"
        },
        [143] = {
            Length = "4.8",
            Dialogue = "Should we keep him?",
            Speaker = "Jhai"
        },
        [144] = {
            Length = "6.9",
            Dialogue = "he looks friendly, sure",
            Speaker = "Jandel",

            Method = function(p10) -- Line: 829, Name: Method
                p10:JandelRestock({
                    ["Elder Strawberry"] = 3,
                    ["Giant Pinecone"] = 3,
                    Tomato = 12
                }, {
                    ["Levelup Lollipop"] = 3
                });
            end
        },
        [145] = {
            Length = "15.3",
            Dialogue = "looks like one was hiding in my coat pocket as well",
            Speaker = "Jandel"
        },
        [146] = {
            Length = "13.5",
            Dialogue = "woah, theres one hiding in my DJ booth too",
            Speaker = "Jhai"
        },
        [147] = {
            Length = "18.9",
            Dialogue = "for choosing grow a garden and helping us defeat good boy sammy",
            Speaker = "Jandel"
        },
        [148] = {
            Length = "15.9",
            Dialogue = "why don\'t you all keep these friendly fellas as pets?",
            Speaker = "Jandel",

            Method = function(p11) -- Line: 858, Name: Method
                local PetsService = require(game:GetService("ServerScriptService").Modules.PetsServices.PetsService);
                local u12 = { "Peach Wasp", "Apple Gazelle", "Lemon Lion" };

                for _, v in game.Players:GetPlayers() do
                    task.spawn(function() -- Line: 867
                        -- upvalues: u12 (copy), PetsService (copy), v (copy)
                        for i = 1, 3 do
                            local v13 = u12[i];
                            local v14 = Random.new():NextNumber(1, 1.3);

                            if Random.new():NextNumber(1, 1000) == 1000 then
                                v14 = math.random(4, 7);
                            end;

                            PetsService:CreatePet(v, v13, {
                                EggName = "Common",
                                HatchedFrom = "Fake Egg",
                                Level = 1,
                                BaseWeight = v14
                            }, true);
                            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Notification"):FireClient(v, (`You just got a {require(game:GetService("ReplicatedStorage").Modules.Chalk).color(Color3.fromRGB(255, 124, 124)).bold(v13)}! `));
                            local _ = i;
                        end;
                    end);
                end;
            end
        },
        [149] = {
            Length = "0.6",
            Dialogue = "🤑",
            Speaker = "Jandel"
        },
        [150] = {
            Length = "13.5",
            Dialogue = "DJ Jhai thanks for playing those great tunes",
            Speaker = "Jandel"
        },
        [151] = {
            Length = "9.9",
            Dialogue = "really set the battle up well lol",
            Speaker = "Jandel"
        },
        [152] = {
            Length = "6",
            Dialogue = "always happy to help",
            Speaker = "Jhai"
        },
        [153] = {
            Length = "15.9",
            Dialogue = "one last reward for all you green beans.. you really helped today",
            Speaker = "Jandel",

            Method = function(p15) -- Line: 916, Name: Method
                local PetsService = require(game:GetService("ServerScriptService").Modules.PetsServices.PetsService);
                local u16 = { "Green Bean" };

                for _, v in game.Players:GetPlayers() do
                    task.spawn(function() -- Line: 924
                        -- upvalues: u16 (copy), PetsService (copy), v (copy)
                        for i = 1, 1 do
                            local v17 = u16[i];
                            local v18 = Random.new():NextNumber(1, 1.3);

                            if Random.new():NextNumber(1, 1000) == 1000 then
                                v18 = math.random(4, 7);
                            end;

                            PetsService:CreatePet(v, v17, {
                                EggName = "Common",
                                HatchedFrom = "Fake Egg",
                                Level = 1,
                                BaseWeight = v18
                            }, true);
                            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Notification"):FireClient(v, (`You just got a {require(game:GetService("ReplicatedStorage").Modules.Chalk).color(Color3.fromRGB(97, 255, 110)).bold(v17)} PET! `));
                            local _ = i;
                        end;
                    end);
                end;
            end
        },
        [154] = {
            Length = "12.9",
            Dialogue = "thanks as always for choosing grow a garden",
            Speaker = "Jandel"
        }
    }
};