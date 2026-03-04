let content = document.getElementById("content")

programming_div = document.createElement('div')
programming_div.className = 'programming'
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
        console.log(item);
        item_div = document.createElement('div')
        item_div.className = 'item'
        item_div.innerHTML += `<h4>${item.name}`


        item_list.append(item_div)
    }
    programming_div.append(item_list)

}

stories_div = document.createElement('div')
stories_div.className = 'stories'
for (let s = 0; s < stories.length; s++) {
    let story = stories[s];
    stories_div.innerHTML += `<a href='Stories/${story}.txt'>${story}</a>` // TODO IFRAME
}

content.innerHTML += `<h2>Programs</h2>`
content.append(programming_div)
content.innerHTML += `<h2>Stories</h2>`
content.append(stories_div)