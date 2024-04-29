let product = document.getElementsByClassName("product");

let game_list = [
    {
        name        : "Donsol",
        description : "",
        image       : ""
    },
    {
        name        : "Paint",
        description : "This is a simple system for the DOSBOX where you can move a curser with wasd and shade with 01234",
        image       : ""
    },
    {
        name        : "Donsol",
        description : "",
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
    }
];

let img_list = [];

let product_list = [];

let url = document.title.split(' ')[0].toLowerCase();
console.log(url);
switch(url) {
    case 'games':
        product_list = game_list
        break;
}
let display = null;

for (let prod = 0; prod < product_list.length; prod++) {
    product[prod].addEventListener('click', event=> {
        if(display == null && event.target.outerHTML.slice(0, 7) != '<a href') {
            console.log("test");
            display = document.createElement('div')
            display.setAttribute('id', "display_product");
            switch(url) {
                case 'games':
                    display.innerHTML = product_list[prod].name + `</br>` + product_list[prod].description;
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