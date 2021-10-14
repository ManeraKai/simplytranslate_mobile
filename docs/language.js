if (navigator.language.substring(0, 2) == 'pl') {
    console.log('redirecting to index_pl.html');
    if (window.location.href.endsWith('index.html'))
    window.location.replace("./index_pl.html");
}
else if (navigator.language.substring(0, 2) == 'ar') {
    console.log('redirecting to index_ar.html');
    if (window.location.href.endsWith('index.html'))
    window.location.replace("./index_ar.html");
}

