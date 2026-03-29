programming=[
    {
        name: "DOS",
        links: [
            {
                name: "DOSBOX (Open Source)",
                ref: "https://dosbox.com"
            },
            {
                name: "Compiler (No Licese Found)",
                ref: "https://medium.com/@axayjha/getting-started-with-masm-8086-assembly-c625478265d8"
                // https://www.mediafire.com/file/mm7cjztce9efj4w/8086.zip
            }
        ],
        content:[
            {
                name: "Donsol",
                description: "This is a copy of donsol that is written in MASM for DOS consoles. Credit for the game idea goes to <a href='https://wiki.xxiivv.com/site/donsol.html'>xxiivv</a>",
                parent_path: "Donsol",
                links: ["DONSOL.EXE", "Donsol.asm"]
            },
            {
                name: "Black and White Paint",
                description: "This is a simple system for the DOSBOX where you can move a curser with wasd and shade with 01234",
                parent_path: "BW_Paint",
                links: ["BW_PAINT.EXE", "bw_paint.asm"]
            },
            {
                name: "Scaled Painter",
                description: "This is a simple system for the DOSBOX where you can move a curser with wasd and color with 0-9, a-f",
                parent_path: "Scaled_Painter",
                links: ["SCALE_~1.EXE", "scale_paint.asm"
                ]
            },
            {
                name: "RPG",
                description: "An RPG with simple movement and sprites",
                parent_path: "RPG_V2",
                links: ["RPG.EXE", "rpg.asm"]
            }
        ]
    }, // DOS
    {
        name: "Java",
        links: [
            {
                name: "Java 11 GA (build 11+28) (GNU, version 2 License)",
                ref: "https://jdk.java.net/archive/"
            }
        ],
        content: [
            {
                name: "Donsol",
                description: "This is a copy of Donsol written in Java. Credit for the game idea goes to <a href='https://wiki.xxiivv.com/site/donsol.html'>xxiivv</a>",
            },
            {
                name: "Puzzle",
                description: "Select an image and play a puzzle where you swap sections of an image to recreate",
            },
            {
                name: "Slots",
                description: "Simple slots game with icons designed using Krita (GPL v3)"
            },
            {
                name: "Image Writer",
                description: "This will grab an image and convert it into a factorio blueprint"
            },
            {
                name: "Tile Matcher",
                description: "Simple token matcher with the tokens from <a href='https://jinhzaki.itch.io/minerals-pack-free-32x32'>Itsumi Len</a>"
            },
            {
                name: "Accordian",
                description: "A solitaire game where you match either suit or face. Draw cards and the moves are leftward 1 or 3 spaces"
            },
            {
                name: "Calendar Creator",
                description: "This is an app that can make a calendar. You will need a txt file named <a href='Games/Java/CalendarCreator/special_days.txt'>special_days.txt</a> if you want to add birthdays and holidays. Formatting the file is found in the txt file.<br>Image editing section you can add images with left click on the panel, move around by dragging the panel or wasd if the panel is the focus.<br>The image can (f)lip, be (del)eted, and scaled. Reset focus with (esc). You can see a smaller version with (space) if the panel is the focus"
            },
            {
                name: "Chess",
                description: "This is chess written in Java. The icons are from <a href='https://greenchess.net/info.php?item=downloads'>Green Chess</a>"
            },
            {
                name: "Image Filter",
                description: "This is a newer system for adding filters on an image combining from earlier versions that are now deleted."
            },
            {
                name: "Rock Paper Scissors",
                description: "This is a tester project that was to teach me a little about Java Sockets.",
                parent_path: "RPS",
                links: [
                    {
                        name: "Server",
                        ref: "RPS.java"
                    },
                    {
                        name: "Client",
                        ref: "Player.java"
                    }
                ]
            },
            {
                name: "MP RPG",
                description: "A simple start to local multiplayer RPG.<br> To access the server you will need to add a line to the command which is the name of the computer.<br> This is shown when you run the server.",
                parent_path: "MP_RPG",
                links: [
                    {
                        name: "Server",
                        ref: "Server.jar"
                    },
                    {
                        name: "Client",
                        ref: "Client.jar"
                    },
                    {
                        name: "Download",
                        ref: "MP_RPG.zip"
                    }
                ]
            },
            {
                name: "Compliance Test",
                description: "I recently signed a document that held some stuff on all programs that are made while working for them is theirs.<br>Since it is their property, by me posting this, I am sharing their content, which I am refrained from doing",
                parent_path: "ComplianceTest",
                links:[{name:"Tester", ref:"ComplianceTest.java"}]
            }
        ]
    }, // Java
    {
        name: "Defold",
        links: [
            {
                name: "Defold",
                ref: "https://defold.com"
            },
            {
                name: "Apache 2 Dericative license",
                ref: "https:/defolf.com/license/"
            },
            {
                name: "Other",
                ref: "https://github.com/defold/defold/blob/dev/COMPLYING_WITH_LICENSES.md"
            }
        ],
        content: [
            {
                name: "Gravity Jumper",
                description: "A simple platformer that you can control gravity",
                types: ["Web"]
            },
            {
                name: "Toy Catcher",
                description: "Catch as much toys while avoiding the coal then hear the winning songs",
                types: ["Web", "Android"]
            }
        ]
    } // Defold
]

stories=[
    "Gnome Murder",
    "Lost and Frozen",
    "Zombification",
    "Haunted Maize Maze",
    "Self Worth vs Self Doubt",
    "The Downtown Crash"
]