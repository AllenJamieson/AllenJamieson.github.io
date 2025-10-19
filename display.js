let product = document.getElementsByClassName("product");

let game_list = [
    {
        name        : "Donsol",
        description : "This is a copy of donsol that is written in MASM for DOS consoles. Credit for the game idea goes to <a href=https://wiki.xxiivv.com/site/donsol.html>xxiivv</a>",
        image       : ""
    },
    {
        name        : "Black and White Paint",
        description : "This is a simple system for the DOSBOX where you can move a curser with wasd and shade with 01234"
    },
    {
        name        : "Paint",
        description : "This is a simple system for the DOSBOX where you can move a curser with wasd and color with 0-9, a-f",
        image       : ""
    },
    {
        name        : "RPG",
        description : "An RPG with simple movement and sprites",
        image       : ""
    },
    {
        name        : "Donsol",
        description : "This is a copy of Donsol written in Java. Credit for the game idea goes to <a href=https://wiki.xxiivv.com/site/donsol.html>xxiivv</a>",
        image       : ""
    },
    {
        name        : "Image Filter",
        description : "Simple image filter with display max 50 images allowed",
        image       : ""
    },
    {
        name        : "Puzzle",
        description : "Select an image and play a puzzle where you swap sections of an image to recreate",
        image       : ""
    },
    {
        name        : "Slots",
        description : "Simple slots game",
        image       : ""
    },
    {
        name        : "Color Cluster",
        description : "Converts an image into k colors.",
        image       : ""
    },
    {
        name        : "Factorio Image Writer",
        description : "This will grab an image and convert it into a factorio blueprint",
        image       : ""
    },
    {
        name        : "Tile Matcher",
        description : "Simple token matcher with the tokens from https://jinhzaki.itch.io/minerals-pack-free-32x32",
        image       : ""
    },
    {
        name        : "Accordian Game",
        description : "A solitaire game where you match either suit or face. Draw cards and the moves are leftward 1 or 3 spaces",
        image       : ""
    },
    {
        name        : "Calendar Creator",
        description : "This is an app that can make a calendar. You will need a Folder 'Calendar' next to the jar file and a 'special_days.txt' file as well. The special_days.txt must be written with a tag followed by newline then the name:dd/mm/yyyy"
    }
];

let img_list = [];

let product_list = [];

let url = document.title.split(' ')[0].toLowerCase();
console.log(url);
switch(url) {
    case 'games':
        product_list = game_list;
        break;
}
let display = null;

for (let prod = 0; prod < product_list.length; prod++) {
    product[prod].addEventListener('click', event=> {
        if(display == null && event.target.outerHTML.slice(0, 7) != '<a href') {
            display = document.createElement('div');
            display.setAttribute('id', "display_product");
            switch(url) {
                case 'games':
                    display.innerHTML = `<h3>` + product_list[prod].name + `</h3>` + `</br>` + product_list[prod].description;
                    break;
            }
            document.body.append(display);
        }
    });
}

addEventListener('click', event=> {
    if(display != null && event.target.outerHTML.includes("<body>")) {
        display.remove();
        display = null;
    }
});

addEventListener('keyup', event=> {
    if(event.code == "Escape" && display != null) {
        display.remove();
        display = null;
    }
});