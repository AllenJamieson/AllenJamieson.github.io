let programming_div = document.getElementById("programming")
let stories_div = document.getElementById("stories")

for (let p = 0; p < programming.length; p++) {
    let program_name = programming[p];
    programming_div.innerHTML += `<h3>${program_name.name}</h3>`
    for (let l = 0; l < program_name.links.length; l++) {
        let link = program_name.links[l];
        programming_div.innerHTML += `<a href='${link.ref}'>${link.name}</a>`
    }
    item_list = document.createElement('div')
    item_list.className = 'group'
    for (let i = 0; i < program_name.content.length; i++) {
        let item = program_name.content[i];
        item_div = document.createElement('div')
        item_div.className = 'item'
        item_list.innerHTML += `<h4>${item.name}</h4>`
        switch (program_name.name) {
            case "DOS":
                item_div.innerHTML += `<a href='Games/DOS/${item.parent_path}/${item.links[0]}'>Download</a>`
                item_div.innerHTML += `<a href='Games/DOS/${item.parent_path}/${item.links[1]}'>Code</a>`
            break;
            case "Java":
                if(item.links) {
                    for (let l = 0; l < item.links.length; l++) {
                        let link = item.links[l];
                        item_div.innerHTML += `<a href='.Games/Java/${item.parent_path}/${link.ref}'>${link.name}</a>`
                    }
                } else {
                    let name = item.name.replace(' ', '')
                    item_div.innerHTML += `<a href='Games/Java/${name}/${name}.jar'>Download</a>`
                    item_div.innerHTML += `<a href='Games/Java/${name}/${name}.zip'>Code</a>`
                }
            break;
            case "Defold":
                let name = item.name.replace(' ', '')
                for (let t = 0; t < item.types.length; t++) {
                    switch (item.types[t]) {
                        case "Web":
                            item_div.innerHTML += `<a href='Games/Defold/${name}/index.html'>Play</a>`
                        break;
                        case "Android":
                            item_div.innerHTML += `<a href='Games/Defold/${name}/${name}.apk'>Android</a>`
                        break;
                    }
                }
                item_div.innerHTML += `<a href='Games/Defold/${name}/${name}.zip'>Code</a>`
            break;
        }
        item_list.append(item_div)
        item_list.innerHTML += `<p>${item.description}</p>`
    }
    programming_div.append(item_list)
}

for (let s = 0; s < stories.length; s++) {
    let story = stories[s];
    stories_div.innerHTML += `<a href='Stories/${story}.txt'>${story}</a>`
}