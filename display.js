let product = document.getElementsByClassName("product");

let game_list = [
    {
        name        : "Donsol",
        description : "",
        image       : "",
        download    : ""
    },
    {
        name        : "Paint",
        description : "",
        image       : "",
        download    : ""
    },
    {
        name        : "Donsol",
        description : "",
        image       : "",
        download    : ""
    },
    {
        name        : "Image Filter",
        description : "",
        image       : "",
        download    : ""
    },
    {
        name        : "Puzzle",
        description : "",
        image       : "",
        download    : ""
    }
];

let story_list = [];
let img_list = [];

let product_list = [];

let url = document.title.split(' ')[0].toLowerCase();
switch(url) {
    case 'games':
        product_list = game_list
        break;
}

let display = null;

for (let prod = 0; prod < product_list.length; prod++) {
    product[prod].addEventListener('click', _=> {
        if(display == null) {
            display = document.createElement('div')
            display.setAttribute('id', "display_product");
            display.innerHTML = product_list[prod].name;
            document.body.append(display);
        }
    });
}

addEventListener('click', event=> {
    if(event.target.outerHTML.slice(0, 6) == '<body>' && display != null) {
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