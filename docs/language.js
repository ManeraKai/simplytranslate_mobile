if (navigator.language.substring(0, 2) == 'pl') {
    // console.log('redirecting to pl.html');
    if (window.location.href.endsWith('index.html'))
        window.location.replace("./pl.html");
    else if (window.location.href.endsWith('simplytranslate_mobile/'))
        window.location.replace("./pl");
}
else if (navigator.language.substring(0, 2) == 'ar') {
    if (window.location.href.endsWith('index.html'))
        window.location.replace("./ar.html");
    else if (window.location.href.endsWith('simplytranslate_mobile/'))
        window.location.replace("./ar");
}

