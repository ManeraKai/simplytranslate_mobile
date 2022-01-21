for (const i in langs_list) {
    if (Object.hasOwnProperty.call(langs_list, i)) {
        const item = langs_list[i];
        browser_lang = navigator.language.substring(0, 2)
        supported_lang = item.substring(0, 2)

        if (browser_lang == supported_lang) {
            if (window.location.href.endsWith('index.html'))
                window.location.replace(item + ".html");
            else if (window.location.href.endsWith('simplytranslate_mobile/'))
                window.location.replace(item);
        }
    }
}