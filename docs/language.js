if (navigator.language.substring(0, 2) == 'pl') {
    console.log('redirecting to index_pl.html');
    if (!window.location.href.endsWith('index_pl.html'))
        window.location.replace("./index_pl.html");

}